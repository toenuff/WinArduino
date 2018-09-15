# PowerShell Arduino Module
This module provides a suite of Windows PowerShell functions that allows you to interact with your Arduino through a commandline from a Windows computer.


# Requirements
Compile and upload functionality currently relies on [Arduino IDE](https://www.arduino.cc/en/Main/Software).  This must be installed prior to using the Invoke-ArduinoVerify and Invoke-ArduinoUpload functions.

# Usage

```powershell
PS C:\Dropbox\scripts\WinArduino> Import-Module .\WinArduino.psd1
PS C:\Dropbox\scripts\WinArduino> set-alias av Invoke-ArduinoIdeVerify
PS C:\Dropbox\scripts\WinArduino> av .\Blink\Blink.ino
Loading configuration...
Initializing packages...
Preparing boards...
Verifying...

Sketch uses 1,030 bytes (3%) of program storage space. Maximum is 32,256 bytes.
Global variables use 9 bytes (0%) of dynamic memory, leaving 2,039 bytes for local variables. Maximum is 2,048 bytes.

PS C:\Dropbox\scripts\WinArduino> set-alias au Invoke-ArduinoIdeUpload
PS C:\Dropbox\scripts\WinArduino> au .\Blink\Blink.ino
Loading configuration...
Initializing packages...
Preparing boards...
Verifying and uploading...

Sketch uses 1,030 bytes (3%) of program storage space. Maximum is 32,256 bytes.
Global variables use 9 bytes (0%) of dynamic memory, leaving 2,039 bytes for local variables. Maximum is 2,048 bytes.
11:29:55
```

By default the module uses the default installation paths of Ardunio IDE.  It creates a global variable named $arduinoidepath with this location. If you have installed Arduinio IDE in a different directory, you can use the following command to set the path to the exe:
```powershell
Set-ArduinoIdeExePath c:\ArudinoIde\arduino_debug.exe
```

By default the module assumes that your Arduino is connected on COM3.  You may specify another port by using the Set-ArduinoPort command:
```powershell
Set-ArduinoPort COM4
```

* Note on Windows arduino_debug.exe is the executable you should use for commandline interactions.

WinArduino provides a native way of connecting, reading, and writing to a serial connection to the Arduino.  The code in /examples shows an end-to-end example including the upload of exaple arduino sketches that will illustrate how you can use WinArduino to control and debug your Arduino.  The following snippets show quick examples of the available cmdlets for interacting with the serial interfaces:

Reading can be done with Read-ArduinoSerial:
```powershell
$serial = Connect-ArduinoSerial
$data = $serial |Read-ArduinoSerial
$data
```

You can start a real-time stream of the data coming from the Arduino by using Receive-ArduinoSerial:
```powershell
$serial |Receive-ArduinoSerial
```

You can write data to the Arduino with Write-ArduinoSerial:
```powershell
$serial |Write-ArduinoSerial 1
$serial |Write-ArduinoSerial 'Complex strings'
$serial |Write-ArduinoSerial ([byte[]]@(32, 20, 255, 8, 15))
```

You can disconnect all serial sessions with the following:
```powershell
Get-ArduinoSerial |Disconnect-ArduinoSerial
```

# Additional Notes

I highly recommend taking the Coursera course from the University of California, Irvine entitled "[The Arduino Platform and C Programming](https://www.coursera.org/learn/arduino-platform)".  This was the course I took that made me write the WinArduino module.

Some of the functionality of this module relies on the Arduino IDE commandline interface.  What is possible is documented [here](https://github.com/arduino/Arduino/blob/master/build/shared/manpage.adoc).  If I'm missing some functionality you need, please drop me a note in the Issues or feel free to make pull requests.
