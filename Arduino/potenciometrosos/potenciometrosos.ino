// *****Este módulo foi desenvolvido de forma extra-classe*******
// ******pelos componentes do grupo de TEC499. *******************/
//#include <Servo.h>

int analogPlayer1 = A0;                                 // Entrada analógica do Player 1
int analogPlayer2 = A1;                                 // Entrada analógica do Player 1
int value1 = 0;                                         // Valor do primeiro potenciômetro
int value2 = 0;                                         // Valor do segundo potenciômetro
int valorPin;

void setup() {
  //Abre a comunicação serial.
  Serial.begin(9600);                                   // Abre uma conexão com a porta principal
  Serial2.begin(9600);                                  // Abre uma conexão com a porta serial 2
  Serial3.begin(9600);                                  // Abre uma conexão com a porta serial 3
  pinMode(52, OUTPUT);                                  // Coloca o pino de alimentação do segundo potenciômetro como output
  digitalWrite(52, HIGH);                               // Manda a voltagem correta para o segundo potenciômetro
}

 // Função a ser executada eternamente.
void loop() {
  //valorPin = digitalRead(52);
  //Serial.print("Li o valor: ");
  //Serial.println(valorPin);
  value1 = analogRead(analogPlayer1);                      // Lê o potenciômetro do jogador 1
  value2 = analogRead(analogPlayer2);                      // Lê o potenciômetro do jogador 2
  float voltage1 = (value1 * (376.0 / 1023.0)) + 6;        // Limita o valor do potenciômetro para o range aceitável de Y
  float voltage2 = ((value2 * (376.0 / 1023.0))) + 6;      // Limita o valor do potenciômetro para o range aceitável de Y
  //Serial.print("Player 1: ");                            // Para debug
  //Serial.print(voltage1);                                // Para debug
  //Serial.print("| Player 2:");                           // Para debug
  //Serial.println(voltage2);                              // Para debug
  delay(5000);                                             // Delay para permitir a UART respirar
  //if (Serial2.available()){
    Serial.print("Escrevi na uart: ");                     // Para debug
    Serial.print(voltage1);                                // Para debug
    Serial.println("");                                    // Para debug
    Serial2.print(voltage1);                               // Manda a voltagem do Jogador 1 para a UART2
    Serial3.print(voltage2);                               // Manda a voltagem do Jogador 2 para a UART3
  //}
  //if (Serial2.available()){
    Serial.print("Li da uart: ");                          // Para debug
    Serial.print(Serial2.parseFloat());                    // Para debug
    Serial.println("");                                    // Para debug
  //}
}
