# PowerShell Arduino IDE Module
This module simply wraps the commandline functionality of the [Arduino IDE](https://www.arduino.cc/en/Main/Software) so that it can be invoked from PowerShell in a more PowerShell way.  The module was created because I was struggling to find a way to use my console editor (vim) and compile/upload/etc my arduino code from Windows.

Currently, I'm adding functions as I need them while working through the University of California, Irvine Arduino course entitled "[The Arduino Platform and C Programming](https://www.coursera.org/learn/arduino-platform)".

# Usage
```powershell
PS C:\Dropbox\scripts\ArduninoIde> Import-Module .\ArduinoIde.psd1
PS C:\Dropbox\scripts\ArduninoIde> set-alias av Invoke-ArduinoIdeVerify
PS C:\Dropbox\scripts\ArduninoIde> av .\sketch_nov25a\sketch_nov25a.ino
Loading configuration...
Initializing packages...
Preparing boards...
Verifying...

Sketch uses 450 bytes (1%) of program storage space. Maximum is 32,256 bytes.
Global variables use 9 bytes (0%) of dynamic memory, leaving 2,039 bytes for local variables. Maximum is 2,048 bytes.
```

By default the module uses the default installation paths of Ardunio IDE.  It creates a global variable named $arduinoidepath with this location. If you have installed Arduinio IDE in a different directory, you can use the following command to set the path to the exe:
```powershell
Set-ArduinoIdeExePath c:\ArudinoIde\arduino_debug.exe
```

* Note on Windows arduino_debug.exe is the executable you should use for commandline interactions.

# Additional Notes

You must install [Arduino IDE](https://www.arduino.cc/en/Main/Software) in order to use this module.

The docs for the Arduino IDE commandline can be found [here](https://github.com/arduino/Arduino/blob/master/build/shared/manpage.adoc)
