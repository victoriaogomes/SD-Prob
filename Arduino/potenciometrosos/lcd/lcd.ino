#include <LiquidCrystal.h>

//Rs, Enable, D4, D5, D6, D7
LiquidCrystal(22,10,24,8,26);


void setup() {
  lcd.begin(16,2);
  lcd.print("hello, world!");

}

void loop() {
  lcd.setCursor(0,1);
  lcd.print(millis()/1000);
}
