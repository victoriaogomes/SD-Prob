// ******   Este módulo foi desenvolvido de forma extra-classe     ****** //
// ****** por Bruno C. Matias, Ellen C. Aguiar e Victória O. Gomes ****** //
// ******            do grupo P02 da disciplia TEC499.             ****** //

#include <LiquidCrystal.h>

int analogPlayer1 = A8;                                   // Entrada analógica do Player 1
int analogPlayer2 = A11;                                  // Entrada analógica do Player 1
int value1 = 0;                                           // Valor do primeiro potenciômetro
int value2 = 0;                                           // Valor do segundo potenciômetro
int leituraAtual, player1, player2;                       // Declaração de variáveis para manipulação do LCD
LiquidCrystal lcd(8, 9, 4, 5, 6, 7);                      // "Instancia" um lcd com a biblioteca LiquidCrystal

void setup() {
  //Abre a comunicação serial.
  Serial.begin(115200);                                   // Abre uma conexão com a porta principal
  Serial1.begin(115200);
  Serial2.begin(115200);                                  // Abre uma conexão com a porta serial 2
  Serial3.begin(115200);                                  // Abre uma conexão com a porta serial 3
  pinMode(22, OUTPUT);                                    // Coloca o pino de alimentação do segundo potenciômetro como output
  pinMode(26, OUTPUT);                                    // Coloca o pino de alimentação do segundo potenciômetro como output
  pinMode(52, OUTPUT);                                    // Coloca o pino de alimentação do segundo potenciômetro como output
  digitalWrite(22, HIGH);                                 // Manda a voltagem correta para o segundo potenciômetro
  digitalWrite(52, HIGH);                                 // Manda a voltagem correta para o segundo potenciômetro
  digitalWrite(26, LOW);                                  // Manda a voltagem correta para o segundo potenciômetro
  lcd.begin(16,2);                                        // Inicializa o LCD com 2 linhas e 16 colunas
  lcd.setCursor(0,0);                                     // Seta a posição na qual o cursor do LCD vai iniciar
  lcd.print("Score:");                                    // Printa na linha 1 do LCD
}

void loop() {
  value1 = analogRead(analogPlayer1);                      // Lê o potenciômetro do jogador 1
  value2 = analogRead(analogPlayer2);                      // Lê o potenciômetro do jogador 2
  float voltage1 = (value1 * (376.0 / 1023.0)) + 6;        // Limita o valor do potenciômetro para o range aceitável de Y
  float voltage2 = ((value2 * (376.0 / 1023.0)) + 6) + 512;// Limita o valor do potenciômetro para o range aceitável de Y
  Serial.print("Escrevi na uart 1 ");                      // Para debug
  Serial.print((voltage1/4));                              // Para debug
  Serial.print(" e na uart 2 ");                           // Para debug
  Serial.println((voltage2/4));                            // Para debug
  Serial2.write((voltage1/4));                             // Manda a voltagem do Jogador 1 para a UART2
  Serial3.write((voltage2/4));                             // Manda a voltagem do Jogador 2 para a UART3
  leituraAtual = Serial1.read();                           // Lê a pontuação dos jogadoes pela UART 1
  if(leituraAtual != -1){                                  // Verifica se algum dado foi recebido
    lcd.setCursor(0,1);                                    // Seta a posição do cursor para a linha 2, coluna 0
    lcd.print((bitRead(leituraAtual, 3) << 1) + (bitRead(leituraAtual, 2)));
    lcd.setCursor(1,1);                                    // Seta a posição do cursor para a linha 2, coluna 1
    lcd.print("X");                                        // Printa X no LCD
    lcd.setCursor(2,1);                                    // Seta a posição do cursor para a lnha 2, coluna 2
    lcd.print((bitRead(leituraAtual, 1) << 1) + (bitRead(leituraAtual, 0)));
  }
}
