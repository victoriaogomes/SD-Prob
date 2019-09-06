#include <SoftwareSerial.h>

SoftwareSerial mySerial(19, 18); // RX, TX
int analogPlayer1 = A0; // potentiometer wiper (middle terminal) connected to analog pin 3
int analogPlayer2 = A1;
int value1 = 0;  // variable to store the value1ue read
int value2 = 0;  // variable to store the value1ue read
int valorPin;

void setup() {
  // Open serial communications and wait for port to open:
  Serial.begin(115200);
  //Serial.begin(9600);           //  setup serial
  pinMode(52, OUTPUT);
  digitalWrite(52, HIGH);
  while (!Serial) {
    ; // wait for serial port to connect. Needed for Native USB only
  }
  Serial.println("Goodnight moon!");
  // set the data rate for the SoftwareSerial port
  mySerial.begin(38400);
  mySerial.println("Hello, world?");
}

void loop() {
  //valorPin = digitalRead(52);
  //Serial.print("Li o valor: ");
  //Serial.println(valorPin);
  value1 = analogRead(analogPlayer1);  // read the input pin
  value2 = analogRead(analogPlayer2);  // read the input pin
  float voltage1 = (value1 * (376.0 / 1023.0)) + 6;
  float voltage2 = ((value2 * (376.0 / 1023.0))) + 6;
  Serial.print("Player 1: ");          // debug valuelue
  Serial.print(voltage1);
  Serial.print("| Player 2:");          // debug valuelue
  Serial.println(voltage2);
  delay(1000);
  //if (Serial.available()){
  //  Serial.print("Escrevi na uart: ");
  //  Serial.print(voltage1);
  //  mySerial.write(voltage1);
  //  Serial.println("");
  //}
  //if (mySerial.available()){
  //  Serial.print("Li da uart: ");
  //  Serial.write(mySerial.read());
  //  Serial.println("");
  //}
}
