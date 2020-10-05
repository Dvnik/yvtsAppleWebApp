<?php
require_once "connDB.php";

$cName = $_POST['cName'];
$cSex = $_POST['cSex'];
$cBirthday = $_POST['cBirthday'];
$cEmail = $_POST['cEmail'];
$cPhone = $_POST['cPhone'];
$cAddr = $_POST['cAddr'];
$cHeight = $_POST['cHeight'];
$cWeight = $_POST['cWeight'];

$sql = "INSERT INTO `students` (cName, cSex, cBirthday, cEmail, cPhone, cAddr, cHeight, cWeight) VALUES ('$cName', '$cSex', '$cBirthday', '$cEmail', '$cPhone', '$cAddr', '$cHeight', '$cWeight')";

echo $sql;

mysqli_query($conn, $sql) or die("資料庫寫入錯誤");

// header("Refresh:5; url=php_mysql_2.php");

header("location: php_mysql_2.php");
