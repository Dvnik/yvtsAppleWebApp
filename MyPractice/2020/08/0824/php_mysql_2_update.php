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

$cID = $_POST['cID'];

$sql = "UPDATE `students` SET
        cName = '$cName',
        cSex = '$cSex',
        cBirthday = '$cBirthday',
        cEmail = '$cEmail',
        cPhone = '$cPhone',
        cAddr = '$cAddr',
        cHeight = '$cHeight',
        cWeight = '$cWeight' WHERE cID=" . $cID;

// echo $sql;

mysqli_query($conn, $sql) or die("資料庫寫入錯誤");

header("location: php_mysql_2.php");
