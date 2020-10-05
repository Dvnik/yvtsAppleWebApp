<?php

$host = "localhost:3306"; // 指定主機名稱同時也定port的寫法
$user = "root"; // 登入帳號
$password = "1qaz@wsx"; // 登入密碼
$port = "3306"; //SQL預設port
$db = "class"; // 資料庫名稱
//PHP連上MySQL的方法
// 方法１
$conn = mysqli_connect($host, $user, $password) or die("資料庫連接錯誤");
// $conn = @mysqli_connect($host, $user, $password) or die("資料庫連接錯誤");
// 方法2
// $conn = mysqli_connect($host, $user, $password, $db, $port) or die("資料庫連接錯誤");
// 選擇資料庫
mysqli_select_db($conn, $db);
mysqli_query($conn, "set names utf8");
