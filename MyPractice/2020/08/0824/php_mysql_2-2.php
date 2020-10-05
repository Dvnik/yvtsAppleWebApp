<?php
require_once "connDB.php";

$sql = "SELECT * FROM `students`"; // 查詢指令
$result = mysqli_query($conn, $sql);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <h1 align='center'>學生資料管理系統</h1>
    <table border='1' align='center'>
        <tr>
            <th>座號</th>
            <th>姓名</th>
            <th>性別</th>
            <th>生日</th>
            <th>電子郵件</th>
            <th>電話</th>
            <th>地址</th>
            <th>身高</th>
            <th>體重</th>
        </tr>
        <?php
while ($row = mysqli_fetch_assoc($result)) {?>
        <tr>
            <td><?=$row['cID']?></td>
            <td><?=$row['cName']?></td>
            <td><?=$row['cSex']?></td>
            <td><?=$row['cBirthday']?></td>
            <td><?=$row['cEmail']?></td>
            <td><?=$row['cPhone']?></td>
            <td><?=$row['cAddr']?></td>
            <td><?=$row['cHeight']?></td>
            <td><?=$row['cWeight']?></td>
        </tr>

            <?php }

?>
    </table>
</body>
</html>



<?php
mysqli_free_result($result); //釋放查詢結果(記憶體)
mysqli_close($conn); //解除資料庫連線
?>
