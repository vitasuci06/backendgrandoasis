<?php 
    include './db.php';
    $sql = "SELECT * FROM admin";
    $query = $connection->query($sql);

    echo "$query->num_rows";

?>