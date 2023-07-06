#include <esp_http_server.h>
#include "web_server.h"

static void webSocketEvent(uint8_t num, WStype_t type, uint8_t * payload, size_t length);


WebSocketsServer webSocket = WebSocketsServer(81);

void createWiFiAccessPoint() {
  WiFi.mode(WIFI_AP);
  WiFi.softAP("Switches Dustbin", "password");
  Serial.println("Access point");
  IPAddress IP = WiFi.softAPIP();
  Serial.print("AP IP address: ");
  Serial.println(IP);
}


void createWiFiStation() {
  WiFi.mode(WIFI_STA);
  WiFi.disconnect();
  char ssid[20];
  char password[20];
  preferences.getString(WIFI_SSID_KEY, ssid, 20);
  preferences.getString(WIFI_PASSWORD_KEY, password, 20);
  Serial.print("Connecting to wifi ssid:");
  Serial.print(ssid);
  Serial.print("\t password: ");
  Serial.println(password);
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println(WiFi.localIP());
}

/* Our URI handler function to be called during GET /uri request */
esp_err_t index_get_handler(httpd_req_t *req) {
  /* Send a simple response */
  const char resp[] = "Welcome to temi's project... more details to be provoded";
  httpd_resp_send(req, resp, HTTPD_RESP_USE_STRLEN);
  return ESP_OK;
}




void createServer() {
  httpd_config_t config = HTTPD_DEFAULT_CONFIG();
  config.server_port = 80;
  /* Empty handle to esp_http_server */
  httpd_handle_t server = NULL;
  httpd_uri_t index_uri = {
    .uri = "/",
    .method = HTTP_GET,
    .handler = index_get_handler,
    .user_ctx = NULL
  };


  // Serial.printf("Starting web server on port: '%d'\n", config.server_port);
  if (httpd_start(&server, &config) == ESP_OK) {
    httpd_register_uri_handler(server, &index_uri);
  }


  webSocket.begin();
  webSocket.onEvent(webSocketEvent);
}


static void webSocketEvent(uint8_t num, WStype_t type, uint8_t *payload, size_t length) {
  char action[25] = { 0 };
  char number[5] = { 0 };
  char flash[2] = { 0 };
  switch (type) {
    case WStype_DISCONNECTED:
      Serial.printf("[%u] Disconnected!\n", num);
      break;
    case WStype_CONNECTED:
      {
        IPAddress ip = webSocket.remoteIP(num);
        Serial.printf("[%u] Connected from %d.%d.%d.%d url: %s\n", num, ip[0], ip[1], ip[2], ip[3], payload);
      }
      break;
    case WStype_TEXT:
      switch ((char)payload[0]) {
        case '0':
          blink_delay = 500;
          servo1.write(CLOSE);
          webSocket.sendTXT(num,"0");
          break;
        case '1':
          blink_delay = 100;
          servo1.write(OPEN);
          webSocket.sendTXT(num,"1");
          break;
      }
     
      break;
    case WStype_BIN:
    case WStype_ERROR:
    case WStype_FRAGMENT_TEXT_START:
    case WStype_FRAGMENT_BIN_START:
    case WStype_FRAGMENT:
    case WStype_FRAGMENT_FIN:
      break;
  }
}