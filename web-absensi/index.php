<?php
include 'koneksi.php';

$result = $conn->query("
SELECT * FROM absensi
ORDER BY id DESC
LIMIT 200
");
?>

<!DOCTYPE html>
<html>
<head>
    <title>Absensi NFC</title>
    <link rel="stylesheet" href="assets/style.css">
</head>
<body>

<h1>Absensi NFC</h1>

<table>
    <tr>
        <th>Nama</th>
        <th>Nomor Tiket</th>
        <th>Waktu</th>
    </tr>

    <?php while($row = $result->fetch_assoc()) { ?>

    <tr>
        <td><?= $row['nama'] ?></td>
        <td><?= $row['uid'] ?></td>
        <td><?= $row['waktu'] ?></td>
    </tr>

    <?php } ?>

</table>

</body>
</html>
