$ErrorActionPreference = 'Stop'
$path = 'C:\Users\ijasp\OneDrive\Desktop\userapk\lib\feature\address\view\add_address_screen.dart'
$text = [System.IO.File]::ReadAllText($path)
$old = @'
      }
    }
  }

  @override
  Widget build(BuildContext context) {
'@
$new = @'
      }
  }

  @override
  Widget build(BuildContext context) {
'@
if (-not $text.Contains($old)) { throw 'Save method ending did not match; no changes written.' }
$text = $text.Replace($old, $new)
[System.IO.File]::WriteAllText($path, $text, [System.Text.UTF8Encoding]::new($false))
Write-Output 'Address save method braces repaired.'
