#include <LCDI2C_Multilingual.h>
#include <iarduino_DHT.h>
#include <ESP8266WiFi.h>
#include <WiFiClient.h>
#include <ESP8266WebServer.h>

#define LED D7
#define Buzzer D8
#define smokePin A0
#define flamePin D5
#define DHT D6

const char* ssid = "";
const char* password = "" ;

int gazThresMax = 800;
int gazThresLow = 560;
int TempThresMax = 70;
int TempThresLow = 28;

iarduino_DHT dht(DHT);
LCDI2C_Latin_Symbols lcd(0x27, 16, 2);  // адрес, столбцов, строк
ESP8266WebServer server(80);

void handleRoot() {
  server.send(200, "text/html", SendHTML());
}

void handleNotFound() {
  String message = "File Not Found\n\n";
  message += "URI: ";
  message += server.uri();
  message += "\nMethod: ";
  message += (server.method() == HTTP_GET) ? "GET" : "POST";
  message += "\nArguments: ";
  message += server.args();
  message += "\n";
  for (uint8_t i = 0; i < server.args(); i++) { message += " " + server.argName(i) + ": " + server.arg(i) + "\n"; }
  server.send(404, "text/plain", message);
}

void setup() {
  Serial.begin(9600);

  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, password);
  Serial.println("");

  // Wait for connection
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.print("Connected to ");
  Serial.println(ssid);
  Serial.print("IP address: ");
  Serial.println(WiFi.localIP());

  server.on("/", handleRoot);
  server.on("/set", HTTP_POST, HandleSet);
  server.onNotFound(handleNotFound);
  server.begin();
  Serial.println("HTTP server started");

  pinMode(Buzzer, OUTPUT);
  pinMode(flamePin, INPUT);
  pinMode(smokePin, INPUT);
  pinMode(LED, OUTPUT);

  lcd.init();           // инициализация
  lcd.backlight();      // включить подсветку  
}

int temp = 0, humidity = 0, smokeSensor = 0, flameValue = 0;
bool isAlerActive = false;

void loop() {
  server.handleClient();
  smokeSensor = analogRead(smokePin);
  flameValue = 1024 - analogRead(flamePin);
  if (dht.read() == DHT_OK) {
      temp = dht.tem;
      humidity = dht.hum;
  }

  // Проверяем, достигнуто ли пороговое значение
  if (smokeSensor > gazThresMax || temp > TempThresMax || flameValue > 400) {  // если значение больше допустимого...       
  // выводим в порт надпись, что газ есть
    digitalWrite(LED, HIGH);
    tone(Buzzer, 1000);  // пищать на пине buzzer, 1 кГц
    isAlerActive = true;
    lcd.clear();
    lcd.setCursor(2, 1);
    lcd.print("ALERT!");
    delay(500);
    digitalWrite(LED, LOW);
  } else if (smokeSensor > gazThresLow || temp > TempThresLow) {
    digitalWrite(LED, HIGH);
    tone(Buzzer, 500);  // пищать на пине buzzer, 500 Гц;
    isAlerActive = true;
    lcd.clear();
    lcd.setCursor(0, 1);
    lcd.print("ALERT!");
    delay(1500);
    noTone(Buzzer);
    delay(1500);
  } else {
    isAlerActive = false;
    noTone(Buzzer);
    digitalWrite(LED, LOW);
    lcd.clear();
    lcd.setCursor(2, 1);
    lcd.print("NO ALERT");
  }

  delay(300);

}

void HandleSet() {
 
  if (server.hasArg("TLT")) {
    TempThresLow = server.arg("TLT").toInt();
  }
  if (server.hasArg("THT")) {
    TempThresMax = server.arg("THT").toInt();
  }
  if (server.hasArg("GLT")) {
    gazThresLow = server.arg("GLT").toInt();
  }
  if (server.hasArg("GHT")) {
    gazThresMax = server.arg("GHT").toInt();
  }
  server.sendHeader("Location", "/",true);   //Redirect to our html web page
  server.send(302, "text/plane","");
}

String SendHTML()
{
  String html = "<!DOCTYPE html> <html>\n<head><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, user-scalable=no\">\n";
  html +="<title>LED Control</title>\n<style>html { font-family: Helvetica; display: inline-block; margin: 0px auto; text-align: center;}\n";
  html +="body{margin-top: 50px;} h1 {color: #444444;margin: 50px auto 30px;} h3 {color: #444444;margin-bottom: 50px;}\n";
  html +=".button {display: block;width: 80px;background-color: #1abc9c;border: none;color: white;padding: 13px 30px;text-decoration: none;font-size: 25px;margin: 0px auto 35px;cursor: pointer;border-radius: 4px;}\n";
  html +=".button-on {background-color: #1abc9c;}\n.button-on:active {background-color: #16a085;}\n.button-off {background-color: #34495e;}\n.button-off:active {background-color: #2c3e50;}\np {font-size: 14px;color: #888;margin-bottom: 10px;}\n";
  html +="</style>\n</head>\n<body>\n";
  if(isAlerActive) {
    html += "<h1>Alert Active!!!!!!!!</h1>\n";
  } else {
    html += "<h1>All OK</h1>\n";
  }

  html += "<h1>Temperature ";
  html += temp;
  html += " C ";
  html += "Humidity: ";
  html += humidity;
  html += " %<h1>";
  html += "<h1>Smoke: ";
  html +=  smokeSensor;
  html += " | ";
  if (smokeSensor > gazThresLow) {
    html += "GAS DETECTED!";
  }else {
    html += "gas not detected!";
  }
  html += "<h1>Flame: ";
  if (flameValue > 1000) {
    html += "Fire!";
  }else {
    html += "Not detected!";
  }
  html += "<h4>";

  html += "<form action=\"/set\" method=\"POST\">\n";
  html += "Temperature low thresold: <input name=\"TLT\" id=\"TLT\"" + String("value=\"") + String(TempThresLow) + "\"/><br>";
  html += "Temperature high thresold: <input name=\"THT\" id=\"THT\"" + String("value=\"") + String(TempThresMax) + "\"/><br>";
  html += "Gaz low thresold: <input name=\"GLT\" id=\"GLT\"" + String("value=\"") + String(gazThresLow) + "\"/><br>";
  html += "Gaz high thresold: <input name=\"GHT\" id=\"GHT\" " + String("value=\"") + String(gazThresMax) + "\"/><br>";
  html += "<input type=\"submit\" value=\"Submit\">\n";
  html += "</form><br>";


  html +="</h4></body>\n";
  html +="</html>\n";
  return html;
}

