$GLOBAL:arduinoidepath = 'C:\Program Files (x86)\Arduino\arduino_debug.exe'
$GLOBAL:arduinoport = 'COM3'

function Get-ArduinoIdeExePath {
    $GLOBAL:arduinoidepath
}

function Set-ArduinoIdeExePath {
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [ValidateScript({Test-Path $_})]
        [string] $Path
    )
    $GLOBAL:arduinoidepath = $Path
}

function Get-ArduinoPort {
    $GLOBAL:arduinoport
}

function Set-ArduinoPort {
    param(
        [Parameter(Mandatory=$true, position=0)]
        [string] $Port='COM3'
    )
}

function Invoke-ArduinoIdeVerify {
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [ValidateScript({Test-Path $_})]
        [string] $Path
    )
    & $arduinoidepath --verify $path
}

function Invoke-ArduinoIdeUpload {
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [ValidateScript({Test-Path $_})]
        [string] $Path
    )
    & $arduinoidepath --upload $path --port $arduinoport
}
