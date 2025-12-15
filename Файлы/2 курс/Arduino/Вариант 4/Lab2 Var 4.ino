#include <ESP8266WiFi.h>
#include <WiFiClient.h>
#include <ESP8266WebServer.h>
#include <DS1307RTC.h>

#ifndef STASSID
#define STASSID "AndroidAP_5536"
#define STAPSK "09091212"
#endif

#define PIN_PHOTO_SENSOR 16
#define PIN_LED_SENSOR 13
#define PIN_BEEPER_SENSOR 12

const char* ssid = STASSID;
const char* password = STAPSK;

ESP8266WebServer server(80);

const char* CURRENT_DATETIME_PARAMETER = "current-time";
const char* START_LIGHT_TIME = "start-light";
const char* END_LIGHT_TIME = "end-light";
const char* START_BEEP_TIME = "start-beep";
const char* END_BEEP_TIME = "end-beep";

tmElements_t startLightTime;
tmElements_t endLightTime;
tmElements_t startBeepTime;
tmElements_t endBeepTime;

tmElements_t currentDateTime;
bool isDay = false;
bool isLed = false;
bool isBeep = false;

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

void setup(void) {
  Serial.begin(9600);
  Serial.println("Program start!\n");
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
  server.on("/set", HTTP_POST, handle_form);

  server.on("/inline", []() {
    server.send(200, "text/plain", "this works as well");
  });

  server.onNotFound(handleNotFound);

  server.begin();
  Serial.println("HTTP server started");

  pinMode(PIN_PHOTO_SENSOR, INPUT);
  pinMode(PIN_LED_SENSOR, OUTPUT);
  pinMode(PIN_BEEPER_SENSOR, OUTPUT);

}

void loop(void) {
  server.handleClient();
  if(RTC.read(currentDateTime)) {
    //Serial.print(currentDateTime.Second);
    //Serial.print('\n');
  }

  isDay = !digitalRead(PIN_PHOTO_SENSOR);
  isLed = !isDay && TimePointInHours(currentDateTime, startLightTime, endLightTime);
  if(isLed) {
    digitalWrite(PIN_LED_SENSOR, HIGH);
  }
  else {
    digitalWrite(PIN_LED_SENSOR, LOW);
  }

  isBeep = TimePointInHours(currentDateTime, startBeepTime, endBeepTime);
  if(isBeep) {
    digitalWrite(PIN_BEEPER_SENSOR, HIGH);
  }
  else {
    digitalWrite(PIN_BEEPER_SENSOR, LOW);
  }
}


bool TimePointInHours(tmElements_t time, tmElements_t start, tmElements_t end)
{
  if(start.Hour > end.Hour) 
  {
    tmElements_t midnightMinusOne;
    midnightMinusOne.Hour = 23;
    midnightMinusOne.Minute = 59;
    tmElements_t midnight;
    midnight.Hour = 0;
    midnight.Minute = 0;
    return TimePointInHours(time, start, midnightMinusOne) || TimePointInHours(time, midnight, end);
  }
  int curMinutes = time.Hour * 60 + time.Minute;
  int startMinutes = start.Hour * 60 + start.Minute;
  int endMinutes = end.Hour * 60 + end.Minute;
  return curMinutes >= startMinutes && curMinutes <= endMinutes;
}

void handle_form() {
  if ( server.hasArg( CURRENT_DATETIME_PARAMETER ) && server.arg( CURRENT_DATETIME_PARAMETER) != NULL ) {
    String cur = server.arg(CURRENT_DATETIME_PARAMETER);
    String year_s = String(cur[0]) + String(cur[1]) + String(cur[2]) + String(cur[3]);
    String month_s = String(cur[5]) + String(cur[6]);
    String day_s = String(cur[8]) + String(cur[9]);
    String hour_s = String(cur[11]) + String(cur[12]);
    String minute_s = String(cur[14]) + String(cur[15]);
    currentDateTime.Year = year_s.toInt() - 1970;
    currentDateTime.Month = month_s.toInt();
    currentDateTime.Day = day_s.toInt();
    currentDateTime.Hour = hour_s.toInt();
    currentDateTime.Minute = minute_s.toInt();
    RTC.write(currentDateTime);
  }
  if ( server.hasArg( START_LIGHT_TIME ) && server.arg( START_LIGHT_TIME ) != NULL ) {
    String cur = server.arg(START_LIGHT_TIME);
    String hour_s = String(cur[0]) + String(cur[1]);
    String minute_s = String(cur[3]) + String(cur[4]);
    startLightTime.Hour = hour_s.toInt();
    startLightTime.Minute = minute_s.toInt();
  }
  if ( server.hasArg( END_LIGHT_TIME ) && server.arg( END_LIGHT_TIME ) != NULL ) {
    String cur = server.arg(END_LIGHT_TIME);
    String hour_s = String(cur[0]) + String(cur[1]);
    String minute_s = String(cur[3]) + String(cur[4]);
    endLightTime.Hour = hour_s.toInt();
    endLightTime.Minute = minute_s.toInt();
  }

  if ( server.hasArg( START_BEEP_TIME ) && server.arg( START_BEEP_TIME ) != NULL ) {
    String cur = server.arg(START_BEEP_TIME);
    String hour_s = String(cur[0]) + String(cur[1]);
    String minute_s = String(cur[3]) + String(cur[4]);
    startBeepTime.Hour = hour_s.toInt();
    startBeepTime.Minute = minute_s.toInt();
  }
  if ( server.hasArg( END_BEEP_TIME ) && server.arg( END_BEEP_TIME ) != NULL ) {
    String cur = server.arg(END_BEEP_TIME);
    String hour_s = String(cur[0]) + String(cur[1]);
    String minute_s = String(cur[3]) + String(cur[4]);
    endBeepTime.Hour = hour_s.toInt();
    endBeepTime.Minute = minute_s.toInt();
  }
  
  server.sendHeader("Location", "/",true);   //Redirect to our html web page
  server.send(302, "text/plane","");
}


String SendHTML()
{
  String ptr = "<!DOCTYPE html> <html>\n";
  ptr +="<head><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, user-scalable=no\">\n";
  ptr +="<title>LED Control</title>\n";
  ptr +="<style>html { font-family: Helvetica; display: inline-block; margin: 0px auto; text-align: center;}\n";
  ptr +="body{margin-top: 50px;} h1 {color: #444444;margin: 50px auto 30px;} h3 {color: #444444;margin-bottom: 50px;}\n";
  ptr +=".button {display: block;width: 80px;background-color: #1abc9c;border: none;color: white;padding: 13px 30px;text-decoration: none;font-size: 25px;margin: 0px auto 35px;cursor: pointer;border-radius: 4px;}\n";
  ptr +=".button-on {background-color: #1abc9c;}\n";
  ptr +=".button-on:active {background-color: #16a085;}\n";
  ptr +=".button-off {background-color: #34495e;}\n";
  ptr +=".button-off:active {background-color: #2c3e50;}\n";
  ptr +="p {font-size: 14px;color: #888;margin-bottom: 10px;}\n";
  ptr +="</style>\n";
  ptr +="</head>\n";
  ptr +="<body>\n";
  if(isDay) 
    ptr += "<h1>Is day</h1>\n";
  else
    ptr += "<h1>Is night</h1>\n";
  if(isLed) 
    ptr += "<h1>Light</h1>\n";
  if(isBeep)
    ptr += "<h1>Beep</h1>\n";

  String curDateTime = tmElementsToStringDateTime(currentDateTime);
  ptr += "<form action=\"/set\" method=\"POST\">\n";
  ptr += "Current DateTime: <input type=\"datetime-local\" name=\"current-time\" id=\"current-time\" " + String("value=\"") + String(curDateTime) + "\"/>\n";
  ptr += "<input type=\"submit\" value=\"Submit\">\n";
  ptr += "</form><br>";



  String slTimeValue = tmElementsToStringTime(startLightTime);
  ptr += "<form action=\"/set\" method=\"POST\">\n";
  ptr += "Start Light Time: <input type=\"time\" name=\"start-light\" id=\"start-light\" " + String("value=\"") + String(slTimeValue) + "\"/>\n";
  ptr += "<input type=\"submit\" value=\"Submit\">\n";
  ptr += "</form><br>";

  String elTimeValue = tmElementsToStringTime(endLightTime);
  ptr += "<form action=\"/set\" method=\"POST\">\n";
  ptr += "End Light Time: <input type=\"time\" name=\"end-light\" id=\"end-light\" " + String("value=\"") + String(elTimeValue) + "\"/>\n";
  ptr += "<input type=\"submit\" value=\"Submit\">\n";
  ptr += "</form><br>";

  String sbTimeValue = tmElementsToStringTime(startBeepTime);
  ptr += "<form action=\"/set\" method=\"POST\">\n";
  ptr += "Start Beep Time: <input type=\"time\" name=\"start-beep\" id=\"start-beep\" " + String("value=\"") + String(sbTimeValue) + "\"/>\n";
  ptr += "<input type=\"submit\" value=\"Submit\">\n";
  ptr += "</form><br>";

  String ebTimeValue = tmElementsToStringTime(endBeepTime);
  ptr += "<form action=\"/set\" method=\"POST\">\n";
  ptr += "End Beep Time: <input type=\"time\" name=\"end-beep\" id=\"end-beep\" " + String("value=\"") + String(ebTimeValue) + "\"/>\n";
  ptr += "<input type=\"submit\" value=\"Submit\">\n";
  ptr += "</form><br>";

  ptr +="</body>\n";
  ptr +="</html>\n";
  return ptr;
}

String tmElementsToStringTime(tmElements_t dt)
{
  String answer = addLeftZeros(String(dt.Hour), 2) + String(":") + addLeftZeros(String(dt.Minute),2);
  return answer;
}


String tmElementsToStringDateTime(tmElements_t dt)
{
  String answer = addLeftZeros(String(dt.Year + 1970), 4)+String("-")+addLeftZeros(String(dt.Month), 2) + String("-") + addLeftZeros(String(dt.Day), 2);
  answer += "T" + addLeftZeros(String(dt.Hour), 2) + String(":") + addLeftZeros(String(dt.Minute),2);
  return answer;
}

String addLeftZeros(String str, int targetLen) 
{
  if(str.length() >= targetLen)
    return str;
  int diff = targetLen - str.length();
  String left = "";
  while(diff--)
    left += "0";
  return left+str;
}