<?php
$host = "localhost";
$user = "root";
$password = "";
$database = "pendakian_monitor";

$conn = mysqli_connect($host, $user, $password, $database);

if (!$conn) {
    die("Koneksi database gagal");
}
?>