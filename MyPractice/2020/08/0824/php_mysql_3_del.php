<?php

require_once "connDB.php";

$del = $_POST['delete'];

// var_dump($del);

foreach ($del as $value) {
    mysqli_query($conn, "DELETE FROM `students` WHERE cID=" . $value) or die("資料庫寫入錯誤");
}

header("location: php_mysql_3.php");
