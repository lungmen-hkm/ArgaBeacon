<?php

$db = new SQLite3('../database/absensi.db');

$data = json_decode(file_get_contents("php://input"), true);

$uid = $data['uid'];

$stmt = $db->prepare("SELECT nama FROM users WHERE uid = :uid");
$stmt->bindValue(':uid', $uid);
$result = $stmt->execute()->fetchArray();

if($result){

    $nama = $result['nama'];

    $insert = $db->prepare("
        INSERT INTO absensi (nama, uid)
        VALUES (:nama, :uid)
    ");

    $insert->bindValue(':nama', $nama);
    $insert->bindValue(':uid', $uid);
    $insert->execute();

    echo json_encode([
        "status" => "success",
        "nama" => $nama
    ]);

} else {

    echo json_encode([
        "status" => "unknown"
    ]);

}
?>