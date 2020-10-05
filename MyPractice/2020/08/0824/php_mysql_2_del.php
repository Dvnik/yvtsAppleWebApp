<?php
require_once "connDB.php";

$cID = $_GET['cID'];
// echo $cID;

$sql = "DELETE FROM `students` WHERE cID= " . $cID;

// echo $sql;
mysqli_query($conn, $sql) or die("資料庫寫入錯誤");

header("location: php_mysql_2.php");
