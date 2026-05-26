<img width="266" height="272" alt="logo" src="https://github.com/user-attachments/assets/1b8db56f-bb72-4457-a0d3-0d44a24d9bdd" />

# ArgaBeacon

ArgaBeacon adalah proyek open-source yang bertujuan meningkatkan keamanan dalam sistem pendakian gunung di Indonesia dengan memanfaatkan teknologi Internet of Things (IoT), seperti ESP32, LoRa, serta topologi mesh yang didukung oleh [Meshtastic](https://meshtastic.org/). Karena manusia ternyata suka naik gunung lalu panik ketika sinyal menghilang. Evolusi memang bekerja dengan cara yang unik.

---

## Latar Belakang

ArgaBeacon terinspirasi dari berbagai kecelakaan pendakian yang pernah terjadi di Indonesia, khususnya di Gunung Rinjani. Salah satu peristiwa yang menjadi perhatian adalah kecelakaan Juliana Marins, warga negara Brasil, pada Juni 2025. Kejadian tersebut mengingatkan bahwa keamanan dalam aktivitas pendakian masih menjadi hal yang sangat penting.

Melalui proyek ini, kami mencoba menghadirkan solusi berbasis teknologi yang dapat membantu proses monitoring, pelacakan, dan komunikasi darurat di area pendakian yang sulit dijangkau jaringan konvensional.

---

## Topologi Mesh

ArgaBeacon menggunakan topologi mesh karena lebih efektif digunakan pada medan pegunungan yang sulit dijangkau. Selain mampu memperluas jangkauan komunikasi antar perangkat, topologi ini juga lebih efisien dari segi biaya dibandingkan topologi peer-to-peer tradisional.

Dengan sistem mesh, setiap node dapat meneruskan data ke node lainnya sehingga komunikasi tetap dapat berlangsung meskipun tidak ada akses internet atau jaringan seluler.

---

## Cara Kerja

ArgaBeacon terdiri dari beberapa komponen utama, yaitu:

- ESP32
- Modul GPS
- Antena LoRa
- Tombol tactile
- RFID

Seluruh komponen dikemas dalam bentuk perangkat portabel menyerupai HT mini yang dipasang pada bagian belakang tas pendaki.

Selain perangkat yang dibawa pendaki, terdapat juga:

- Unit basecamp
- Unit repeater

Kedua unit tersebut ditempatkan di beberapa titik strategis dan ditenagai menggunakan panel surya.

### Sistem Absensi

Pendaki melakukan absensi di camp menggunakan RFID dengan cara melakukan tapping pada unit yang tersedia.

### Mode Darurat

Tombol tactile berfungsi sebagai tombol darurat yang akan mengirimkan koordinat lokasi pendaki melalui channel LongFast pada jaringan Meshtastic.

---

# Konfigurasi Perkabelan

## Koneksi ESP32 ke SX1278

| ESP32 Pin | SX1278 Pin | Keterangan |
|-----------|------------|-------------|
| GPIO5     | SCK        | SPI Clock |
| GPIO19    | MISO       | SPI MISO |
| GPIO27    | MOSI       | SPI MOSI |
| GPIO18    | NSS/CS     | Chip Select |
| GPIO14    | RESET      | Pin Reset |
| GPIO26    | DIO0       | Pin Interrupt |
| 3.3V      | VCC        | Tegangan 3.3V |
| GND       | GND        | Ground |

---

## Koneksi Layar

- GPIO21 → SDA
- GPIO22 → SCL

---

## Koneksi GPS (Opsional)

- GPIO16 → GPS RX
- GPIO17 → GPS TX

---

# Proses Porting

## 1. Membuat Custom Variant

```cpp
// Custom variant definition in firmware/custom_board/variant.h
#define PIN_SPI_SCK 5
#define PIN_SPI_MOSI 27
#define PIN_SPI_MISO 19
#define PIN_SPI_SS 18
#define PIN_LORA_RESET 14
#define PIN_LORA_DIO0 26
#define I2C_SDA 21
#define I2C_SCL 22
#define BUTTON_PIN 0
#define BATTERY_PIN 35
#define GPS_RX_PIN 16
#define GPS_TX_PIN 17
```

## 2. Konfigurasi Custom PlatformIO

```ini
[env:custom_esp32]
platform = espressif32
board = esp32dev
framework = arduino

build_flags =
    ${arduino_base.build_flags}
    -D ARDUINO_ARCH_ESP32
    -D HAS_BLUETOOTH=1
    -D HAS_SCREEN=1
    -D USE_SH1106=0
    -D USE_SSD1306=1
    -D SCREEN_WIDTH=128
    -D SCREEN_HEIGHT=64
    -D HAS_GPS=1
    -D HAS_BUTTON=1
    -D LORA_SCK=5
    -D LORA_MISO=19
    -D LORA_MOSI=27
    -D LORA_CS=18
    -D LORA_RESET=14
    -D LORA_DIO0=26

lib_deps =
    ${arduino_base.lib_deps}
```

## 3. Modifikasi Modul Radio
```cpp
// Modified radio detection in src/detect/LoRaRadioType.h
if (!sx1278) {
    sx1278 = new Arduino_LORA(
        LORA_CS,
        LORA_DIO0,
        LORA_RESET,
        LORA_SCK,
        LORA_MISO,
        LORA_MOSI
    );

    if (sx1278->begin(
        BANDWIDTH,
        SPREADING_FACTOR,
        CODING_RATE,
        FREQUENCY,
        SYNC_WORD
    )) {
        radioType = meshtastic_RadioType_SX1278;
        return sx1278;
    }
}
```

## Membangun Custom Firmware

1. Clone repositori ini
2. Install PlatformIO
3. Bangun Custom firmware:

```bash
pio run -e custom_esp32
```

4. Sambungkan ESP32 via USB dan flash:

```bash
pio run -e custom_esp32 -t upload
```

## Menggunakan Kode Plug-n-Play

1. Pergi ke [Releases](https://github.com/lungmen-hkm/ArgaBeacon/releases)
2. Download File yang diperlukan (.ps1 untuk windows) dan (.sh untuk linux)
3. Untuk sistem operasi windows lakukan
```PowerShell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process
.\flash-arga.ps1
```
4. Untuk sistem operasi berbasis linux lakukan
```bash
chmod +x flash-arga.sh
./flash-arga.sh
```

## Flash kode untuk unit absensi

Gunakan kode [esp32.cpp](web-absensi/esp32.cpp) yang tersedia.

## Configurasi

Setelah flashing, sambungkan device dengan:

1. The Meshtastic mobile app ([Android](https://play.google.com/store/apps/details?id=com.geeksville.mesh) or [iOS](https://apps.apple.com/us/app/meshtastic/id1586432531))
2. The [Meshtastic web interface](https://meshtastic.org/app)
3. Command-line tools with `pip install meshtastic`

## Fitur

- Koneksi Mesh LoRa (up to 5km line-of-sight)
- Koneksi Bluetooth untuk konfigurasi
- GPS Tracker
- Berbagi Koordinat secara langsung

## License

This project is licensed under the GNU General Public License v3.0 - see [LICENSE](LICENSE) for details.

## Acknowledgments

- The Meshtastic project for the original firmware
- The open-source community for support and testing
- [charan-271](https://github.com/charan-271) for the codebase

## Special Thanks

- [charan-271](https://github.com/charan-271)
- [NanangMRK](https://youtube.com/nanangmrk)