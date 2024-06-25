<?php 
    include './db.php';
    $sql = "SELECT * FROM kamar";
    $query = $connection->query($sql);

    echo "$query->num_rows";

?>