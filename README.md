# PowerShell Arduino Module
This module provides a suite of functions that allows you to interact with your Arduino through Windows PowerShell.

The module was created because I was struggling to find a way to use my console editor (vim) and compile/upload/etc my arduino code from Windows.  Currently, I'm adding functions as I need them while working through the University of California, Irvine Arduino course entitled "[The Arduino Platform and C Programming](https://www.coursera.org/learn/arduino-platform)".

# Requirements
Compile and upload functionality relies on [Arduino IDE](https://www.arduino.cc/en/Main/Software).  This must be installed prior to using verify or upload commands. 

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

# Additional Notes

You must install [Arduino IDE](https://www.arduino.cc/en/Main/Software) in order to use this module.

The docs for the Arduino IDE commandline can be found [here](https://github.com/arduino/Arduino/blob/master/build/shared/manpage.adoc)
