<?php 
    include './db.php';
    $sql = "SELECT * FROM reservasikamar";
    $query = $connection->query($sql);

    echo "$query->num_rows";

?>