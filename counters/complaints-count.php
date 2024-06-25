<?php 
    include './db.php';
    $sql = "SELECT * FROM kritiksaran";
    $query = $connection->query($sql);

    echo "$query->num_rows";

?>