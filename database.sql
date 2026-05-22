CREATE DATABASE pendakian_monitor;

USE pendakian_monitor;

CREATE TABLE accidents (
    id INT AUTO_INCREMENT PRIMARY KEY,
    latitude VARCHAR(50),
    longitude VARCHAR(50),
    status VARCHAR(100),
    pendaki VARCHAR(100),
    waktu TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);