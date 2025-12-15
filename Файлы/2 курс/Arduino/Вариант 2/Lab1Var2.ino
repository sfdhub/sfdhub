#include <LiquidCrystal_I2C.h>
#include <iarduino_DHT.h>

#define LED 2
#define Buzzer 3
#define smokePin A0
#define flamePin A1

int gazThresMax = 400;
int gazThresLow = 70;
int TempThresMax = 70;
int TempThresLow = 27;

iarduino_DHT dht(4);
LiquidCrystal_I2C lcd(0x27, 16, 2);  // адрес, столбцов, строк

void setup() {
  pinMode(Buzzer, OUTPUT);
  pinMode(flamePin, INPUT);
  pinMode(smokePin, INPUT);
  pinMode(LED, OUTPUT);

  Serial.begin(9600);

  lcd.init();           // инициализация
  lcd.backlight();      // включить подсветку  
}

int temp = 0;

void loop() {

  int smokeSensor = analogRead(smokePin);
  int flameValue = analogRead(flamePin);
  if (dht.read() == DHT_OK) {
      temp = dht.tem;
      lcd.setCursor(0, 0);
      lcd.print((String) dht.hum + "% " + temp + "C");
  }

  lcd.setCursor(0, 1);
  lcd.print("G:");
  lcd.setCursor(2, 1);
  lcd.print(smokeSensor);

  lcd.setCursor(6, 1);
  lcd.print("f: ");
  lcd.setCursor(8, 1);
  lcd.print(1024 - flameValue);

  // Проверяем, достигнуто ли пороговое значение
  if (smokeSensor > gazThresMax || temp > TempThresMax || flameValue < 400) {  // если значение больше допустимого...       
  // выводим в порт надпись, что газ есть
    digitalWrite(LED, HIGH);
    tone(Buzzer, 1000);  // пищать на пине buzzer, 1 кГц
    lcd.setCursor(13, 1);
    lcd.print("NOK");
    delay(500);
    digitalWrite(LED, LOW);
  } else if (smokeSensor > gazThresLow || temp > TempThresLow) {
    digitalWrite(LED, HIGH);
    tone(Buzzer, 500);  // пищать на пине buzzer, 500 Гц;
    lcd.setCursor(13, 1);
    lcd.print("NOK");
    delay(1500);
    noTone(Buzzer);
    delay(1500);
  } else {
    noTone(Buzzer);
    digitalWrite(LED, LOW);
    lcd.setCursor(14, 1);
    lcd.print("OK");
  }
  
  delay(1000);
  lcd.clear();
  
}
