#include <WiFi.h>
#include <HTTPClient.h>

const char* ssid = "ABSENSI";
const char* password = "12345678";

String serverName = "http://192.168.1.10/api/absensi.php";

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