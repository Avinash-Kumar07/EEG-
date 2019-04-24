int value;                           // Initilize a value to store input

void setup() {
  Serial.begin(9600);               // Initilize Serial Port
  pinMode(13, OUTPUT);               // Define pins of On Board LED

}

void loop() {
  if (Serial.available() > 0) {    // Run inside only if there is data available

    value = Serial.read();         // Assigning serial data to value
    Serial.println(value);         // Displaying serial data
    if (value == 1) {               //___________________
      digitalWrite(13, HIGH);       // One type of Output
    }                               //___________________
    if (value == 2) {               //_______________________
      digitalWrite(13, LOW);        // Another type of Output
    }                               //_______________________
  }

}
