#include <Preferences.h>
#include <WiFi.h>
#include <WebServer.h>
#include "web_server.h"
#include "dustbin_project_include.h"


Preferences preferences;
uint32_t blink_delay = 0;



Servo servo1;
void TaskBlink(void* p) {
  pinMode(33, OUTPUT);
  for (;;) {
    if (blink_delay == 0) {
      vTaskDelay(pdMS_TO_TICKS(1000));
      continue;
    }
    digitalWrite(33, HIGH);
    vTaskDelay(pdMS_TO_TICKS(blink_delay));
    digitalWrite(33, LOW);
    vTaskDelay(pdMS_TO_TICKS(blink_delay));
  }
}
void setup() {
  Serial.begin(115200);
  // Serial.println();
  pinMode(33, OUTPUT);
  // Serial.print("hello");
  while (!Serial)
    ;
  servo1.attach(SERVOPIN);
  preferences.begin("Switches", false);
  createWiFiAccessPoint();
  servo1.write(CLOSE);
  if (preferences.isKey(WIFI_SSID_KEY) && preferences.isKey(WIFI_PASSWORD_KEY)) {
    createWiFiStation();

  } else {
    createWiFiAccessPoint();
  }
  createServer();

  xTaskCreate(
    TaskBlink, "Task Blink", 2048, nullptr, 1, NULL  // Task handle is not used here - simply pass NULL
  );
}

void loop() {
  // put your main code here, to run repeatedly:
  // server.handleClient();
  webSocket.loop();
  delay(50);
}
