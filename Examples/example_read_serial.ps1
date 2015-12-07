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

au (join-path $currdir 'SerialReadExample\SerialReadExample.ino')

sleep 1

# Connect to Serial Interface

$serial = Connect-ArduinoSerial

"Example of reading from the Arduino serial interface on demand"
sleep 5
$serial |Read-ArduinoSerial

#"Example of reading from the Arduino serial interface interactively"
#$serial |Receive-ArduinoSerial

"Disconnecting Serial Interface"
$serial |Disconnect-ArduinoSerial


