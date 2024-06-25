<?php 
    include './db.php';
    $sql = "SELECT * FROM reservasikamar WHERE Status is Confirmed'";
    $query = $connection->query($sql);

    echo "$query->num_rows";

?>