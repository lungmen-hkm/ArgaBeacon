#include <WiFi.h>
#include <HTTPClient.h>

const char* ssid = "admin-camp";
const char* password = "admin1234";

String serverName = "http://localhost:8080/api/absensi.php";

void kirimUID(String uid){

  if(WiFi.status()== WL_CONNECTED){

    HTTPClient http;

    http.begin(serverName);
    http.addHeader("Content-Type", "application/json");

    String jsonData = "{\"uid\":\"" + uid + "\"}";

    int httpResponseCode = http.POST(jsonData);

    http.end();
  }
}