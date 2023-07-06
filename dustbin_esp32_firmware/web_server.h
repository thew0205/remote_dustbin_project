#include <Arduino.h>
#include <WiFi.h>
#include <Servo.h>
#include <WebSocketsServer.h>
#include <Preferences.h>
#include <esp_http_server.h>
#include "dustbin_project_include.h"


#define CLOSE 0
#define OPEN 55
#define SERVOPIN 15

extern WebSocketsServer webSocket;
extern Preferences preferences;
extern uint32_t blink_delay;
extern Servo servo1;

void createWiFiAccessPoint();
void createWiFiStation();
void createServer();