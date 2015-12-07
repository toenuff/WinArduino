# This script assumes you are connecting to an Arduino on COM3
# This script assumes you have Arduino IDE installed in the default path

$currdir = ''
if ($MyInvocation.MyCommand.Path) {
    $currdir = Split-Path $MyInvocation.MyCommand.Path
} else {
    $currdir = $pwd -replace '^\S+::',''
}

Import-Module "$currdir/../WinArduino.psd1"
set-alias av Invoke-ArduinoIdeVerify -scope Global
set-alias au Invoke-ArduinoIdeUpload -scope Global

au (join-path $currdir 'SerialWriteExample\SerialWriteExample.ino')

# Connect to Serial Interface

$serial = Connect-ArduinoSerial

(0..5) |% {
    $seconds = get-random -maximum 3
    sleep -Seconds $seconds
    "Sending 1 to Arduinino to turn on LED"
    $serial |Write-ArduinoSerial 1
    sleep -Seconds $seconds
    "Sending 0 to Arduinino to turn off LED"
    $serial |Write-ArduinoSerial 0
}

'Sending "blah" to serial interface - this will be converted into bytes by the arduino and displayed to the serial port'
$serial |Write-ArduinoSerial "blah"

sleep -Seconds 1 

"Reading all output from the serial interface before disconnecting"
$serial |Read-ArduinoSerial

"Disconnecting Serial Interface"
$serial |Disconnect-ArduinoSerial


