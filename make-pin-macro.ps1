# Робить файл макросу SandFly, який вводить PIN-код на екрані блокування.
# Макроси, на відміну від скриптів, працюють і одразу після перезавантаження,
# до першого розблокування телефона.
#
# Запуск у PowerShell 7:  pwsh -File make-pin-macro.ps1 123456
# Файл auto-pin-macro.json з'явиться поруч зі скриптом (інше місце: -Out шлях)
param(
  [Parameter(Mandatory = $true)][string]$Pin,
  [string]$Out
)

if ($Pin -notmatch '^(\d{4}|\d{6})$') {
  Write-Error 'PIN-код має бути з 4 або 6 цифр'
  exit 1
}
if (-not $Out) {
  $dir = $PSScriptRoot
  $Out = Join-Path $dir 'auto-pin-macro.json'
}

function IdTest($id) { [ordered]@{ test = 'item'; label = "^$id`$"; regex = $true; field = 'id' } }
function TextRegex($d) { "^$d`$|^$d[ ,]+\S{1,5}`$|^$d[ ,]+\S{1,5} \S{1,5}`$" }
function TextTest($d) { [ordered]@{ test = 'item'; label = (TextRegex $d); kind = 'clickable'; regex = $true } }
function With($table, $extra) { $copy = [ordered]@{}; foreach ($k in $table.Keys) { $copy[$k] = $table[$k] }; foreach ($k in $extra.Keys) { $copy[$k] = $extra[$k] }; $copy }

$okRegex = '^(OK|ОК|Готово|Ввести|Ввод|Enter|Done|Підтвердити|Подтвердить)$'
$steps = [System.Collections.Generic.List[object]]::new()

# Кнопок PIN-коду ще немає: просимо відкрити їх і чекаємо до 20 секунд.
$steps.Add([ordered]@{ type = 'if'; condition = @((With (IdTest 'key1') @{ not = $true }), (With (TextTest 1) @{ not = $true })) })
$steps.Add([ordered]@{ type = 'speak_text'; text = 'Проведіть двома пальцями вгору' })
$steps.Add([ordered]@{ type = 'end_if' })
$steps.Add([ordered]@{ type = 'wait_until'; condition = @((IdTest 'key1'), (With (TextTest 1) @{ or = $true })); timeout = 20000 })
# Клавіатура ще виїжджає.
$steps.Add([ordered]@{ type = 'wait'; ms = 500 })

foreach ($ch in $Pin.ToCharArray()) {
  $d = [string]$ch
  $steps.Add([ordered]@{ type = 'if'; condition = @((IdTest "key$d")) })
  $steps.Add([ordered]@{ type = 'tap'; label = "^key$d`$"; regex = $true; field = 'id'; timeout = 2000 })
  $steps.Add([ordered]@{ type = 'else' })
  $steps.Add([ordered]@{ type = 'tap'; label = (TextRegex $d); regex = $true; timeout = 2000 })
  $steps.Add([ordered]@{ type = 'end_if' })
}

# OK, якщо така кнопка є (після 4 цифр телефон часто відкривається сам).
$steps.Add([ordered]@{ type = 'if'; condition = @((IdTest 'key_enter')) })
$steps.Add([ordered]@{ type = 'tap'; label = '^key_enter$'; regex = $true; field = 'id'; timeout = 1000 })
$steps.Add([ordered]@{ type = 'else_if'; condition = @([ordered]@{ test = 'item'; label = $okRegex; kind = 'clickable'; regex = $true }) })
$steps.Add([ordered]@{ type = 'tap'; label = $okRegex; regex = $true; timeout = 1000 })
$steps.Add([ordered]@{ type = 'end_if' })

$file = [ordered]@{
  format  = 'sandfly-items'
  version = 1
  macros  = @([ordered]@{
      id        = 'auto-pin'
      name      = 'Ввести PIN-код'
      condition = @([ordered]@{ test = 'locked' })
      steps     = $steps
    })
}

[System.IO.File]::WriteAllText($Out, ($file | ConvertTo-Json -Depth 10), [System.Text.UTF8Encoding]::new($false))
Write-Output "Готово: $Out"
