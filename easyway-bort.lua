local manifest = {
  id = 'easyway-bort',
  name = 'EasyWay: board number and map',
  version = '1.1',
  author = 'shpak',
  minApiVersion = 2,
  testedApiVersion = 5,
  description = 'On the stop screen, each vehicle reads in two swipes: 1) route, board number and destination; 2) when it arrives and when the next one comes. The map becomes a single swipe stop without markers, or can be hidden completely. Speaks Ukrainian.',
  apps = { 'com.eway' },
  permissions = { 'screen', 'speech' },
  settings = {
    {
      key = 'hideMap',
      type = 'switch',
      title = 'Приховати карту повністю',
      summary = 'Вимкнено: карта - одна зупинка свайпу. Увімкнено: свайп її пропускає',
      default = false,
    },
  },
  rules = {
    -- Маркери на карті нічого не кажуть ("Маркер на карті"), тож свайп їх пропускає,
    -- і карта лишається однією зупинкою.
    { match = { contentDescription = 'Маркер на карті' }, hide = true },
    { match = { className = 'View', inside = { className = 'TextureView', contentDescription = 'Карта Google' } }, hide = true },
  },
}

-- Карта повністю, з усім, що в ній, - лише коли ввімкнено налаштування.
local MAP_RULES = {
  { match = { className = 'TextureView', contentDescription = 'Карта Google' }, hide = 'all' },
  { match = { className = 'SurfaceView', contentDescription = 'Карта Google' }, hide = 'all' },
}
local map_rule_ids = {}

local function apply_map_setting(hide)
  for _, id in ipairs(map_rule_ids) do
    sf.rules.remove(id)
  end
  map_rule_ids = {}
  if hide then
    for _, rule in ipairs(MAP_RULES) do
      map_rule_ids[#map_rule_ids + 1] = sf.rules.add(rule)
    end
  end
end

apply_map_setting(sf.settings.get('hideMap') == true)
sf.onSettingChange(function(key, value)
  if key == 'hideMap' then
    apply_map_setting(value == true)
  end
end)

-- Кожен рядок на екрані зупинки EasyWay має дві частини, і обидві вже окремі зупинки свайпу:
--   com.eway:id/main    - опис "Автобус 16. ...Прямує до X.Наступний за 19 хв." без бортового номера;
--                         всередині поля route, number (бортовий), nextStop, nextArrival, message.
--   com.eway:id/arrival - "Прибуття по GPS через 4 хвилини"; всередині time, timeUnit, interval.
-- Скрипт додає бортовий номер у першу частину, а "Наступний за ..." переносить у другу.
--
-- Читати поля рядка в onFocus не можна: SandFly чекає лише 30 мс. Тому onFocus глушить
-- звичайне озвучення, а таймер одразу після нього читає рядок і промовляє наш текст.

local focus_count = 0

local function short_id(item)
  return ((item and item.id) or ''):match('[^/]*$')
end

local function present(text)
  if text ~= nil and text ~= '' then
    return text
  end
end

local function trim(text)
  return ((text or ''):match('^%s*(.-)%s*$'))
end

-- Прибирає з тексту шматок [part], без шаблонів Lua.
local function remove_plain(text, part)
  if not present(part) then
    return text
  end
  local from, to = text:find(part, 1, true)
  if not from then
    return text
  end
  local result = text:sub(1, from - 1) .. text:sub(to + 1)
  -- Зайва крапка, що лишилась після вирізаного речення, і подвійні пробіли.
  result = result:gsub('%.%s*%.', '.'):gsub('%s%s+', ' ')
  return trim(result)
end

-- Поля всередині частини рядка, за короткими id.
local function fields_of(item)
  local fields = {}
  for _, child in ipairs(item:children() or {}) do
    local id = short_id(child)
    if id ~= '' and fields[id] == nil then
      fields[id] = present(trim(child.text or child.contentDescription))
    end
  end
  return fields
end

-- "BC0216OC" -> "BC 0216 OC", щоб синтезатор читав по частинах.
local function spaced_plate(plate)
  plate = plate:gsub('(%a)(%d)', '%1 %2')
  plate = plate:gsub('(%d)(%a)', '%1 %2')
  return plate
end

-- Перша частина: "Автобус 16, бортовий BC 0216 OC. ...Прямує до X." без "Наступний за ...".
local function describe_main(item, fallback)
  local f = fields_of(item)
  local text = trim(item.contentDescription or fallback or '')
  text = remove_plain(text, f.nextArrival)
  if f.number then
    -- Назва транспорту і маршрут - це все до першої крапки: "Автобус 16", "Приміський автобус 133А".
    local head, rest = text:match('^(.-)%.%s*(.*)$')
    local board = 'бортовий ' .. spaced_plate(f.number)
    if head then
      text = head .. ', ' .. board .. '. ' .. rest
    else
      text = text .. ', ' .. board
    end
  end
  return trim(text)
end

-- Друга частина: "Прибуття по GPS через 4 хвилини. Наступний за 19 хв."
local function describe_arrival(item, fallback)
  local f = fields_of(item)
  local text = trim(item.contentDescription or fallback or '')
  -- Для руху за розкладом EasyWay пише лише "Прибуття за розкладом кожні" без чисел.
  if text:find('кожні$') and f.time then
    text = text .. ' ' .. f.time .. ' ' .. (f.timeUnit or 'хв')
  end
  local parent = item:parent()
  local main = parent and parent:find({ id = 'main' })
  local next_arrival = main and main:find({ id = 'nextArrival' })
  if next_arrival and present(next_arrival.text) then
    text = text .. '. ' .. trim(next_arrival.text)
  end
  return trim(text)
end

local function say(kind, item, fallback, count)
  local ok, text = pcall(kind == 'main' and describe_main or describe_arrival, item, fallback)
  if not ok then
    sf.log.warn('EasyWay: ' .. tostring(text))
    text = fallback
  end
  -- Якщо фокус уже пішов далі, не перебиваємо новий елемент.
  if count == focus_count and present(text) then
    sf.speak(text, { interrupt = true })
  end
end

sf.onFocus(function(item, text)
  focus_count = focus_count + 1
  local id = short_id(item)
  if id ~= 'main' and id ~= 'arrival' then
    return
  end
  sf.setTimeout(say, 0, id, item, text, focus_count)
  return false
end)
