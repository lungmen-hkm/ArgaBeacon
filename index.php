<?php
    </div>

    <div id="map"></div>

    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Pendaki</th>
                    <th>Status</th>
                    <th>Latitude</th>
                    <th>Longitude</th>
                    <th>Waktu</th>
                </tr>
            </thead>
            <tbody>

            <?php while($row = mysqli_fetch_assoc($data)) { ?>

                <tr>
                    <td><?= $row['id']; ?></td>
                    <td><?= $row['pendaki']; ?></td>
                    <td class="danger">
                        <?= $row['status']; ?>
                    </td>
                    <td><?= $row['latitude']; ?></td>
                    <td><?= $row['longitude']; ?></td>
                    <td><?= $row['waktu']; ?></td>
                </tr>

            <?php } ?>

            </tbody>
        </table>
    </div>

</div>

<script>

const map = L.map('map').setView([-7.2575, 112.7521], 10);

L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '&copy; OpenStreetMap contributors'
}).addTo(map);

<?php
$data2 = mysqli_query($conn, "SELECT * FROM accidents");

while($d = mysqli_fetch_assoc($data2)) {
?>

L.marker([
    <?= $d['latitude']; ?>,
    <?= $d['longitude']; ?>
]).addTo(map)
.bindPopup(`
    <b><?= $d['pendaki']; ?></b><br>
    Status: <?= $d['status']; ?>
`);

<?php } ?>

</script>

</body>
</html>