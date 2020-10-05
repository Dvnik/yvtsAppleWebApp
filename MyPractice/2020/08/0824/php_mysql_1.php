<?php
// $host = "localhost";  // 只有主機名稱
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
// 查詢資料庫
$sql = "SELECT * FROM `students`"; // 查詢指令

$result = mysqli_query($conn, $sql);

// $row = mysqli_fetch_assoc($result); //提取一筆關聯陣列的資料

// var_dump($row);// 列出陣列裡面的詳細內容

// echo $row['cID'] . $row['cName'] . $row['cSex'] . $row['cBirthday'] . $row['cEmail'] . $row['cPhone'] . $row['cAdds'] . $row['cHeight'] . $row['cWeight'];

echo "<h1 align='center'>學生資料管理系統</h1>";
echo "<table border='1' align='center'>";
echo "<tr>
<th>座號</th>
<th>姓名</th>
<th>性別</th>
<th>生日</th>
<th>電子郵件</th>
<th>電話</th>
<th>地址</th>
<th>身高</th>
<th>體重</th>
</tr>";
while ($row = mysqli_fetch_assoc($result)) {
    echo "<tr>";
    echo "<td>" . $row['cID'] . "</td>";
    echo "<td>" . $row['cName'] . "</td>";
    echo "<td>" . $row['cSex'] . "</td>";
    echo "<td>" . $row['cBirthday'] . "</td>";
    echo "<td>" . $row['cEmail'] . "</td>";
    echo "<td>" . $row['cPhone'] . "</td>";
    echo "<td>" . $row['cAddr'] . "</td>";
    echo "<td>" . $row['cHeight'] . "</td>";
    echo "<td>" . $row['cWeight'] . "</td>";
    echo "</tr>";
}

echo "</table>";

mysqli_free_result($result); //釋放查詢結果(記憶體)
mysqli_close($conn); //解除資料庫連線
