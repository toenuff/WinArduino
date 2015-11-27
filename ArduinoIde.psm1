$GLOBAL:arduinoidepath = 'C:\Program Files (x86)\Arduino\arduino_debug.exe'

function Set-ArduinoIdeExePath {
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [ValidateScript({Test-Path $_})]
        [string] $Path
    )
    $GLOBAL:arduinoidepath = $Path
}

function Get-ArduinoIdeExePath {
    $GLOBAL:arduinoidepath
}

function Invoke-ArduinoIdeVerify {
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [ValidateScript({Test-Path $_})]
        [string] $Path
    )
    & $arduinoidepath --verify $Path
}
