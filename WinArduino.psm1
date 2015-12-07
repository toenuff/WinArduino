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

$GLOBAL:ArduinoSerialConnections = new-object System.Collections.Arraylist

function Connect-ArduinoSerial {
    param(
        [string] $Port = $GLOBAL:arduinoport,
        [int] $BaudRate = "9600",
        [string] $Parity = "None",
        [int] $DataBits = 8,
        [int] $StopBits = 1,
        [int] $ReadTimeout = 9000,
        [switch] $ReadBytes
    )
    $serial = new-object System.IO.Ports.serialport
    $serial.PortName = $port
    $serial.BaudRate = $BaudRate
    $serial.Parity = $Parity
    $serial.DataBits = $DataBits
    $serial.StopBits = $StopBits
    $serial.ReadTimeout = $ReadTimeout
    $serial |add-member -NotePropertyName "ReadBytes" -NotePropertyValue $ReadBytes
    try {
        $serial.open()
        if ($ReadBytes) {
            $job = Register-ObjectEvent -InputObject $serial -EventName DataReceived -Action {
                $count = $sender.BytesToRead
                if ($count) {
                    $buf = new-object byte[] $count
                    $sender.Read($buf, 0, $count) |out-null
                    $buf
                }
            }
        }
        else {
            $job = Register-ObjectEvent -InputObject $serial -EventName DataReceived -Action {
                $count = $sender.BytesToRead
                if ($count) {
                    $buf = new-object char[] $count
                    $sender.Read($buf, 0, $count) |out-null
                    $buf -join ''
                }
            }
        }
        # TODO This should be a ps 5 class
        $registeredserial = new-object psobject -property @{
            port = $serial
            job = $job
        }
        $ArduinoSerialConnections.Add($registeredserial) |out-null
        $registeredserial
    } catch [Exception] {
        write-error $_
    }
}

function Get-ArduinoSerial {
    $GLOBAL:ArduinoSerialConnections.ToArray()
}

function Disconnect-ArduinoSerial {
    param(
        [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true)]
        [ValidateScript({$_.port -and $_.job})]
        [psobject] $SerialConnection
    )
    BEGIN {
        $connections = @()
    }
    PROCESS {
        $connections+=$SerialConnection
    }
    END {
        foreach ($connection in $connections) {
            $connection.Port.Close()
            $connection.Job |stop-job
            $connection.Job |remove-job
            $GLOBAL:ArduinoSerialConnections.Remove($connection)
        }
    }
}

function Write-ArduinoSerial {
    param(
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [ValidateScript({$_.port -and $_.job})]
        [psobject] $SerialConnection,
        [Parameter(Mandatory=$true, Position=0)]
        [string] $InputText
    )
    PROCESS {
        $SerialConnection.Port.Write($InputText)
    }
}

function Read-ArduinoSerial {
    param(
        [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true)]
        [ValidateScript({$_.port -and $_.job})]
        [psobject] $SerialConnection
    )
    PROCESS {
        if ($SerialConnection.Job.HasMoreData) {
            if ($SerialConnection.port.ReadBytes) {
                $SerialConnection.Job |Receive-Job
            } else {
                ($SerialConnection.Job |Receive-Job) -join ''
            }
        }
    }
}

function Receive-ArduinoSerial {
    param(
        [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true)]
        [ValidateScript({$_.port -and $_.job})]
        [psobject] $SerialConnection
    )
    PROCESS {
        "Receiving Data - Ctrl-C to Break"
        while ($true) {
            if ($SerialConnection.Job.HasMoreData) {
                if ($SerialConnection.port.ReadBytes) {
                    $SerialConnection.Job |Receive-Job |write-host
                } else {
                    ($SerialConnection.Job |Receive-Job) -join '' |write-host -NoNewLine
                }
            }
        }
    }
}

