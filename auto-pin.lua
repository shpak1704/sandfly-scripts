local manifest = {
  id = 'auto-pin',
  name = 'Auto PIN',
  version = '1.5',
  author = 'shpak',
  minApiVersion = 2,
  testedApiVersion = 5,
  description = 'Enters the PIN from the script settings and taps OK if needed. If the phone is locked and the PIN pad is not shown yet, it first swipes up with two fingers; if the pad is already there, it enters the PIN right away. Run it from the SandFly menu: "Ввести PIN-код" (Enter PIN). If turned on in the settings, it also enters the PIN by itself when the lock screen appears. Interface in Ukrainian.',
  -- java: лише щоб спитати Android, чи заблокований телефон (KeyguardManager).
  -- Без нього скрипт вважає екраном блокування будь-який екран System UI.
  permissions = { 'screen', 'actions', 'speech', 'input', 'java' },
  commands = {
    -- menu = true: SandFly додає команду в своє меню одразу під час встановлення.
    { id = 'enterPin', title = 'Ввести PIN-код', menu = true },
  },
  settings = {
    { key = 'enabled', type = 'switch', title = 'Вводити PIN-код автоматично', summary = 'Коли вмикається екран блокування. Типово вимкнено: код вводиться лише командою «Ввести PIN-код»', default = false },
    { key = 'pin', type = 'text', title = 'PIN-код', summary = '4 або 6 цифр' },
    {
      key = 'pressOk',
      type = 'switch',
      title = 'Натискати OK після введення',
      summary = 'Якщо кнопки OK на екрані немає, цей крок пропускається',
      default = true,
    },
    { key = 'swipeFirst', type = 'switch', title = 'Свайп двома пальцями вгору перед введенням', default = true },
    {
      key = 'settleMs',
      type = 'number',
      title = 'Затримка перед введенням, мс',
      summary = 'Після того як клавіатура перестала рухатись. Типово 250. Якщо цифри губляться, збільште',
    },
    {
      key = 'digitMs',
      type = 'number',
      title = 'Пауза між цифрами, мс',
      summary = 'Типово 120. Якщо вводиться не весь код, збільште',
    },
  },
}

-- Екран блокування Android належить System UI.
local SYSTEMUI = 'com.android.systemui'

-- Скільки чекати на клавіатуру після свайпу і як часто дивитись.
local PAD_TIMEOUT_MS = 4000
local PAD_POLL_MS = 50
local SWIPE_MS = 200
-- Скільки найдовше чекати, поки клавіатура перестане рухатись (анімація появи).
local STABLE_TIMEOUT_MS = 1500
local DEFAULT_SETTLE_MS = 250
local DEFAULT_DIGIT_MS = 120

-- Число з налаштувань від 0 до 3000, або [default], якщо не задано.
local function setting_ms(key, default)
  local value = tonumber(sf.settings.get(key))
  if not value then
    return default
  end
  return math.max(0, math.min(3000, math.floor(value)))
end

-- Підписи кнопки підтвердження на різних телефонах. Латиниця порівнюється без
-- різниці великих і малих літер, кирилиця - як тут написано.
local OK_LABELS = {
  ['OK'] = true, ['ENTER'] = true, ['DONE'] = true, ['CONFIRM'] = true, ['GO'] = true,
  ['ОК'] = true, ['Ок'] = true, ['ок'] = true, ['ОK'] = true, ['OК'] = true,
  ['Ввести'] = true, ['ВВЕСТИ'] = true, ['Ввод'] = true, ['Готово'] = true, ['ГОТОВО'] = true,
  ['Підтвердити'] = true, ['ПІДТВЕРДИТИ'] = true, ['Подтвердить'] = true,
}

local function trim(text)
  return ((text or ''):match('^%s*(.-)%s*$'))
end

local function short_id(item)
  return ((item.id or ''):match('[^/]*$'))
end

-- PIN-код із налаштувань, або nil, якщо він не з 4 чи 6 цифр.
local function configured_pin()
  local pin = trim(tostring(sf.settings.get('pin') or ''))
  if pin:match('^%d%d%d%d$') or pin:match('^%d%d%d%d%d%d$') then
    return pin
  end
end

-- Цифра кнопки: за id (key0..key9 в Android) або за підписом ("1", "2 ABC", "2, АБВ").
local function digit_of(item)
  local d = short_id(item):match('^key(%d)$')
  if d then
    return d
  end
  local label = trim(item.text or item.contentDescription)
  return label:match('^(%d)$') or label:match('^(%d)[%s,]')
end

local function ok_label(text)
  text = trim(text)
  return text ~= '' and (OK_LABELS[text] or OK_LABELS[text:upper()]) or false
end

local function is_ok(item)
  local id = short_id(item):lower()
  if id == 'key_enter' or id == 'ok' or id:match('^ok_') or id:match('_ok$')
      or id:match('confirm') or (id:match('enter') and not id:match('center')) then
    return true
  end
  return ok_label(item.text) or ok_label(item.contentDescription)
end

-- Один пошук по вікну: усі кнопки з цифрами і кнопка OK.
local function scan(root)
  local keys, ok, count = {}, nil, 0
  for _, item in ipairs(root:findAll({ clickable = true }, 200)) do
    local d = digit_of(item)
    if d then
      if not keys[d] then
        keys[d] = item
        count = count + 1
      end
    elseif not ok and is_ok(item) then
      ok = item
    end
  end
  return keys, ok, count
end

-- Шукає цифрову клавіатуру: спершу в активному вікні, потім в інших вікнах System UI.
local function find_pad()
  local root = sf.screen.root()
  if root then
    local keys, ok, count = scan(root)
    if count >= 10 then
      return keys, ok
    end
  end
  for _, window in ipairs(sf.screen.windows() or {}) do
    if window.root and window.root.packageName == SYSTEMUI and not window.active then
      local keys, ok, count = scan(window.root)
      if count >= 10 then
        return keys, ok
      end
    end
  end
end

-- KeyguardManager Android, або false, якщо дістатись до нього не вдалося.
local keyguard_manager = nil

local function get_keyguard_manager()
  if keyguard_manager == nil then
    keyguard_manager = false
    -- Без дозволу java модуля java немає; усе в pcall, щоб тоді просто перейти на запасний спосіб.
    local ok, km = pcall(function()
      local context = java.import('android.app.ActivityThread'):currentApplication()
      return context:getSystemService('keyguard')
    end)
    if ok and km then
      keyguard_manager = km
    else
      sf.log.warn('Автоматичний PIN-код: KeyguardManager недоступний, перевіряю за System UI: ' .. tostring(km))
    end
  end
  return keyguard_manager
end

-- Чи заблокований телефон. Спершу питаємо Android; якщо не вийшло, вважаємо
-- екраном блокування будь-який екран System UI.
local function is_locked()
  local km = get_keyguard_manager()
  if km then
    local ok, locked = pcall(function() return km:isKeyguardLocked() end)
    if ok and type(locked) == 'boolean' then
      return locked
    end
  end
  local root = sf.screen.root()
  return root ~= nil and root.packageName == SYSTEMUI
end

-- Свайп двома пальцями знизу вгору посередині екрана.
local function two_finger_swipe_up()
  local screen = sf.device.info().screen
  local w, h = screen.width, screen.height
  local from_y, to_y = math.floor(h * 0.75), math.floor(h * 0.25)
  local function stroke(x)
    return { points = { { x = x, y = from_y }, { x = x, y = to_y } }, start = 0, duration = SWIPE_MS }
  end
  return sf.touch.gesture({ stroke(math.floor(w * 0.4)), stroke(math.floor(w * 0.6)) })
end

-- Після свайпу дивиться кожні PAD_POLL_MS мс, чи з'явилась клавіатура.
local function wait_for_pad()
  local deadline = sf.clock() + PAD_TIMEOUT_MS
  repeat
    local keys, ok = find_pad()
    if keys then
      return keys, ok
    end
    sf.sleep(PAD_POLL_MS)
  until sf.clock() >= deadline
end

-- Положення кнопки 1 одним рядком, щоб порівнювати між перевірками.
local function bounds_key(keys)
  local b = keys['1'] and keys['1'].bounds
  if not b then
    return ''
  end
  return b.left .. ',' .. b.top .. ',' .. b.right .. ',' .. b.bottom
end

-- Чекає, поки клавіатура перестане виїжджати (кнопка 1 двічі поспіль на тому самому місці),
-- потім ще settleMs, і дає свіжі кнопки.
local function wait_until_ready(keys, ok)
  local deadline = sf.clock() + STABLE_TIMEOUT_MS
  local last = bounds_key(keys)
  while sf.clock() < deadline do
    sf.sleep(PAD_POLL_MS)
    local k, o = find_pad()
    if not k then
      break
    end
    keys, ok = k, o
    local now = bounds_key(keys)
    if now == last then
      break
    end
    last = now
  end
  local settle = setting_ms('settleMs', DEFAULT_SETTLE_MS)
  if settle > 0 then
    sf.sleep(settle)
    local k, o = find_pad()
    if k then
      keys, ok = k, o
    end
  end
  return keys, ok
end

local function press(item)
  if not item:click() then
    item:tap()
  end
end

-- Шукає кнопку OK біля цифрової клавіатури серед усіх елементів, не лише натискних:
-- на деяких телефонах напис "OK" лежить у натискній обгортці без підпису.
-- Піднімається від кнопки 1 до 5 рівнів, поки не знайде.
local function find_ok(keys)
  local node = keys['1']
  local seen = {}
  for _ = 1, 5 do
    node = node and node:parent()
    if not node then
      break
    end
    local items = node:findAll({}, 200)
    for _, item in ipairs(items) do
      if not digit_of(item) and is_ok(item) then
        return item
      end
    end
    seen = items
  end
  -- Не знайшли: пишемо в журнал скрипта, що є біля клавіатури, щоб можна було додати підпис.
  local labels = {}
  for _, item in ipairs(seen) do
    if not digit_of(item) then
      local label = trim(item.text or item.contentDescription)
      local id = short_id(item)
      if label ~= '' or id ~= '' then
        labels[#labels + 1] = id .. '="' .. label .. '"' .. (item.clickable and '*' or '')
      end
      if #labels >= 40 then
        break
      end
    end
  end
  sf.log.info('Кнопку OK не знайдено. Елементи біля клавіатури (* натискні): ' .. table.concat(labels, ', '))
end

-- Натискає OK: сам елемент, якщо він натискний, інакше найближчу натискну обгортку,
-- а якщо й це не вдалося - торкається його на екрані.
local function press_ok(item)
  if item.clickable and item:click() then
    return
  end
  local parent = item
  for _ = 1, 3 do
    parent = parent:parent()
    if not parent then
      break
    end
    if parent.clickable then
      if parent:click() then
        return
      end
      break
    end
  end
  item:tap()
end

local function type_pin(pin, keys, ok)
  local pause = setting_ms('digitMs', DEFAULT_DIGIT_MS)
  for i = 1, #pin do
    if i > 1 and pause > 0 then
      sf.sleep(pause)
    end
    press(keys[pin:sub(i, i)])
  end
  if sf.settings.get('pressOk') ~= false then
    if pause > 0 then
      sf.sleep(pause)
    end
    -- Шукаємо OK уже після цифр: на деяких телефонах вона стає активною лише тоді.
    local fresh = find_ok(keys) or ok
    if fresh then
      sf.log.info('Натискаю OK: ' .. short_id(fresh) .. ' "' .. trim(fresh.text or fresh.contentDescription) .. '"')
      press_ok(fresh)
    end
  end
end

local busy, pending, done, warned = false, false, false, false

-- Введення PIN-коду. Якщо кнопки з цифрами вже є, код вводиться одразу.
-- Якщо їх немає, а телефон заблокований (екран блокування), спершу свайп.
-- swipe: чи можна свайпати в цьому виклику. manual: запущено з меню, тож про невдачу кажемо вголос.
local function unlock(swipe, manual)
  -- Сам, без команди з меню, скрипт вводить код лише на заблокованому телефоні,
  -- щоб не набирати його в набирачі номера чи іншому застосунку з цифрами.
  if not manual and not is_locked() then
    return
  end
  local pin = configured_pin()
  if not pin then
    if manual or not warned then
      warned = true
      sf.speak('Автоматичний PIN-код: задайте в налаштуваннях скрипта код із 4 або 6 цифр', { interrupt = true })
    end
    return
  end
  local keys, ok = find_pad()
  if not keys and swipe and sf.settings.get('swipeFirst') ~= false and is_locked() then
    two_finger_swipe_up()
    keys, ok = wait_for_pad()
  end
  if not keys then
    if manual then
      sf.speak('Не знайшов кнопок PIN-коду', { interrupt = true })
    end
    return
  end
  -- Лише одна автоматична спроба, поки клавіатура на екрані: неправильний код
  -- не повторюється і не блокує телефон. З меню можна спробувати ще раз.
  done = true
  keys, ok = wait_until_ready(keys, ok)
  type_pin(pin, keys, ok)
end

local function run_unlock(swipe, manual)
  pending = false
  if busy then
    return
  end
  if not manual and (done or sf.settings.get('enabled') ~= true) then
    return
  end
  busy = true
  local ok, err = pcall(unlock, swipe, manual)
  busy = false
  if not ok then
    sf.log.warn('Автоматичний PIN-код: ' .. tostring(err))
  end
end

-- Клавіатура могла з'явитись сама (наприклад, після свайпу пальцем): вводимо код без свайпу.
local function schedule()
  if not pending and not busy and not done then
    pending = true
    sf.setTimeout(run_unlock, 0, false, false)
  end
end

local function on_change(event)
  if event.package == SYSTEMUI then
    schedule()
  else
    -- Телефон розблоковано або відкрито інший застосунок: наступного разу знову вводимо код.
    done = false
  end
end

sf.onAppEnter(on_change)
sf.onWindowChange(on_change)
sf.onContentChange(function(event)
  if event.package == SYSTEMUI then
    schedule()
  end
end)

sf.onCommand('enterPin', function()
  run_unlock(true, true)
end)

-- SandFly завантажує скрипти, коли вмикається екран. Якщо телефон заблокований,
-- одразу робимо свайп (якщо кнопок ще немає) і вводимо код.
sf.setTimeout(function()
  if is_locked() then
    run_unlock(true, false)
  else
    schedule()
  end
end, 0)
