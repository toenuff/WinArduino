byte inByte;
// the setup function runs once when you press reset or power the board
void setup() {
  // initialize digital pin 13 as an output.
  pinMode(13, OUTPUT);
  Serial.begin(9600);
}
// the loop function runs over and over again forever
void loop() {
    if (Serial.available() > 0) {
        inByte = Serial.read();        
        if (inByte == '1') {
            digitalWrite(13, HIGH);   // turn the LED on (HIGH is the voltage level)
            Serial.println("LED On");
        }
        else if (inByte == '0') {
            digitalWrite(13, LOW);   // turn the LED on (HIGH is the voltage level)
            Serial.println("LED Off");
        }
        else {
            Serial.println(inByte);
        }
    }
}
