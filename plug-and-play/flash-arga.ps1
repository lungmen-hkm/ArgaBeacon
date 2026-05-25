$RepoUrl = "https://github.com/lungmen-hkm/ArgaBeacon.git"
$FolderName = "ArgaBeacon"

Write-Host "Starting process..." -ForegroundColor Cyan

if (-not (Test-Path -Path $FolderName)) {
    Write-Host "[*] Cloning repository ArgaBeacon..." -ForegroundColor Green
    git clone $RepoUrl
    if ($LASTEXITCODE -ne 0) {
        Write-Error "[-] Failed to clone repository. Check your internet connection and git installation."
        Exit
    }
} else {
    Write-Host "[!] Folder $FolderName already exist, skipping clone." -ForegroundColor Yellow
}

cd $FolderName

Write-Host "[*] Ensuring PlatformIO Core is installed..." -ForegroundColor Green
python -m pip install -U platformio

if ($LASTEXITCODE -ne 0) {
    Write-Error "[-] Failed to install PlatformIO. Check your Python installation."
    Exit
}

Write-Host "[*] Compiling custom firmware (custom_esp32)..." -ForegroundColor Green
pio run -e custom_esp32

if ($LASTEXITCODE -ne 0) {
    Write-Error "[-] Build failed! Check your code, there might be a typo somewhere."
    Exit
}

Write-Host "[*] Please connect your ESP32 to the USB port." -ForegroundColor Yellow
Read-Host "Once connected, press ENTER to continue..."

Write-Host "[*] Flashing firmware to ESP32..." -ForegroundColor Green
pio run -e custom_esp32 -t upload

if ($LASTEXITCODE -eq 0) {
    Write-Host "[+] Done!" -ForegroundColor Green
} else {
    Write-Error "[-] Failed to flash firmware! Check the USB cable, make sure it's a data cable and not just a charger."
}