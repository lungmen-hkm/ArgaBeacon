<?php
include 'db.php';

$latitude = $_POST['latitude'];
$longitude = $_POST['longitude'];
$status = $_POST['status'];
$pendaki = $_POST['pendaki'];

$query = "INSERT INTO accidents(latitude, longitude, status, pendaki)
VALUES('$latitude','$longitude','$status','$pendaki')";

if(mysqli_query($conn, $query)) {
    echo "Data berhasil masuk";
} else {
    echo "Gagal";
}
?>