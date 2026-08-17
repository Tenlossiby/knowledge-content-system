function FromCodePoints([int[]] $codes) {
  return -join ($codes | ForEach-Object { [char]$_ })
}

$root = Split-Path -Parent $PSScriptRoot
$files = Get-ChildItem -LiteralPath $root -Recurse -File | Where-Object { $_.Extension -in '.md', '.yaml' }
$text = ($files | ForEach-Object { Get-Content -Raw -Encoding utf8 $_.FullName }) -join "`n"
$systemName = FromCodePoints @(0x77e5,0x8bc6,0x5185,0x5bb9,0x7cfb,0x7edf)
$explicitCalls = @(
  $systemName,
  ((FromCodePoints @(0x7528)) + $systemName),
  ((FromCodePoints @(0x8c03,0x7528)) + $systemName),
  ((FromCodePoints @(0x6253,0x5f00)) + $systemName),
  ((FromCodePoints @(0x542f,0x52a8)) + $systemName)
)

if ((Get-Content -Raw -Encoding utf8 (Join-Path $root 'skill.yaml')) -notmatch [regex]::Escape("name: $systemName")) { throw 'skill.yaml display name is incorrect.' }
if ((Get-Content -Raw -Encoding utf8 (Join-Path $root 'agents\openai.yaml')) -notmatch [regex]::Escape("display_name: `"$systemName`"")) { throw 'OpenAI display name is incorrect.' }
foreach ($phrase in $explicitCalls) {
  if ($text -notmatch [regex]::Escape($phrase)) { throw "Missing explicit invocation: $phrase" }
}
if ($text -match 'Professional Method Compiler') { throw 'Unexpected user-visible legacy English name.' }
$noWrite = FromCodePoints @(0x4e0d,0x521b,0x5efa,0x957f,0x671f,0x8bb0,0x5fc6,0x6216,0x5de5,0x4f5c,0x7a7a,0x95f4)
$legacyWorkspace = FromCodePoints @(0x65e7,0x5de5,0x4f5c,0x533a)
if ($text -notmatch [regex]::Escape($noWrite)) { throw 'Default no-write protection missing.' }
if ($text -notmatch [regex]::Escape($legacyWorkspace)) { throw 'Legacy workspace compatibility missing.' }
Write-Output 'Knowledge Content System rename acceptance checks: PASS'
