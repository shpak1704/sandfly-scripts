local manifest = {
  id = 'timer-stopwatch',
  name = 'Timer and stopwatch',
  version = '1.4',
  author = 'shpak',
  minApiVersion = 5,
  testedApiVersion = 5,
  keepLoaded = true,
  description = 'Countdown timers and stopwatches: ready-made presets, a default one started with a single gesture, spoken and sound alerts at set intervals, pause, several timers at once, voice from SandFly voice profiles, separate sound volume. Works with the screen off: turn on "Keep running with the screen off" on the script page. Interface in Ukrainian.',
  permissions = { 'speech', 'input', 'dialogs', 'java' },
  commands = {
    { id = 'timer', title = 'Таймер: запустити або дізнатися час' },
    { id = 'stopwatch', title = 'Секундомір: запустити або дізнатися час' },
    { id = 'timer_pause', title = 'Таймер: пауза або продовження' },
    { id = 'stopwatch_pause', title = 'Секундомір: пауза або продовження' },
    { id = 'menu', title = 'Таймери і секундоміри', menu = true },
  },
  settings = {
    {
      key = 'voice', type = 'list', title = 'Голос',
      options = { { value = 'sandfly', label = 'Голос SandFly' } },
      default = 'sandfly',
    },
    {
      key = 'rate', type = 'list', title = 'Швидкість (для голосу SandFly)',
      options = {
        { value = '0.75', label = 'Повільніше' },
        { value = '1', label = 'Як у SandFly' },
        { value = '1.25', label = 'Трохи швидше' },
        { value = '1.5', label = 'Швидше' },
        { value = '2', label = 'Дуже швидко' },
      },
      default = '1',
    },
    {
      key = 'pitch', type = 'list', title = 'Висота (для голосу SandFly)',
      options = {
        { value = '0.75', label = 'Нижче' },
        { value = '1', label = 'Як у SandFly' },
        { value = '1.25', label = 'Вище' },
        { value = '1.5', label = 'Значно вище' },
      },
      default = '1',
    },
    {
      key = 'sounds', type = 'button', title = 'Звуки і гучність',
      summary = 'Вибрати і прослухати звук сповіщень та сигнал у кінці',
    },
    {
      key = 'journalMenu', type = 'button', title = 'Журнал помилок',
      summary = 'Вимкнено. Увімкніть, якщо щось працює не так, а потім надішліть журнал автору',
    },
    {
      key = 'alarmRepeats', type = 'list', title = 'Скільки разів повторювати сигнал у кінці',
      summary = 'Будь-який жест скрипта вимикає сигнал раніше',
      options = {
        { value = '1', label = '1 раз' },
        { value = '3', label = '3 рази' },
        { value = '5', label = '5 разів' },
        { value = '10', label = '10 разів' },
      },
      default = '3',
    },
    {
      key = 'vibration', type = 'list', title = 'Вібрація',
      options = { { value = 'on', label = 'Увімкнено' }, { value = 'off', label = 'Вимкнено' } },
      default = 'on',
    },
    {
      key = 'statusTimer', type = 'list', title = 'Що казати, коли питаю про таймер',
      options = {
        { value = 'remaining', label = 'Скільки залишилось' },
        { value = 'remainingEnd', label = 'Скільки залишилось і о котрій закінчиться' },
        { value = 'elapsed', label = 'Скільки минуло' },
        { value = 'both', label = 'Скільки залишилось і скільки минуло' },
      },
      default = 'remaining',
    },
    {
      key = 'statusStopwatch', type = 'list', title = 'Що казати, коли питаю про секундомір',
      summary = 'Скільки залишилось — лише для секундоміра з обмеженням часу; інакше каже, скільки минуло',
      options = {
        { value = 'elapsed', label = 'Скільки минуло' },
        { value = 'elapsedStart', label = 'Скільки минуло і о котрій запущено' },
        { value = 'remaining', label = 'Скільки залишилось' },
        { value = 'both', label = 'Скільки залишилось і скільки минуло' },
      },
      default = 'elapsed',
    },
    {
      key = 'notifyTimer', type = 'list', title = 'Що казати в проміжних сповіщеннях таймера',
      options = {
        { value = 'remaining', label = 'Скільки залишилось' },
        { value = 'elapsed', label = 'Скільки минуло' },
        { value = 'both', label = 'Скільки залишилось і скільки минуло' },
      },
      default = 'remaining',
    },
    {
      key = 'notifyStopwatch', type = 'list', title = 'Що казати в проміжних сповіщеннях секундоміра',
      summary = 'Скільки залишилось — лише для секундоміра з обмеженням часу; інакше каже, скільки минуло',
      options = {
        { value = 'elapsed', label = 'Скільки минуло' },
        { value = 'remaining', label = 'Скільки залишилось' },
        { value = 'both', label = 'Скільки залишилось і скільки минуло' },
      },
      default = 'elapsed',
    },
    {
      key = 'stepHours', type = 'list', title = 'Крок повзунка годин',
      options = {
        { value = '1', label = '1 година' },
        { value = '2', label = '2 години' },
        { value = '3', label = '3 години' },
      },
      default = '1',
    },
    {
      key = 'stepMinutes', type = 'list', title = 'Крок повзунка хвилин',
      options = {
        { value = '1', label = '1 хвилина' },
        { value = '2', label = '2 хвилини' },
        { value = '5', label = '5 хвилин' },
        { value = '10', label = '10 хвилин' },
        { value = '15', label = '15 хвилин' },
      },
      default = '1',
    },
    {
      key = 'stepSeconds', type = 'list', title = 'Крок повзунка секунд',
      options = {
        { value = '1', label = '1 секунда' },
        { value = '5', label = '5 секунд' },
        { value = '10', label = '10 секунд' },
        { value = '15', label = '15 секунд' },
        { value = '30', label = '30 секунд' },
      },
      default = '1',
    },
    {
      key = 'doubleWindow', type = 'list', title = 'Скільки чекати на повторний жест, що зупиняє',
      options = {
        { value = '2', label = '2 секунди' },
        { value = '3', label = '3 секунди' },
        { value = '4', label = '4 секунди' },
        { value = '5', label = '5 секунд' },
      },
      default = '3',
    },
    {
      key = 'defaultEvery', type = 'list', title = 'Проміжок сповіщень, з якого починається «Свій час»',
      options = {
        { value = '0', label = 'Без сповіщень' },
        { value = '60', label = 'Щохвилини' },
        { value = '120', label = 'Кожні 2 хвилини' },
        { value = '300', label = 'Кожні 5 хвилин' },
        { value = '600', label = 'Кожні 10 хвилин' },
        { value = '900', label = 'Кожні 15 хвилин' },
        { value = '1800', label = 'Кожні 30 хвилин' },
      },
      default = '300',
    },
    {
      key = 'screenOnSummary', type = 'list', title = 'Коли вмикається екран',
      options = {
        { value = 'on', label = 'Казати про запущені таймери' },
        { value = 'off', label = 'Нічого не казати' },
      },
      default = 'on',
    },
    {
      key = 'keepAwake', type = 'list', title = 'Поки йде відлік з вимкненим екраном',
      options = {
        { value = 'on', label = 'Не давати телефону засинати (точніше)' },
        { value = 'off', label = 'Дозволити засинати (економніше, сповіщення можуть запізнюватись)' },
      },
      default = 'on',
    },
  },
}

---------------------------------------------------------------------------
-- Текст: відмінки, тривалості
---------------------------------------------------------------------------

-- Ціле число: сховище й повзунки можуть давати числа як 5.0.
local function int(x)
  return math.tointeger(x) or math.floor((tonumber(x) or 0) + 0.5)
end

local function idstr(x)
  return string.format('%d', int(x))
end

local function plural(n, one, few, many)
  local n10, n100 = n % 10, n % 100
  if n10 == 1 and n100 ~= 11 then
    return one
  end
  if n10 >= 2 and n10 <= 4 and (n100 < 12 or n100 > 14) then
    return few
  end
  return many
end

local UNITS = {
  h = { 'година', 'години', 'годин', acc = 'годину', sec = 3600 },
  m = { 'хвилина', 'хвилини', 'хвилин', acc = 'хвилину', sec = 60 },
  s = { 'секунда', 'секунди', 'секунд', acc = 'секунду', sec = 1 },
}

-- «5 хвилин», «0 годин».
local function count_text(n, unit)
  local u = UNITS[unit]
  return n .. ' ' .. plural(n, u[1], u[2], u[3])
end

-- «1 година 5 хвилин 30 секунд». coarse: від години й більше без секунд.
-- acc: знахідний відмінок, «1 хвилину».
local function fmt(sec, coarse, acc)
  sec = math.max(0, int(sec))
  local h, m, s = sec // 3600, (sec % 3600) // 60, sec % 60
  if coarse and h > 0 then
    s = 0
  end
  local parts = {}
  local function add(n, unit)
    local u = UNITS[unit]
    parts[#parts + 1] = n .. ' ' .. plural(n, acc and u.acc or u[1], u[2], u[3])
  end
  if h > 0 then add(h, 'h') end
  if m > 0 then add(m, 'm') end
  if s > 0 or #parts == 0 then add(s, 's') end
  return table.concat(parts, ' ')
end

-- «щохвилини», «кожні 5 хвилин».
local function every_text(sec)
  sec = int(sec)
  if sec == 1 then return 'щосекунди' end
  if sec == 60 then return 'щохвилини' end
  if sec == 3600 then return 'щогодини' end
  return 'кожні ' .. fmt(sec, false, true)
end

local function trim(text)
  return (tostring(text or ''):gsub('^%s+', ''):gsub('%s+$', ''))
end

local function on(key)
  return sf.settings.get(key) ~= 'off'
end

local function clock_text(ms)
  return os.date('%H:%M', int(ms // 1000))
end

---------------------------------------------------------------------------
-- Журнал помилок
---------------------------------------------------------------------------
-- Журнал на сторінці скрипта SandFly тримає лише в пам'яті, і він зникає, якщо SandFly вилетить.
-- Тому, поки користувач не вимкне журнал у меню скрипта, записи ще й лежать у сховищі,
-- і їх можна прочитати, скопіювати або надіслати.

local JOURNAL_MAX = 200
local JOURNAL_LINE_MAX = 800
local LEVEL_WORDS = { info = 'подія', warn = 'увага', error = 'помилка' }

local function journal_on()
  return sf.storage.get('journalOn') == true
end

local function journal_entries()
  local list = sf.storage.get('journal', {})
  return type(list) == 'table' and list or {}
end

-- Пише в журнал SandFly і, якщо журнал увімкнено, у сховище. Однакові записи поспіль
-- не дублюються, а лічаться.
local function jlog(level, text)
  text = tostring(text)
  pcall(sf.log[level] or sf.log.info, text)
  if not journal_on() then
    return
  end
  pcall(function()
    if #text > JOURNAL_LINE_MAX then
      -- Обрізаємо по байтах і прибираємо неповний символ у кінці.
      text = text:sub(1, JOURNAL_LINE_MAX):gsub('[\192-\255][\128-\191]*$', '') .. '…'
    end
    local line = (LEVEL_WORDS[level] or level) .. ': ' .. text
    local list = journal_entries()
    local last = list[#list]
    local at = os.date('%d.%m %H:%M:%S')
    if last and last.line == line then
      last.count = (tonumber(last.count) or 1) + 1
      last.at = at
    else
      list[#list + 1] = { at = at, line = line }
      while #list > JOURNAL_MAX do
        table.remove(list, 1)
      end
    end
    sf.storage.set('journal', list)
  end)
end

-- Обгортка для обробників SandFly: помилка Lua потрапляє в журнал, а далі йде як завжди.
local function guarded(name, fn)
  return function(...)
    local result = table.pack(xpcall(fn, function(e) return e end, ...))
    if not result[1] then
      jlog('error', name .. ': ' .. tostring(result[2]))
      error(result[2], 0)
    end
    return table.unpack(result, 2, result.n)
  end
end

---------------------------------------------------------------------------
-- Java: годинник, будильник, утримання процесора, стан екрана
---------------------------------------------------------------------------

local WAKE_ACTION = 'io.github.sandfly.scripts.timer_stopwatch.WAKE'
local J = {}

local function jinit()
  if J.ready ~= nil then
    return J.ready
  end
  local ok, err = pcall(function()
    J.ctx = java.import('android.app.ActivityThread'):currentApplication()
    J.System = java.import('java.lang.System')
    J.pm = J.ctx:getSystemService('power')
    J.am = J.ctx:getSystemService('alarm')
  end)
  J.ready = ok
  if not ok then
    jlog('warn', 'Java недоступна: ' .. tostring(err))
  end
  return ok
end

local function now_ms()
  if jinit() then
    local ok, value = pcall(function() return J.System:currentTimeMillis() end)
    if ok and value then
      return int(value)
    end
  end
  return os.time() * 1000
end

local function wake_intent()
  if J.pi == nil then
    J.pi = false
    pcall(function()
      local Intent = java.import('android.content.Intent')
      local PendingIntent = java.import('android.app.PendingIntent')
      local intent = java.new(Intent, WAKE_ACTION)
      intent:setPackage(J.ctx:getPackageName())
      J.pi = PendingIntent:getBroadcast(J.ctx, 47213, intent,
        PendingIntent.FLAG_IMMUTABLE | PendingIntent.FLAG_UPDATE_CURRENT)
    end)
  end
  return J.pi
end

local alarm_at = nil

-- Системний будильник будить телефон до події навіть із глибокого сну (як голосовий годинник SandFly),
-- а далі подію ловить щосекундна перевірка.
local function set_wake(at)
  if at == alarm_at or not jinit() then
    return
  end
  local pi = wake_intent()
  if not pi then
    return
  end
  local ok, err = pcall(function()
    if at == nil then
      J.am:cancel(pi)
    elseif sf.device.info().sdk < 31 or J.am:canScheduleExactAlarms() then
      J.am:setExactAndAllowWhileIdle(0, int(at), pi)
    else
      J.am:setAndAllowWhileIdle(0, int(at), pi)
    end
  end)
  if ok then
    alarm_at = at
  else
    jlog('warn', 'Будильник не поставився: ' .. tostring(err))
  end
end

local last_hold = 0

local function hold_cpu(ms)
  if not jinit() then
    return
  end
  pcall(function()
    if not J.wl then
      J.wl = J.pm:newWakeLock(1, 'SandFly:timer-stopwatch')
      J.wl:setReferenceCounted(false)
    end
    -- З обмеженням часу: якщо скрипт вивантажиться, утримання саме закінчиться.
    J.wl:acquire(ms or 120000)
  end)
end

local function release_cpu()
  last_hold = 0
  if J.wl then
    pcall(function()
      if J.wl:isHeld() then
        J.wl:release()
      end
    end)
  end
end

local function is_interactive()
  if not jinit() then
    return true
  end
  local ok, value = pcall(function() return J.pm:isInteractive() end)
  return not ok or value == true
end

-- java.proxy прив'язує проксі до тієї співпрограми Lua, у якій його створено. Команди SandFly
-- виконуються як співпрограми, і поки команда чекає (sf.sleep, вікно), її співпрограма
-- призупинена. Виклик проксі тоді запускає Lua на призупиненій співпрограмі, а Lua 5.4 це
-- забороняє: SandFly падає без жодного винятку Java. Тому проксі створюємо в окремій
-- співпрограмі, яка одразу завершується: завершену можна викликати будь-коли.
local function make_proxy(iface, impl)
  local proxy
  local co = coroutine.create(function()
    proxy = java.proxy(iface, impl)
  end)
  local ok, err = coroutine.resume(co)
  if not ok then
    error(err, 0)
  end
  return proxy
end

local function main_post(fn)
  return pcall(function()
    local Handler = java.import('android.os.Handler')
    local Looper = java.import('android.os.Looper')
    local handler = java.new(Handler, Looper:getMainLooper())
    handler:post(make_proxy('java.lang.Runnable', {
      run = function()
        local ok, err = pcall(fn)
        if not ok then
          jlog('error', 'Головний потік: ' .. tostring(err))
        end
      end,
    }))
  end)
end


---------------------------------------------------------------------------
-- Голос
---------------------------------------------------------------------------

local function prefs()
  local SPU = java.import('com.google.android.accessibility.utils.SharedPreferencesUtils')
  return SPU:getSharedPreferences(J.ctx)
end

-- Голосові профілі SandFly: { { id, name } }.
local function voice_profiles()
  local list = {}
  if not jinit() then
    return list
  end
  pcall(function()
    local VP = java.import('com.google.android.accessibility.utils.output.VoiceProfiles')
    local p = prefs()
    local ids = VP:ids(p)
    for i = 0, ids:size() - 1 do
      local id = tostring(ids:get(i))
      local name = tostring(VP:read(p, id):name())
      list[#list + 1] = { id = id, name = name ~= '' and name or ('Профіль ' .. id) }
    end
  end)
  return list
end

local function sandfly_say(text, interrupt)
  sf.speak(text, {
    interrupt = interrupt,
    rate = tonumber(sf.settings.get('rate')) or 1,
    pitch = tonumber(sf.settings.get('pitch')) or 1,
  })
end

local voice = { obj = nil, profile = nil }

-- Говорить окремим голосом із профілю, як SandFly читає сповіщення. NotificationVoice
-- працює лише в головному потоці SandFly, тож усе через Handler.
local function profile_say(id, text, interrupt)
  if not jinit() then
    return false
  end
  local ok, err = pcall(function()
    local VP = java.import('com.google.android.accessibility.utils.output.VoiceProfiles')
    local p = prefs()
    if not VP:ids(p):contains(id) then
      error('немає профілю ' .. id)
    end
    local profile = VP:read(p, id)
    local posted = main_post(function()
      local spoke = pcall(function()
        if not voice.obj then
          local NV = java.import('com.google.android.accessibility.talkback.notifications.NotificationVoice')
          voice.obj = java.new(NV, J.ctx)
        end
        if voice.profile ~= id then
          voice.obj:use(profile)
          voice.profile = id
        end
        local listener = make_proxy(
          'com.google.android.accessibility.talkback.notifications.NotificationVoice$Listener', {
            onStart = function() end,
            onDone = function() end,
            onUnavailable = function() pcall(sandfly_say, text, false) end,
          })
        voice.obj:speak(text, interrupt == true, nil, listener)
      end)
      if not spoke then
        sandfly_say(text, interrupt)
      end
    end)
    if not posted then
      error('не вдалося передати в головний потік')
    end
  end)
  if not ok then
    jlog('warn', 'Голос профілю недоступний: ' .. tostring(err))
  end
  return ok
end

local function say(text, interrupt)
  if not text or text == '' then
    return
  end
  local v = sf.settings.get('voice') or 'sandfly'
  if v ~= 'sandfly' and profile_say(v, text, interrupt) then
    return
  end
  sandfly_say(text, interrupt)
end

local function refresh_voice_options()
  local options = { { value = 'sandfly', label = 'Голос SandFly' } }
  for _, profile in ipairs(voice_profiles()) do
    options[#options + 1] = { value = profile.id, label = 'Профіль: ' .. profile.name }
  end
  pcall(sf.settings.setOptions, 'voice', options)
end

---------------------------------------------------------------------------
-- Звуки: власне відтворення з гучністю, незалежно від звуків SandFly
---------------------------------------------------------------------------

-- Для вікна «Звуки».
local NOTIFY_SOUNDS = {
  { 'tone', 'Тон' }, { 'double', 'Подвійний тон' }, { 'triple', 'Потрійний тон' }, { 'soft', 'М\'який тон' },
  { 'chime', 'Дзвіночок' }, { 'bell', 'Дзвін' }, { 'dingdong', 'Дінь-дон' }, { 'rising', 'Висхідний' },
  { 'falling', 'Низхідний' }, { 'drop', 'Крапля' }, { 'tick', 'Цокання' }, { 'bubble', 'Бульбашки' },
  { 'sf_beep', 'Сигнал SandFly (без регулювання гучності)' },
  { 'sf_enter', 'Звук входу SandFly (без регулювання гучності)' },
  { 'sf_end', 'Звук кінця списку SandFly (без регулювання гучності)' },
}
local ALARM_SOUNDS = {
  { 'alarm', 'Будильник' }, { 'digital', 'Електронний годинник' }, { 'beeps', 'Часті сигнали' },
  { 'melody', 'Мелодія' }, { 'fanfare', 'Фанфари' }, { 'bells', 'Дзвони' }, { 'siren', 'Сирена' },
  { 'crescendo', 'Наростання' }, { 'sf_beep', 'Сигнал SandFly (без регулювання гучності)' },
}

local SAMPLE_RATE = 22050
-- Ноти: { частота, мс, кінцева частота (ковзання) }; частота 0 — пауза.
-- bell = true — дзвін: обертони і згасання.
local function bell(f, ms) return { f, ms, bell = true } end
local SOUNDS = {
  tone = { { 880, 150 } },
  double = { { 880, 110 }, { 0, 60 }, { 1320, 110 } },
  triple = { { 988, 90 }, { 0, 50 }, { 988, 90 }, { 0, 50 }, { 988, 90 } },
  soft = { { 660, 260 } },
  chime = { { 1047, 140 }, { 1568, 260 } },
  bell = { bell(880, 700) },
  dingdong = { bell(784, 380), bell(622, 600) },
  rising = { { 500, 260, 1200 } },
  falling = { { 1200, 260, 500 } },
  drop = { { 1600, 120, 500 } },
  tick = { { 2000, 25 }, { 0, 110 }, { 1600, 25 } },
  bubble = { { 400, 70, 900 }, { 0, 40 }, { 500, 70, 1100 }, { 0, 40 }, { 600, 70, 1300 } },
  alarm = {
    { 1047, 180 }, { 0, 20 }, { 1319, 180 }, { 0, 20 }, { 1047, 180 }, { 0, 20 },
    { 1319, 180 }, { 0, 20 }, { 1047, 180 }, { 0, 20 }, { 1319, 180 },
  },
  digital = {
    { 2000, 90 }, { 0, 60 }, { 2000, 90 }, { 0, 60 }, { 2000, 90 }, { 0, 60 }, { 2000, 90 }, { 0, 400 },
    { 2000, 90 }, { 0, 60 }, { 2000, 90 }, { 0, 60 }, { 2000, 90 }, { 0, 60 }, { 2000, 90 },
  },
  beeps = { { 1400, 100 }, { 0, 80 }, { 1400, 100 }, { 0, 80 }, { 1400, 100 }, { 0, 80 }, { 1400, 100 } },
  melody = { { 523, 200 }, { 659, 200 }, { 784, 200 }, { 1047, 300 }, { 784, 180 }, { 1047, 420 } },
  fanfare = {
    { 523, 140 }, { 0, 30 }, { 523, 140 }, { 0, 30 }, { 523, 140 }, { 784, 500 }, { 0, 60 }, { 659, 160 }, { 784, 600 },
  },
  bells = { bell(1047, 450), bell(880, 450), bell(784, 450), bell(523, 900) },
  siren = { { 600, 500, 1300 }, { 1300, 500, 600 }, { 600, 500, 1300 }, { 1300, 500, 600 } },
  crescendo = {
    { 400, 250, 700 }, { 0, 60 }, { 500, 250, 900 }, { 0, 60 }, { 600, 250, 1100 }, { 0, 60 }, { 700, 400, 1400 },
  },
}

local function sound_length(name)
  local total = 0
  for _, note in ipairs(SOUNDS[name] or {}) do
    total = total + note[2]
  end
  return total
end

local B64 = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

local function base64(data)
  local out = {}
  for i = 1, #data, 3 do
    local a, b, c = data:byte(i, i + 2)
    local n = (a << 16) | ((b or 0) << 8) | (c or 0)
    local c1, c2 = (n >> 18) & 63, (n >> 12) & 63
    local c3, c4 = (n >> 6) & 63, n & 63
    out[#out + 1] = B64:sub(c1 + 1, c1 + 1) .. B64:sub(c2 + 1, c2 + 1)
      .. (b and B64:sub(c3 + 1, c3 + 1) or '=') .. (c and B64:sub(c4 + 1, c4 + 1) or '=')
  end
  return table.concat(out)
end

-- PCM 16 біт, моно, з плавним початком і кінцем кожної ноти.
local function render(notes)
  local parts = {}
  for _, note in ipairs(notes) do
    local freq, ms, freq2 = note[1], note[2], note[3] or note[1]
    local n = math.floor(ms * SAMPLE_RATE / 1000 + 0.5)
    local fade = math.max(1, math.min(n / 2, SAMPLE_RATE / 200))
    local chunk = {}
    local phase = 0
    for i = 0, n - 1 do
      local v = 0
      if freq > 0 then
        local f = freq + (freq2 - freq) * i / n
        phase = phase + 2 * math.pi * f / SAMPLE_RATE
        local envelope = math.min(1, i / fade, (n - i) / fade)
        if note.bell then
          envelope = math.min(1, i / fade) * math.exp(-4 * i / n)
          v = (math.sin(phase) + 0.5 * math.sin(2.76 * phase) + 0.25 * math.sin(5.4 * phase)) / 1.75
        else
          v = math.sin(phase)
        end
        v = v * envelope * 0.9
      end
      chunk[#chunk + 1] = math.floor(v * 32767)
      if #chunk == 200 then
        parts[#parts + 1] = string.pack('<' .. string.rep('i2', #chunk), table.unpack(chunk))
        chunk = {}
      end
    end
    if #chunk > 0 then
      parts[#parts + 1] = string.pack('<' .. string.rep('i2', #chunk), table.unpack(chunk))
    end
  end
  return table.concat(parts)
end

J.tracks = {}

-- Готує AudioTrack для звуку один раз; далі тільки перезапускає.
local function track_for(name)
  local cached = J.tracks[name]
  if cached ~= nil then
    return cached
  end
  J.tracks[name] = false
  local ok, err = pcall(function()
    local pcm = render(SOUNDS[name])
    local Base64 = java.import('android.util.Base64')
    local bytes = Base64:decode(base64(pcm), 2)
    local attrs = java.new(java.import('android.media.AudioAttributes$Builder'))
      :setUsage(11) -- USAGE_ASSISTANCE_ACCESSIBILITY, як мовлення SandFly
      :setContentType(4) -- CONTENT_TYPE_SONIFICATION
      :build()
    local format = java.new(java.import('android.media.AudioFormat$Builder'))
      :setEncoding(2) -- ENCODING_PCM_16BIT
      :setSampleRate(SAMPLE_RATE)
      :setChannelMask(4) -- CHANNEL_OUT_MONO
      :build()
    local track = java.new(java.import('android.media.AudioTrack$Builder'))
      :setAudioAttributes(attrs)
      :setAudioFormat(format)
      :setTransferMode(0) -- MODE_STATIC
      :setBufferSizeInBytes(#pcm)
      :build()
    track:write(bytes, 0, #pcm)
    J.tracks[name] = track
  end)
  if not ok then
    jlog('warn', 'Не вдалося підготувати звук ' .. name .. ': ' .. tostring(err))
  end
  return J.tracks[name]
end

local function java_play(name, gain)
  if not jinit() then
    return false
  end
  local track = track_for(name)
  if not track then
    return false
  end
  local ok, err = pcall(function()
    if track:getPlayState() == 3 then -- PLAYSTATE_PLAYING
      track:stop()
    end
    track:reloadStaticData()
    track:setVolume(gain)
    track:play()
  end)
  if not ok then
    jlog('warn', 'Звук не відтворився: ' .. tostring(err))
  end
  return ok
end

-- Грає звук із гучністю gain (0..1); повертає, скільки мс він триває.
local function play_sound(name, gain)
  if gain <= 0 then
    return 0
  end
  if name:sub(1, 3) == 'sf_' then
    pcall(sf.playSound, name:sub(4))
    return 400
  end
  if not SOUNDS[name] then
    return 0
  end
  java_play(name, gain)
  return sound_length(name)
end

-- Звуки і гучність вибираються у вікні «Звуки», тож лежать у сховищі, а не в налаштуваннях.
local SOUND_DEFAULTS = { sound = 'tone', soundVolume = '75', alarmSound = 'alarm', alarmVolume = '100' }

local function sound_pref(key)
  local value = sf.storage.get('pref_' .. key)
  if value == nil or value == '' then
    return SOUND_DEFAULTS[key]
  end
  return tostring(value)
end

local function set_sound_pref(key, value)
  sf.storage.set('pref_' .. key, tostring(value))
end

local function volume(key)
  return (tonumber(sound_pref(key)) or 75) / 100
end

local function play_notify()
  play_sound(sound_pref('sound'), volume('soundVolume'))
  if on('vibration') then
    sf.vibrate(80)
  end
end

local function play_alarm()
  local length = play_sound(sound_pref('alarmSound'), volume('alarmVolume'))
  if on('vibration') then
    sf.vibrate({ 400, 200, 400, 200, 400 })
  end
  return math.max(length, 300)
end

---------------------------------------------------------------------------
-- Меню з кнопок (без перемикачів)
---------------------------------------------------------------------------

-- options: { { value, label } }. Повертає вибране значення або nil.
local function menu(title, options)
  local picked = nil
  local items = {}
  for i, option in ipairs(options) do
    if i > 48 then
      break
    end
    items[#items + 1] = {
      type = 'button', id = 'o' .. i, label = option.label,
      onClick = function(form)
        picked = option.value
        form:close()
      end,
    }
  end
  items[#items + 1] = { type = 'button', id = 'cancel', label = 'Скасувати', close = true }
  local form = sf.ui.dialog({ title = title, items = items })
  form:wait()
  return picked
end

---------------------------------------------------------------------------
-- Шаблони
---------------------------------------------------------------------------
-- Шаблон: { id, kind = 'timer'|'stopwatch', name, duration, every, warn = { секунди } }.
-- duration у секундах; для секундоміра nil — без обмеження. every 0 — без сповіщень.

local KIND_WORD = { timer = 'Таймер', stopwatch = 'Секундомір' }

local function load_templates()
  return sf.storage.get('templates', {})
end

local function save_templates(list)
  sf.storage.set('templates', list)
end

local function load_defaults()
  return sf.storage.get('defaults', {})
end

local function set_default(kind, id)
  local d = load_defaults()
  d[kind] = id
  sf.storage.set('defaults', d)
end

local function new_id()
  local n = int(sf.storage.get('nextId', 1))
  sf.storage.set('nextId', n + 1)
  return n
end

local function find_template(id)
  for i, t in ipairs(load_templates()) do
    if int(t.id) == int(id) then
      return t, i
    end
  end
end

-- Шаблони одного типу: без обмеження першими, далі від коротшого до довшого.
local function templates_of(kind)
  local list = {}
  for i, t in ipairs(load_templates()) do
    if t.kind == kind then
      list[#list + 1] = { t = t, order = i }
    end
  end
  table.sort(list, function(a, b)
    local da, db = a.t.duration or -1, b.t.duration or -1
    if da ~= db then
      return da < db
    end
    local ea, eb = a.t.every or 0, b.t.every or 0
    if ea ~= eb then
      return ea < eb
    end
    return a.order < b.order
  end)
  local result = {}
  for i, item in ipairs(list) do
    result[i] = item.t
  end
  return result
end

local function has_name(spec)
  return spec.name ~= nil and trim(spec.name) ~= ''
end

local function is_default(t)
  local d = load_defaults()[t.kind]
  return d ~= nil and int(d) == int(t.id)
end

-- Назва: назва або тривалість.
local function template_title(t)
  if has_name(t) then
    return trim(t.name)
  end
  if t.duration then
    return t.kind == 'stopwatch' and ('Секундомір на ' .. fmt(t.duration, false, true)) or fmt(t.duration)
  end
  return t.kind == 'stopwatch' and 'Секундомір без обмеження' or 'Без обмеження'
end

local function template_label(t)
  local parts = { template_title(t) }
  if has_name(t) then
    parts[#parts + 1] = t.duration and fmt(t.duration) or 'без обмеження'
  end
  if (t.every or 0) > 0 then
    parts[#parts + 1] = 'сповіщення ' .. every_text(t.every)
  end
  if t.warn and #t.warn > 0 then
    local warn = {}
    for i, w in ipairs(t.warn) do
      warn[i] = fmt(w, false, true)
    end
    parts[#parts + 1] = 'попередження за ' .. table.concat(warn, ', ')
  end
  if is_default(t) then
    parts[#parts + 1] = 'за замовчуванням'
  end
  return table.concat(parts, ', ')
end

-- Стандартні шаблони.
local STANDARD = {
  { kind = 'stopwatch', every = 60 },
  { kind = 'stopwatch', every = 300, default = true },
  { kind = 'stopwatch', every = 600 },
  { kind = 'stopwatch', every = 900 },
  { kind = 'stopwatch', every = 1800 },
  { kind = 'stopwatch', duration = 60, every = 30 },
  { kind = 'stopwatch', duration = 300, every = 60 },
  { kind = 'stopwatch', duration = 600, every = 300 },
  { kind = 'stopwatch', duration = 900, every = 300 },
  { kind = 'stopwatch', duration = 1800, every = 600 },
  { kind = 'stopwatch', duration = 2700, every = 900 },
  { kind = 'stopwatch', duration = 3600, every = 900 },
  { kind = 'timer', duration = 60, every = 0, warn = { 30 } },
  { kind = 'timer', duration = 300, every = 60 },
  { kind = 'timer', duration = 600, every = 300, warn = { 60 } },
  { kind = 'timer', duration = 900, every = 300, warn = { 60 } },
  { kind = 'timer', duration = 1800, every = 600, warn = { 60 } },
  { kind = 'timer', duration = 2700, every = 900, warn = { 300, 60 } },
  { kind = 'timer', duration = 3600, every = 900, warn = { 300, 60 } },
}

-- Додає стандартні шаблони, яких немає (без назви, той самий тип, тривалість і проміжок).
local function add_standard()
  local list = load_templates()
  local added = 0
  for _, s in ipairs(STANDARD) do
    local exists = nil
    for _, t in ipairs(list) do
      if t.kind == s.kind and not has_name(t)
        and (t.duration and int(t.duration)) == s.duration
        and int(t.every or 0) == s.every then
        exists = t
      end
    end
    if not exists then
      local warn = {}
      for i, w in ipairs(s.warn or {}) do
        warn[i] = w
      end
      exists = { id = new_id(), kind = s.kind, duration = s.duration, every = s.every, warn = warn }
      list[#list + 1] = exists
      added = added + 1
    end
    if s.default and load_defaults()[s.kind] == nil then
      set_default(s.kind, exists.id)
    end
  end
  save_templates(list)
  return added
end

---------------------------------------------------------------------------
-- Запущені таймери і секундоміри
---------------------------------------------------------------------------
-- Запущений: { id, kind, name, duration, every, warn, warned = { bool }, created (мс),
--   acc (мс, набіжене до останнього старту), start (мс, коли стартував), paused, notified }.
-- Час рахується за реальним годинником, тож запущені переживають вивантаження скрипта.

local runs = sf.storage.get('runs', {})
local ringing = nil -- { timer = id таймера повторів }
local last_call = {} -- kind -> sf.clock() останнього виклику, що озвучив час

local function save_runs()
  sf.storage.set('runs', runs)
end

local function elapsed(run, now)
  if run.paused then
    return run.acc
  end
  return run.acc + math.max(0, now - run.start)
end

local function run_name(run)
  if has_name(run) then
    return trim(run.name)
  end
  if run.duration then
    return KIND_WORD[run.kind] .. ' ' .. fmt(run.duration)
  end
  return KIND_WORD[run.kind]
end

local function runs_of(kind)
  local list = {}
  for _, run in ipairs(runs) do
    if kind == nil or run.kind == kind then
      list[#list + 1] = run
    end
  end
  return list
end

local function find_run(id)
  for _, run in ipairs(runs) do
    if int(run.id) == int(id) then
      return run
    end
  end
end

local function active_count()
  local n = 0
  for _, run in ipairs(runs) do
    if not run.paused then
      n = n + 1
    end
  end
  return n
end

local function remove_run(run)
  for i, r in ipairs(runs) do
    if r.id == run.id then
      table.remove(runs, i)
      return
    end
  end
end

-- «Залишилось 2 хвилини. Минуло 1 хвилина.» за режимом:
-- 'remaining' | 'remainingEnd' | 'elapsed' | 'elapsedStart' | 'both'.
local function times_text(run, el_ms, mode, now)
  local parts = {}
  local el = el_ms / 1000
  local rem = run.duration and math.max(0, math.ceil(run.duration - el - 0.001)) or nil
  local want_rem = mode == 'remaining' or mode == 'remainingEnd' or mode == 'both'
  if rem and want_rem then
    parts[#parts + 1] = 'Залишилось ' .. fmt(rem, true) .. '.'
    if mode == 'remainingEnd' and now and not run.paused then
      parts[#parts + 1] = 'Закінчиться о ' .. clock_text(now + rem * 1000) .. '.'
    end
  end
  if not rem or not want_rem or mode == 'both' then
    parts[#parts + 1] = 'Минуло ' .. fmt(math.floor(el), true) .. '.'
  end
  if mode == 'elapsedStart' and run.created then
    parts[#parts + 1] = 'Запущено о ' .. clock_text(run.created) .. '.'
  end
  return table.concat(parts, ' ')
end

local function status_text(run, now)
  local mode
  if run.kind == 'timer' then
    mode = sf.settings.get('statusTimer') or 'remaining'
  else
    mode = sf.settings.get('statusStopwatch') or 'elapsed'
  end
  local text = run_name(run) .. '. ' .. times_text(run, elapsed(run, now), mode, now)
  if run.paused then
    text = text .. ' На паузі.'
  end
  return text
end

local function summary_text(list, now)
  local parts = {}
  for _, run in ipairs(list) do
    parts[#parts + 1] = status_text(run, now)
  end
  return table.concat(parts, ' ')
end

-- Наступна подія запущеного, у мс його ходу: кінець, попередження чи сповіщення.
local function next_target(run)
  local best
  local function consider(ms)
    if ms and (best == nil or ms < best) then
      best = ms
    end
  end
  if run.duration then
    consider(run.duration * 1000)
    for i, w in ipairs(run.warn or {}) do
      if not run.warned[i] and run.duration > w then
        consider((run.duration - w) * 1000)
      end
    end
  end
  if (run.every or 0) > 0 then
    consider((run.notified + 1) * run.every * 1000)
  end
  return best
end

local function schedule_wake(now)
  local best
  for _, run in ipairs(runs) do
    if not run.paused then
      local target = next_target(run)
      if target then
        local at = now + (target - elapsed(run, now))
        if best == nil or at < best then
          best = at
        end
      end
    end
  end
  set_wake(best)
end

local ensure_loop -- оголошено нижче

local function stop_ringing()
  if ringing then
    if ringing.timer then
      sf.clearTimer(ringing.timer)
    end
    ringing = nil
    ensure_loop()
    return true
  end
  return false
end

-- Сигнал у кінці, повторюється, доки не вимкнуть або не скінчаться повтори.
local function ring(text)
  stop_ringing()
  local repeats = tonumber(sf.settings.get('alarmRepeats')) or 3
  ringing = {}
  local function once(i)
    if not ringing then
      return
    end
    hold_cpu(30000)
    local length = play_alarm()
    sf.setTimeout(function()
      if ringing then
        say(text, i == 1)
      end
    end, length)
    if i < repeats then
      ringing.timer = sf.setTimeout(function() once(i + 1) end, length + 4000)
    else
      ringing.timer = sf.setTimeout(function()
        ringing = nil
        ensure_loop()
      end, length + 4000)
    end
  end
  once(1)
  ensure_loop()
end

local function finish(run, now)
  jlog('info', 'Час вийшов: ' .. run_name(run))
  remove_run(run)
  local end_at = now - (elapsed(run, now) - run.duration * 1000)
  local name = run_name(run)
  local text
  if run.kind == 'timer' then
    text = 'Час вийшов. ' .. name .. '.'
  else
    text = 'Зупинено: ' .. name .. '. Минуло ' .. fmt(run.duration) .. '.'
  end
  if now - end_at > 60000 then
    -- Скрипт не працював, коли час вийшов: кажемо, коли це сталося, і без повторів.
    play_alarm()
    say('Час вийшов о ' .. clock_text(end_at) .. ': ' .. name .. '.', false)
  else
    ring(text)
  end
end

-- Обробляє події, час яких настав. Пропущені сповіщення не накопичуються.
local function process_due(now)
  local messages = {}
  local changed = false
  local many = #runs > 1
  for _, run in ipairs(runs_of(nil)) do
    if not run.paused then
      local el = elapsed(run, now)
      local slack = 300
      if run.duration and el + slack >= run.duration * 1000 then
        finish(run, now)
        changed = true
      else
        local prefix = (many or has_name(run)) and (run_name(run) .. '. ') or ''
        local said = false
        if run.duration then
          for i, w in ipairs(run.warn or {}) do
            local at = (run.duration - w) * 1000
            if not run.warned[i] and at > 0 and el + slack >= at then
              run.warned[i] = true
              changed = true
              if not said and el - at < 30000 then
                messages[#messages + 1] = prefix .. 'Залишилось ' .. fmt(w) .. '.'
                said = true
              end
            end
          end
        end
        if (run.every or 0) > 0 then
          local n = (el + slack) // (run.every * 1000)
          if n > run.notified then
            run.notified = n
            changed = true
            local target = n * run.every
            if not said and el - target * 1000 < 30000 then
              local mode
              if run.kind == 'timer' then
                mode = sf.settings.get('notifyTimer') or 'remaining'
              else
                mode = sf.settings.get('notifyStopwatch') or 'elapsed'
              end
              messages[#messages + 1] = prefix .. times_text({ duration = run.duration }, target * 1000, mode)
            end
          end
        end
      end
    end
  end
  if changed then
    save_runs()
  end
  if #messages > 0 then
    hold_cpu(30000)
    play_notify()
    say(table.concat(messages, ' '), false)
  end
  return changed
end

-- Щосекундна перевірка: події, утримання процесора і ввімкнення екрана.
local loop_id = nil
local was_interactive = true

local function tick()
  local now = now_ms()
  if active_count() == 0 and not ringing then
    if last_hold > 0 then
      release_cpu()
    end
  elseif on('keepAwake') and now - last_hold > 30000 then
    hold_cpu(120000)
    last_hold = now
  end
  local changed = process_due(now)
  local interactive = is_interactive()
  -- Саме ввімкнення екрана (ще на екрані блокування), а не розблокування.
  if interactive and not was_interactive and on('screenOnSummary') and #runs > 0 then
    sf.setTimeout(function()
      if #runs > 0 then
        say(summary_text(runs, now_ms()), false)
      end
    end, 700)
  end
  was_interactive = interactive
  if changed then
    schedule_wake(now)
    ensure_loop()
  end
end

ensure_loop = function()
  local needed = active_count() > 0 or ringing ~= nil or (#runs > 0 and on('screenOnSummary'))
  if needed and not loop_id then
    was_interactive = is_interactive()
    loop_id = sf.setInterval(guarded('Щосекундна перевірка', tick), 1000)
  elseif not needed and loop_id then
    sf.clearTimer(loop_id)
    loop_id = nil
    release_cpu()
  end
end

local function changed_runs()
  local now = now_ms()
  save_runs()
  schedule_wake(now)
  ensure_loop()
end

local function start(spec)
  local now = now_ms()
  local warn, warned = {}, {}
  for i, w in ipairs(spec.warn or {}) do
    warn[i] = int(w)
    warned[i] = false
  end
  local run = {
    id = new_id(),
    kind = spec.kind,
    name = has_name(spec) and trim(spec.name) or nil,
    duration = spec.duration and int(spec.duration) or nil,
    every = int(spec.every or 0),
    warn = warn,
    warned = warned,
    created = now,
    acc = 0,
    start = now,
    paused = false,
    notified = 0,
  }
  runs[#runs + 1] = run
  changed_runs()
  local text = KIND_WORD[run.kind] .. ' запущено'
  if has_name(run) then
    text = text .. ': ' .. run.name
  end
  if run.duration then
    text = text .. (has_name(run) and ', ' or ': ') .. fmt(run.duration)
  end
  jlog('info', text)
  say(text .. '.', true)
end

local function stop(run)
  jlog('info', 'Зупинено: ' .. run_name(run))
  remove_run(run)
  changed_runs()
  say('Зупинено: ' .. run_name(run) .. '. ' .. times_text(run, elapsed(run, now_ms()), 'elapsed'), true)
end

local function toggle_pause(run, quiet)
  local now = now_ms()
  if run.paused then
    run.start = now
    run.paused = false
    if not quiet then
      say('Продовжено: ' .. run_name(run) .. '.', true)
    end
  else
    run.acc = elapsed(run, now)
    run.paused = true
    if not quiet then
      say(status_text(run, now), true)
    end
  end
  changed_runs()
end

---------------------------------------------------------------------------
-- Форма з повзунками, що кажуть час, а не відсотки
---------------------------------------------------------------------------
-- Повзунки форм SandFly читаються відсотками, тож форму будуємо самі через Android:
-- кожен повзунок має опис стану «5 хвилин», який SandFly і читає.

local function hms(sec)
  sec = math.max(0, int(sec or 0))
  return sec // 3600, (sec % 3600) // 60, sec % 60
end

-- Перевіряє текст поля для числа від 0 до max. Повертає true і число (nil, якщо поле
-- порожнє), або false і те, що сказати людині. unit ('h', 'm', 's') додає до числа одиницю.
local function check_typed(text, max, unit)
  text = trim(text)
  if text == '' then
    return true, nil
  end
  local limit = unit and count_text(max, unit) or tostring(max)
  if not text:match('^%d+$') then
    return false, 'Лише цифри, від 0 до ' .. limit .. '.'
  end
  local n = int(tonumber(text))
  -- Довше, ніж треба (наприклад 059), теж не пускаємо.
  if n > max or #text > #tostring(max) then
    return false, 'Не більше ' .. limit .. '.'
  end
  return true, n
end

-- Число з поля, або nil, якщо поле порожнє чи там щось не те.
local function typed_number(text, max)
  local ok, n = check_typed(text, max)
  return ok and n or nil
end

local function step_of(unit)
  local key = unit == 'h' and 'stepHours' or unit == 'm' and 'stepMinutes' or 'stepSeconds'
  return math.max(1, int(tonumber(sf.settings.get(key)) or 1))
end

-- Опис форми: поля { kind = 'edit'|'heading'|'slider'|'button', id, label, unit, max, value }.
local function form_fields(kind, mode, spec, default_now)
  local dh, dm, ds = hms(spec.duration)
  local eh, em, es = hms(spec.every)
  local w1 = int(spec.warn and spec.warn[1] or 0)
  local w2 = int(spec.warn and spec.warn[2] or 0)
  local timer = kind == 'timer'
  local f = {
    { kind = 'edit', id = 'name', label = "Назва (необов'язково)", value = spec.name or '' },
    { kind = 'heading', label = timer and 'Тривалість' or 'Зупинити через (якщо всюди 0, без обмеження)' },
    { kind = 'slider', id = 'dh', unit = 'h', max = 23, value = dh,
      label = timer and 'Тривалість, години' or 'Зупинити через, години' },
    { kind = 'slider', id = 'dm', unit = 'm', max = 59, value = dm,
      label = timer and 'Тривалість, хвилини' or 'Зупинити через, хвилини' },
    { kind = 'slider', id = 'ds', unit = 's', max = 59, value = ds,
      label = timer and 'Тривалість, секунди' or 'Зупинити через, секунди' },
    { kind = 'heading', label = 'Сповіщення (якщо всюди 0, без сповіщень)' },
    { kind = 'slider', id = 'eh', unit = 'h', max = 12, value = eh, label = 'Сповіщати кожні, години' },
    { kind = 'slider', id = 'em', unit = 'm', max = 59, value = em, label = 'Сповіщати кожні, хвилини' },
    { kind = 'slider', id = 'es', unit = 's', max = 59, value = es, label = 'Сповіщати кожні, секунди' },
  }
  if timer then
    f[#f + 1] = { kind = 'heading', label = 'Попередження до кінця (якщо 0, без попередження)' }
    f[#f + 1] = { kind = 'slider', id = 'w1m', unit = 'm', max = 59, value = w1 // 60, label = 'Перше попередження, хвилини' }
    f[#f + 1] = { kind = 'slider', id = 'w1s', unit = 's', max = 59, value = w1 % 60, label = 'Перше попередження, секунди' }
    f[#f + 1] = { kind = 'slider', id = 'w2m', unit = 'm', max = 59, value = w2 // 60, label = 'Друге попередження, хвилини' }
    f[#f + 1] = { kind = 'slider', id = 'w2s', unit = 's', max = 59, value = w2 % 60, label = 'Друге попередження, секунди' }
  end
  local function button(id, label)
    f[#f + 1] = { kind = 'button', id = id, label = label }
  end
  if mode == 'custom' then
    button('start', 'Запустити')
    button('startSave', 'Запустити й зберегти як шаблон')
  elseif mode == 'new' then
    button('save', 'Зберегти шаблон')
    button('saveDefault', 'Зберегти й зробити за замовчуванням')
  else
    button('save', 'Зберегти')
    if not default_now then
      button('saveDefault', 'Зберегти й зробити за замовчуванням')
    end
    button('delete', 'Видалити шаблон')
  end
  return f
end

local FORM_TITLES = {
  custom = { timer = 'Свій таймер', stopwatch = 'Свій секундомір' },
  new = { timer = 'Новий шаблон таймера', stopwatch = 'Новий шаблон секундоміра' },
  edit = { timer = 'Змінити шаблон', stopwatch = 'Змінити шаблон' },
}

-- Форма через Android. Повертає кнопку і значення; nil, якщо форму закрили або її не вдалося показати.
local function java_form(title, fields)
  if not jinit() then
    say('Форма не відкрилась: скрипту потрібен дозвіл java.', true)
    return nil
  end
  local result = { done = false }
  jlog('info', 'Відкриваю форму «' .. title .. '»')
  if journal_on() then
    pcall(sf.storage.set, 'journalForm', title)
  end
  -- Форма будується в головному потоці: діалоги Android вимагають саме його
  -- ("addObserver must be called on the main thread" у потоці скриптів).
  local posted = main_post(function()
    local ok, err = pcall(function()
      local service = java.import('com.google.android.accessibility.talkback.TalkBackService'):getInstance()
      local MCU = java.import('com.google.android.accessibility.utils.material.MaterialComponentUtils')
      local View = java.import('android.view.View')
      local builder = MCU:alertDialogBuilder(service)
      local ctx = builder:getContext()
      local TextView = java.import('android.widget.TextView')
      local SeekBar = java.import('android.widget.SeekBar')
      local Button = java.import('android.widget.Button')
      local LinearLayout = java.import('android.widget.LinearLayout')
      local ScrollView = java.import('android.widget.ScrollView')
      local EditText = java.import('com.google.android.accessibility.utils.widget.KeyboardSafeEditText')
      local density = ctx:getResources():getDisplayMetrics().density
      local function dp(n) return math.floor(n * density + 0.5) end
      local column = java.new(LinearLayout, ctx)
      column:setOrientation(1)
      column:setPadding(dp(24), dp(8), dp(24), dp(8))
      local controls = {}
      local dialog
      local function read_values()
        local values = {}
        for id, c in pairs(controls) do
          if c.bar then
            -- Число в полі поруч із повзунком важливіше: воно може бути точнішим за крок повзунка.
            local typed = c.input and typed_number(tostring(c.input:getText():toString()), c.max)
            values[id] = typed or c.bar:getProgress() * c.step
          else
            values[id] = tostring(c.edit:getText():toString())
          end
        end
        return values
      end
      for i, field in ipairs(fields) do
        if field.kind == 'heading' then
          local h = java.new(TextView, ctx)
          h:setText(field.label)
          h:setTextSize(18)
          h:setPadding(0, dp(16), 0, dp(4))
          h:setAccessibilityHeading(true)
          column:addView(h)
        elseif field.kind == 'edit' then
          local label = java.new(TextView, ctx)
          label:setText(field.label)
          local edit = java.new(EditText, ctx)
          edit:setId(View:generateViewId())
          edit:setSingleLine(true)
          edit:setText(field.value or '')
          label:setLabelFor(edit:getId())
          column:addView(label)
          column:addView(edit)
          controls[field.id] = { edit = edit }
        elseif field.kind == 'slider' then
          local step = step_of(field.unit)
          local steps = field.max // step
          local label = java.new(TextView, ctx)
          label:setText(field.label)
          label:setPadding(0, dp(8), 0, 0)
          local bar = java.new(SeekBar, ctx)
          bar:setId(View:generateViewId())
          bar:setMax(steps)
          bar:setKeyProgressIncrement(1)
          bar:setProgress(math.min(steps, int(field.value or 0) // step))
          local function describe(progress)
            pcall(function() bar:setStateDescription(count_text(int(progress) * step, field.unit)) end)
          end
          describe(bar:getProgress())
          label:setLabelFor(bar:getId())
          -- Жест «більше/менше» Android сам зсуває повзунок на двадцяту частину шкали
          -- (3 для 59 хвилин чи секунд). Такий стрибок виправляємо на один крок.
          local jump = math.max(1, math.floor(steps / 20 + 0.5))
          local last = bar:getProgress()
          local dragging, fixing, syncing = false, false, false
          -- Поле, щоб ввести значення числом. Порожнє, доки його не заповнять; число з поля
          -- ставить повзунок, а рух повзунка поле очищає. Більше за max чи не цифри не пускає.
          local input_label = java.new(TextView, ctx)
          input_label:setText(field.label .. ', ввести числом')
          local input = java.new(EditText, ctx)
          input:setId(View:generateViewId())
          input:setSingleLine(true)
          input:setInputType(2) -- TYPE_CLASS_NUMBER
          input_label:setLabelFor(input:getId())
          local accepted = ''
          -- Де щойно змінився текст: з якого місця і скільки символів вставлено.
          local change_at, change_count = nil, 0
          local function cursor_to_end()
            pcall(function() input:setSelection(input:length()) end)
          end
          -- Коли відкривається клавіатура, курсор іде в кінець поля.
          input:setOnFocusChangeListener(make_proxy('android.view.View$OnFocusChangeListener', {
            onFocusChange = function() cursor_to_end() end,
          }))
          -- Зайве не вставляється: вставлені символи прибираються з того самого місця, тож решта
          -- тексту й курсор лишаються, де були. Текст поля цілком не замінюється: від цього курсор
          -- стрибав на початок, і наступна цифра потрапляла не туди.
          local function reject(editable, message)
            syncing = true
            local restored = false
            if change_at and change_count > 0 then
              restored = pcall(function() editable:delete(change_at, change_at + change_count) end)
              -- Якщо вставка замінила виділений текст, після видалення може лишитися не те.
              if restored and not check_typed(tostring(editable:toString()), field.max) then
                restored = false
              end
            end
            if not restored then
              pcall(function()
                editable:replace(0, editable:length(), accepted)
                input:setSelection(math.min(change_at or editable:length(), editable:length()))
              end)
            end
            syncing = false
            say(message, true)
          end
          input:addTextChangedListener(make_proxy('android.text.TextWatcher', {
            beforeTextChanged = function() end,
            -- Аргументи: текст, з якого місця, скільки було, скільки стало. Беремо числа по порядку.
            onTextChanged = function(...)
              if syncing then
                return
              end
              local numbers = {}
              for _, arg in ipairs({ ... }) do
                if math.type(arg) then
                  numbers[#numbers + 1] = int(arg)
                end
              end
              if #numbers >= 3 then
                change_at, change_count = numbers[#numbers - 2], numbers[#numbers]
              else
                change_at, change_count = nil, 0
              end
            end,
            afterTextChanged = function()
              if syncing then
                return
              end
              pcall(function()
                local editable = input:getText()
                local text = tostring(editable:toString())
                local ok, n = check_typed(text, field.max, field.unit)
                if not ok then
                  reject(editable, n)
                  return
                end
                accepted = text
                if not n then
                  return
                end
                syncing, fixing = true, true
                pcall(function() bar:setProgress(math.min(steps, n // step)) end)
                last = bar:getProgress()
                fixing, syncing = false, false
                pcall(function() bar:setStateDescription(count_text(n, field.unit)) end)
              end)
              syncing, fixing = false, false
            end,
          }))
          bar:setOnSeekBarChangeListener(make_proxy('android.widget.SeekBar$OnSeekBarChangeListener', {
            -- Аргументи (повзунок, значення, чи від користувача); значення — єдине число серед них.
            onProgressChanged = function(...)
              local args = { ... }
              pcall(function()
                local progress, from_user
                for i = 1, 3 do
                  if math.type(args[i]) then
                    progress = int(args[i])
                  elseif type(args[i]) == 'boolean' then
                    from_user = args[i]
                  end
                end
                if not progress then
                  return
                end
                local delta = progress - last
                local size = math.abs(delta)
                local at_end = progress == 0 or progress == steps
                if not fixing and not dragging and from_user ~= false and jump > 1
                  and (size == jump or (at_end and size > 1 and size < jump)) then
                  fixing = true
                  progress = last + (delta > 0 and 1 or -1)
                  pcall(function() bar:setProgress(progress) end)
                  fixing = false
                end
                last = progress
                if not syncing then
                  describe(progress)
                  -- Повзунок рухали: число в полі вже не те, тож поле очищаємо.
                  if accepted ~= '' then
                    syncing = true
                    accepted = ''
                    pcall(function() input:setText('') end)
                    syncing = false
                  end
                end
              end)
            end,
            onStartTrackingTouch = function() dragging = true end,
            onStopTrackingTouch = function() dragging = false end,
          }))
          column:addView(label)
          column:addView(bar)
          column:addView(input_label)
          column:addView(input)
          controls[field.id] = { bar = bar, step = step, input = input, max = field.max }
        elseif field.kind == 'button' then
          local button = java.new(Button, ctx)
          button:setText(field.label)
          button:setOnClickListener(make_proxy('android.view.View$OnClickListener', {
            onClick = function()
              local read, values = pcall(read_values)
              result.values = read and values or {}
              result.action = field.id
              pcall(function() dialog:dismiss() end)
            end,
          }))
          column:addView(button)
        end
      end
      local scroll = java.new(ScrollView, ctx)
      scroll:addView(column)
      builder:setTitle(title)
      builder:setView(scroll)
      builder:setNegativeButton('Скасувати', nil)
      builder:setOnDismissListener(make_proxy('android.content.DialogInterface$OnDismissListener', {
        onDismiss = function() result.done = true end,
      }))
      dialog = builder:create()
      dialog:getWindow():setType(2032) -- TYPE_ACCESSIBILITY_OVERLAY, як діалоги SandFly
      dialog:show()
    end)
    if not ok then
      result.failed = tostring(err)
      result.done = true
    end
  end)
  if not posted then
    result.failed = 'не вдалося передати її в головний потік'
  end
  while not result.done and not result.failed do
    sf.sleep(150)
  end
  pcall(sf.storage.remove, 'journalForm')
  if result.failed then
    jlog('error', 'Форма не відкрилась: ' .. result.failed)
    say('Форму не вдалося відкрити.', true)
    return nil
  end
  jlog('info', 'Форму закрито: ' .. tostring(result.action or 'скасовано'))
  return result.action, result.values or {}
end

-- Значення форми -> spec (без перевірки).
local function spec_from_values(kind, v)
  local function n(key)
    return int(v[key] or 0)
  end
  local spec = { kind = kind, name = trim(v.name) }
  local duration = n('dh') * 3600 + n('dm') * 60 + n('ds')
  spec.duration = duration > 0 and duration or nil
  spec.every = n('eh') * 3600 + n('em') * 60 + n('es')
  spec.warn = {}
  if kind == 'timer' then
    local seen = {}
    for _, key in ipairs({ 'w1', 'w2' }) do
      local w = n(key .. 'm') * 60 + n(key .. 's')
      if w > 0 and not seen[w] then
        seen[w] = true
        spec.warn[#spec.warn + 1] = w
      end
    end
    table.sort(spec.warn, function(a, b) return a > b end)
  end
  return spec
end

local function check_spec(spec)
  if spec.kind == 'timer' and not spec.duration then
    return 'Поставте тривалість таймера: години, хвилини або секунди більше нуля.'
  end
  if spec.duration then
    for _, w in ipairs(spec.warn) do
      if w >= spec.duration then
        return 'Попередження має бути коротшим за тривалість таймера.'
      end
    end
  end
  return nil
end

-- make_default: true — зробити за замовчуванням, nil — лишити як було.
local function store_template(spec, id, make_default)
  local list = load_templates()
  local t = {
    id = id or new_id(),
    kind = spec.kind,
    name = has_name(spec) and trim(spec.name) or nil,
    duration = spec.duration,
    every = spec.every,
    warn = spec.warn,
  }
  local replaced = false
  for i, old in ipairs(list) do
    if int(old.id) == int(t.id) then
      list[i] = t
      replaced = true
    end
  end
  if not replaced then
    list[#list + 1] = t
  end
  save_templates(list)
  if make_default then
    set_default(t.kind, t.id)
  end
  return t
end

local function delete_template(t)
  local list = load_templates()
  for i, old in ipairs(list) do
    if int(old.id) == int(t.id) then
      table.remove(list, i)
      break
    end
  end
  save_templates(list)
  if is_default(t) then
    set_default(t.kind, nil)
  end
end

-- mode: 'custom' (свій час, запуск), 'new' (новий шаблон), 'edit' (змінити шаблон t).
-- Повертає збережений шаблон, якщо він є.
local function open_form(kind, mode, t)
  local spec
  if t then
    spec = { kind = kind, name = t.name, duration = t.duration, every = t.every, warn = t.warn }
  else
    spec = { kind = kind, every = tonumber(sf.settings.get('defaultEvery')) or 300, warn = {} }
  end
  local default_now = t and is_default(t)
  while true do
    local action, values = java_form(FORM_TITLES[mode][kind], form_fields(kind, mode, spec, default_now))
    if action == 'delete' then
      if sf.ui.confirm('Видалити шаблон «' .. template_title(t) .. '»?', { ok = 'Видалити' }) then
        delete_template(t)
        say('Шаблон видалено.', true)
      end
      return nil
    end
    if action == nil then
      return nil
    end
    spec = spec_from_values(kind, values)
    local err = check_spec(spec)
    if not err then
      local saved
      if action ~= 'start' then
        saved = store_template(spec, t and t.id, action == 'saveDefault' or nil)
      end
      if action == 'start' or action == 'startSave' then
        start(spec)
      else
        say('Шаблон збережено: ' .. template_title(saved) .. (action == 'saveDefault' and ', за замовчуванням.' or '.'), true)
      end
      return saved
    end
    sf.ui.alert(err)
  end
end

local function start_template(t)
  start({ kind = t.kind, name = t.name, duration = t.duration, every = t.every, warn = t.warn })
end

---------------------------------------------------------------------------
-- Меню
---------------------------------------------------------------------------

local manage_templates -- оголошено нижче
local sounds_window -- оголошено нижче

local function start_menu(kind)
  local options = {}
  for _, t in ipairs(templates_of(kind)) do
    options[#options + 1] = { value = 'tpl:' .. idstr(t.id), label = template_label(t) }
  end
  options[#options + 1] = { value = 'custom', label = 'Свій час…' }
  options[#options + 1] = { value = 'new', label = 'Новий шаблон…' }
  options[#options + 1] = { value = 'manage', label = 'Керувати шаблонами…' }
  local choice = menu(kind == 'timer' and 'Запустити таймер' or 'Запустити секундомір', options)
  if not choice then
    return
  end
  local id = choice:match('^tpl:(%d+)$')
  if id then
    local t = find_template(tonumber(id))
    if t then
      start_template(t)
    end
  elseif choice == 'custom' then
    open_form(kind, 'custom')
  elseif choice == 'new' then
    local t = open_form(kind, 'new')
    if t and sf.ui.confirm('Запустити «' .. template_title(t) .. '» зараз?', { ok = 'Запустити', cancel = 'Ні' }) then
      start_template(t)
    end
  elseif choice == 'manage' then
    manage_templates()
  end
end

local function run_menu(run)
  local options = {
    { value = 'say', label = 'Озвучити час' },
    { value = 'pause', label = run.paused and 'Продовжити' or 'Пауза' },
    { value = 'stop', label = 'Зупинити' },
  }
  local choice = menu(status_text(run, now_ms()), options)
  if choice == 'say' then
    say(status_text(run, now_ms()), true)
  elseif choice == 'pause' then
    toggle_pause(run)
  elseif choice == 'stop' then
    stop(run)
  end
end

local function stop_all(list)
  for _, run in ipairs(list) do
    remove_run(run)
  end
  changed_runs()
  say(#list == 1 and ('Зупинено: ' .. run_name(list[1]) .. '.') or 'Усі зупинено.', true)
end

local function running_menu(kind)
  local now = now_ms()
  local options = {}
  for _, run in ipairs(runs_of(kind)) do
    options[#options + 1] = { value = 'run:' .. idstr(run.id), label = status_text(run, now) }
  end
  options[#options + 1] = { value = 'more', label = kind == 'timer' and 'Запустити ще таймер…' or 'Запустити ще секундомір…' }
  options[#options + 1] = { value = 'stopall', label = kind == 'timer' and 'Зупинити всі таймери' or 'Зупинити всі секундоміри' }
  local choice = menu(kind == 'timer' and 'Запущені таймери' or 'Запущені секундоміри', options)
  if not choice then
    return
  end
  local id = choice:match('^run:(%d+)$')
  if id then
    local run = find_run(tonumber(id))
    if run then
      run_menu(run)
    end
  elseif choice == 'more' then
    start_menu(kind)
  elseif choice == 'stopall' then
    stop_all(runs_of(kind))
  end
end

-- Вікно «Шаблони». Форма шаблону відкривається лише після того, як це вікно закрилось,
-- а потім вікно відкривається знову: так само форма відкривається з меню, де вона працює.
manage_templates = function()
  local focus_id = nil
  while true do
    local window
    local after = nil -- що зробити, коли вікно закриється; повертає true, щоб відкрити його знову
    local function leave(fn)
      after = fn
      window:close()
    end
    local function rows(kind)
      local list = {}
      for _, t in ipairs(templates_of(kind)) do
        list[#list + 1] = { value = idstr(t.id), label = template_label(t) }
      end
      return list
    end
    local function refresh()
      window:set('timers', { items = rows('timer') })
      window:set('stopwatches', { items = rows('stopwatch') })
    end
    local function on_action(action, id)
      local t = find_template(tonumber(id))
      if not t then
        return
      end
      if action == 'Запустити' then
        leave(function() start_template(t) end)
      elseif action == 'Змінити' then
        leave(function()
          focus_id = t.kind == 'timer' and 'timers' or 'stopwatches'
          open_form(t.kind, 'edit', t)
          return true
        end)
      elseif action == 'Зробити за замовчуванням' then
        set_default(t.kind, t.id)
        say('«' .. template_title(t) .. '» тепер за замовчуванням.', true)
        refresh()
      elseif action == 'Видалити' then
        if sf.ui.confirm('Видалити шаблон «' .. template_title(t) .. '»?', { ok = 'Видалити' }) then
          delete_template(t)
          refresh()
        end
      end
    end
    local function new_template(kind)
      leave(function()
        focus_id = kind == 'timer' and 'timers' or 'stopwatches'
        open_form(kind, 'new')
        return true
      end)
    end
    local actions = { 'Запустити', 'Змінити', 'Зробити за замовчуванням', 'Видалити' }
    local function list_item(id, kind)
      return {
        type = 'items', id = id, items = rows(kind), empty = 'Немає шаблонів', actions = actions,
        onSelect = function(value) on_action('Змінити', value) end,
        onAction = on_action,
      }
    end
    window = sf.ui.window({
      title = 'Шаблони',
      items = {
        { type = 'button', id = 'newTimer', label = 'Новий шаблон таймера',
          onClick = function() new_template('timer') end },
        { type = 'button', id = 'newStopwatch', label = 'Новий шаблон секундоміра',
          onClick = function() new_template('stopwatch') end },
        { type = 'heading', id = 'timersHeading', label = 'Таймери' },
        list_item('timers', 'timer'),
        { type = 'heading', id = 'stopwatchesHeading', label = 'Секундоміри' },
        list_item('stopwatches', 'stopwatch'),
        { type = 'heading', id = 'moreHeading', label = 'Ще' },
        { type = 'button', id = 'clearDefaults', label = 'Прибрати запуск за замовчуванням',
          onClick = function()
            sf.storage.set('defaults', {})
            refresh()
            say('Тепер жести відкривають список.', true)
          end },
        { type = 'button', id = 'standard', label = 'Повернути стандартні шаблони',
          onClick = function()
            local added = add_standard()
            refresh()
            say(added > 0 and ('Додано шаблонів: ' .. added .. '.') or 'Усі стандартні шаблони вже є.', true)
          end },
      },
    })
    if focus_id then
      window:focus(focus_id)
    end
    window:wait()
    if not after or not after() then
      return
    end
  end
end

local VOLUMES = {
  { value = '0', label = 'Вимкнено' }, { value = '25', label = '25%' }, { value = '50', label = '50%' },
  { value = '75', label = '75%' }, { value = '100', label = '100%' },
}

local function volume_label(key)
  local v = sound_pref(key)
  for _, option in ipairs(VOLUMES) do
    if option.value == v then
      return option.label
    end
  end
  return v .. '%'
end

local function sound_label(list, key)
  local current = sound_pref(key)
  for _, s in ipairs(list) do
    if s[1] == current then
      return s[2]
    end
  end
  return current
end

-- Звуки. Перше вікно: дві групи, «Проміжні сповіщення» і «Сигнал у кінці», у кожній кнопка
-- звуку і кнопка гучності. Кнопка звуку відкриває окремий список, заголовок якого каже, для чого він;
-- подвійний дотик там вибирає звук і одразу його програє.
sounds_window = function()
  local window
  local function refresh()
    window:set('notifySound', { label = 'Звук: ' .. sound_label(NOTIFY_SOUNDS, 'sound') })
    window:set('notifyVolume', { label = 'Гучність: ' .. volume_label('soundVolume') })
    window:set('alarmSound', { label = 'Звук: ' .. sound_label(ALARM_SOUNDS, 'alarmSound') })
    window:set('alarmVolume', { label = 'Гучність: ' .. volume_label('alarmVolume') })
  end
  -- Прослуховування чути, навіть коли гучність вимкнено.
  local function preview(name, key)
    local gain = volume(key)
    return play_sound(name, gain > 0 and gain or 0.5)
  end
  local function pick_sound(title, help, list, sound_key, volume_key)
    local picker
    local spoken = nil
    local rows = {}
    for _, s in ipairs(list) do
      rows[#rows + 1] = { value = s[1], label = s[2] }
    end
    picker = sf.ui.window({
      title = title,
      onClose = refresh,
      items = {
        { type = 'label', id = 'help', label = help },
        { type = 'label', id = 'current', label = 'Зараз вибрано: ' .. sound_label(list, sound_key) },
        {
          type = 'items', id = 'sounds', items = rows,
          onSelect = function(value)
            set_sound_pref(sound_key, value)
            -- Список не чіпаємо, щоб фокус лишався на вибраному рядку.
            picker:set('current', { label = 'Зараз вибрано: ' .. sound_label(list, sound_key) })
            local length = preview(value, volume_key)
            if spoken then
              sf.clearTimer(spoken)
            end
            spoken = sf.setTimeout(function()
              spoken = nil
              say('Вибрано.', true)
            end, length + 150)
          end,
        },
        { type = 'button', id = 'done', label = 'Готово', close = true },
      },
    })
  end
  local function sound_button(id, title, help, list, sound_key, volume_key)
    return {
      type = 'button', id = id, label = 'Звук: ' .. sound_label(list, sound_key),
      onClick = function() pick_sound(title, help, list, sound_key, volume_key) end,
    }
  end
  local function volume_button(id, title, key, sound_key)
    return {
      type = 'button', id = id, label = 'Гучність: ' .. volume_label(key),
      onClick = function()
        local v = menu(title, VOLUMES)
        if v then
          set_sound_pref(key, v)
          refresh()
          if v ~= '0' then
            play_sound(sound_pref(sound_key), volume(key))
          end
        end
      end,
    }
  end
  window = sf.ui.window({
    title = 'Звуки',
    items = {
      { type = 'heading', id = 'notifyHeading', label = 'Проміжні сповіщення' },
      { type = 'label', id = 'notifyHelp', label = 'Короткий звук перед словами «Залишилось…» або «Минуло…», поки йде відлік.' },
      sound_button('notifySound', 'Звук проміжних сповіщень',
        'Короткий звук, що лунає під час відліку. Подвійний дотик вибирає звук і програє його.',
        NOTIFY_SOUNDS, 'sound', 'soundVolume'),
      volume_button('notifyVolume', 'Гучність проміжних сповіщень', 'soundVolume', 'sound'),
      { type = 'heading', id = 'alarmHeading', label = 'Сигнал у кінці' },
      { type = 'label', id = 'alarmHelp', label = 'Довгий сигнал, коли час таймера вийшов. Він повторюється, доки його не вимкнути.' },
      sound_button('alarmSound', 'Сигнал у кінці таймера',
        'Довгий сигнал, що лунає, коли час вийшов. Подвійний дотик вибирає сигнал і програє його.',
        ALARM_SOUNDS, 'alarmSound', 'alarmVolume'),
      volume_button('alarmVolume', 'Гучність сигналу в кінці', 'alarmVolume', 'alarmSound'),
    },
  })
end

---------------------------------------------------------------------------
-- Журнал: меню
---------------------------------------------------------------------------

local function journal_summary()
  local n = #journal_entries()
  if journal_on() then
    return 'Увімкнено, записів: ' .. n .. '. Повторіть те, що не працює, і надішліть журнал автору'
  end
  if n > 0 then
    return 'Вимкнено, збережено записів: ' .. n
  end
  return 'Вимкнено. Увімкніть, якщо щось працює не так, а потім надішліть журнал автору'
end

local function refresh_journal_summary()
  pcall(sf.settings.setSummary, 'journalMenu', journal_summary())
end

local function set_journal(enabled)
  if enabled then
    -- Новий журнал щоразу, щоб у ньому було лише те, що сталося після ввімкнення.
    sf.storage.set('journal', {})
    sf.storage.set('journalOn', true)
    jlog('info', 'Журнал увімкнено')
  else
    jlog('info', 'Журнал вимкнено')
    sf.storage.set('journalOn', false)
  end
  refresh_journal_summary()
end

local function journal_text()
  local head = manifest.name .. ' ' .. manifest.version
  pcall(function()
    local d = sf.device.info()
    head = head .. ', ' .. tostring(d.manufacturer) .. ' ' .. tostring(d.model)
      .. ', Android ' .. tostring(d.androidVersion) .. ', SandFly ' .. tostring(d.sandflyVersion)
  end)
  local lines = { head }
  for _, e in ipairs(journal_entries()) do
    local count = tonumber(e.count) or 1
    lines[#lines + 1] = tostring(e.at) .. ' ' .. tostring(e.line) .. (count > 1 and (' (×' .. count .. ')') or '')
  end
  return table.concat(lines, '\n')
end

-- Відкриває меню Android «Поділитися» з текстом журналу: месенджер, пошта тощо.
local function share_journal()
  local text = journal_text()
  local posted = main_post(function()
    local ok, err = pcall(function()
      local Intent = java.import('android.content.Intent')
      local send = java.new(Intent, 'android.intent.action.SEND')
      send:setType('text/plain')
      send:putExtra('android.intent.extra.SUBJECT', 'Журнал: ' .. manifest.name)
      send:putExtra('android.intent.extra.TEXT', text)
      local chooser = Intent:createChooser(send, 'Надіслати журнал')
      chooser:addFlags(0x10000000) -- FLAG_ACTIVITY_NEW_TASK
      java.import('com.google.android.accessibility.talkback.TalkBackService'):getInstance():startActivity(chooser)
    end)
    if not ok then
      jlog('warn', 'Меню «Поділитися» не відкрилось: ' .. tostring(err))
      say('Не вдалося відкрити меню «Поділитися». Скопіюйте журнал і вставте його в повідомлення.', true)
    end
  end)
  if not posted then
    say('Не вдалося відкрити меню «Поділитися». Скопіюйте журнал і вставте його в повідомлення.', true)
  end
end

local function copy_journal()
  local text = journal_text()
  local posted = main_post(function()
    local ok, err = pcall(function()
      local ClipData = java.import('android.content.ClipData')
      J.ctx:getSystemService('clipboard'):setPrimaryClip(ClipData:newPlainText('Журнал', text))
    end)
    say(ok and 'Журнал скопійовано.' or 'Не вдалося скопіювати журнал.', true)
    if not ok then
      jlog('warn', 'Журнал не скопіювався: ' .. tostring(err))
    end
  end)
  if not posted then
    say('Не вдалося скопіювати журнал.', true)
  end
end

local function journal_menu()
  local entries = journal_entries()
  local options = {}
  if journal_on() then
    options[#options + 1] = { value = 'off', label = 'Вимкнути журнал' }
  else
    options[#options + 1] = { value = 'on', label = 'Увімкнути журнал' }
  end
  if #entries > 0 then
    options[#options + 1] = { value = 'share', label = 'Надіслати журнал…' }
    options[#options + 1] = { value = 'copy', label = 'Скопіювати журнал' }
    options[#options + 1] = { value = 'read', label = 'Прочитати журнал' }
    options[#options + 1] = { value = 'clear', label = 'Очистити журнал' }
  end
  local choice = menu('Журнал помилок. ' .. journal_summary(), options)
  if choice == 'on' then
    set_journal(true)
    say('Журнал увімкнено. Повторіть те, що не працює, потім надішліть журнал з цього меню.', true)
  elseif choice == 'off' then
    set_journal(false)
    say('Журнал вимкнено. Записи збережено, їх можна надіслати.', true)
  elseif choice == 'share' then
    share_journal()
  elseif choice == 'copy' then
    copy_journal()
  elseif choice == 'read' then
    sf.ui.text('Журнал помилок', journal_text())
  elseif choice == 'clear' then
    sf.storage.set('journal', {})
    refresh_journal_summary()
    say('Журнал очищено.', true)
  end
end

local function main_menu()
  local now = now_ms()
  local options = {}
  for _, run in ipairs(runs) do
    options[#options + 1] = { value = 'run:' .. idstr(run.id), label = status_text(run, now) }
  end
  options[#options + 1] = { value = 'timer', label = 'Запустити таймер…' }
  options[#options + 1] = { value = 'stopwatch', label = 'Запустити секундомір…' }
  options[#options + 1] = { value = 'manage', label = 'Шаблони…' }
  options[#options + 1] = { value = 'sounds', label = 'Звуки…' }
  options[#options + 1] = { value = 'journal', label = journal_on() and 'Журнал помилок (увімкнено)…' or 'Журнал помилок…' }
  if #runs > 0 then
    options[#options + 1] = { value = 'stopall', label = 'Зупинити все' }
  end
  local choice = menu('Таймери і секундоміри', options)
  if not choice then
    return
  end
  local id = choice:match('^run:(%d+)$')
  if id then
    local run = find_run(tonumber(id))
    if run then
      run_menu(run)
    end
  elseif choice == 'timer' or choice == 'stopwatch' then
    start_menu(choice)
  elseif choice == 'manage' then
    manage_templates()
  elseif choice == 'sounds' then
    sounds_window()
  elseif choice == 'journal' then
    journal_menu()
  elseif choice == 'stopall' then
    stop_all(runs_of(nil))
  end
end

---------------------------------------------------------------------------
-- Команди
---------------------------------------------------------------------------

local function silence_alarm()
  if stop_ringing() then
    sf.speech.stop()
    say('Сигнал вимкнено.', true)
    return true
  end
  return false
end

local function handle_kind(kind)
  if silence_alarm() then
    return
  end
  local list = runs_of(kind)
  if #list == 0 then
    local id = load_defaults()[kind]
    local t = id and find_template(id)
    if t then
      start_template(t)
    else
      start_menu(kind)
    end
    return
  end
  if #list == 1 then
    local window = (tonumber(sf.settings.get('doubleWindow')) or 3) * 1000
    local previous = last_call[kind]
    if previous and sf.clock() - previous <= window then
      last_call[kind] = nil
      stop(list[1])
    else
      last_call[kind] = sf.clock()
      say(status_text(list[1], now_ms()), true)
    end
    return
  end
  running_menu(kind)
end

local function handle_pause(kind)
  if silence_alarm() then
    return
  end
  local list = runs_of(kind)
  if #list == 0 then
    say(kind == 'timer' and 'Немає запущених таймерів.' or 'Немає запущених секундомірів.', true)
    return
  end
  if #list == 1 then
    toggle_pause(list[1])
    return
  end
  local now = now_ms()
  local options = {}
  local any_running = false
  for _, run in ipairs(list) do
    options[#options + 1] = {
      value = idstr(run.id),
      label = (run.paused and 'Продовжити: ' or 'Пауза: ') .. status_text(run, now),
    }
    if not run.paused then
      any_running = true
    end
  end
  options[#options + 1] = { value = 'all', label = any_running and 'Пауза для всіх' or 'Продовжити всі' }
  local choice = menu(kind == 'timer' and 'Пауза таймера' or 'Пауза секундоміра', options)
  if choice == 'all' then
    for _, run in ipairs(list) do
      if run.paused ~= any_running then
        toggle_pause(run, true)
      end
    end
    say(any_running and 'Усі на паузі.' or 'Усі продовжено.', true)
  elseif choice then
    local run = find_run(tonumber(choice))
    if run then
      toggle_pause(run)
    end
  end
end

-- Команда: у журнал пишеться, що її запустили, і помилка, якщо вона була.
local function command(id, name, fn)
  sf.onCommand(id, guarded(name, function()
    jlog('info', 'Команда: ' .. name)
    fn()
  end))
end

command('timer', 'Таймер', function() handle_kind('timer') end)
command('stopwatch', 'Секундомір', function() handle_kind('stopwatch') end)
command('timer_pause', 'Пауза таймера', function() handle_pause('timer') end)
command('stopwatch_pause', 'Пауза секундоміра', function() handle_pause('stopwatch') end)
command('menu', 'Меню', function()
  if not silence_alarm() then
    main_menu()
  end
end)

sf.onSettingChange(function(key)
  if key == 'screenOnSummary' then
    ensure_loop()
  elseif key == 'keepAwake' and not on('keepAwake') then
    release_cpu()
  end
end)

-- Кнопки в налаштуваннях скрипта: «Звуки і гучність» і «Журнал помилок».
sf.onButton(guarded('Кнопка в налаштуваннях', function(key)
  if key == 'sounds' and not silence_alarm() then
    sounds_window()
  elseif key == 'journalMenu' then
    journal_menu()
  end
end))

---------------------------------------------------------------------------
-- Запуск скрипта
---------------------------------------------------------------------------

-- Стандартні шаблони; номер росте, коли їх більшає.
local STANDARD_VERSION = 2
if int(sf.storage.get('standardAdded', 0)) < STANDARD_VERSION then
  add_standard()
  sf.storage.set('standardAdded', STANDARD_VERSION)
end

refresh_voice_options()
refresh_journal_summary()

-- Форма лишила позначку: SandFly зупинився, поки вона була відкрита.
do
  local form = sf.storage.get('journalForm')
  if type(form) == 'string' and form ~= '' then
    pcall(sf.storage.remove, 'journalForm')
    jlog('error', 'Попереднього разу SandFly зупинився, поки була відкрита форма «' .. form .. '»')
  end
end

do
  local now = now_ms()
  process_due(now)
  schedule_wake(now)
  ensure_loop()
end
