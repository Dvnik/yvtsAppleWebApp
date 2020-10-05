<?php
require_once "connDB.php";

$sql = "SELECT * FROM `students`"; // 查詢指令
$result = mysqli_query($conn, $sql) or die("查詢失敗");
//分頁處理
//總筆數
$data_nums = mysqli_num_rows($result);
$per = 5; //
$pages = ceil($data_nums / $per);

if (!isset($_GET['page'])) {
    $page = 1;
} else {
    $page = intval($_GET['page']);
}

$start = ($page - 1) * $per;
$result = mysqli_query($conn, $sql . ' LIMIT ' . $start . ',' . $per) or die("查詢失敗");
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
    <p align='center'><a href="php_mysql_2_create.php">新增資料</a></p>
    <table border='1' align='center'>

    <form action="php_mysql_3_del.php" method="POST" action="php_mysql_3_del.php">
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
            <th colspan="3">功能</th>
        </tr>
        <?php
while ($row = mysqli_fetch_assoc($result)) {?>
        <tr>
            <td><?php echo $row['cID'] ?></td>
            <td><?php echo $row['cName'] ?></td>
            <td><?php echo $row['cSex'] ?></td>
            <td><?php echo $row['cBirthday'] ?></td>
            <td><?php echo $row['cEmail'] ?></td>
            <td><?php echo $row['cPhone'] ?></td>
            <td><?php echo $row['cAddr'] ?></td>
            <td><?php echo $row['cHeight'] ?></td>
            <td><?php echo $row['cWeight'] ?></td>
            <td><a href="php_mysql_2_del.php?cID=<?=$row['cID']?>" onclick="return confirm('確認刪除！')">刪除</a></td>
            <td><a href="php_mysql_2_detail.php?cID=<?=$row['cID']?>">修改</a></td>
            <td><input type="checkbox" name="delete[]" value="<?=$row['cID']?>"></td>
        </tr>

            <?php }

?>
<input type="submit" value="刪除" onclick="return confirm('確認刪除！');">
</form>
    </table>



    <p align='center'>
        資料筆數 <?=$data_nums?> &nbsp; 第<?=$page?>頁
    </p>

    <p align='center'/>
    <?php if ($page > 1) {?>
        <a href="?page=1">第一頁</a> | <a href="?page=<?=$page - 1;?>">上一頁</a>
    <?php }
if ($page < $pages) {?>
        <a href="?page=<?=$page + 1;?>">下一頁</a> | <a href="?page=<?=$pages;?>">最末頁</a>
    <?php }?>
</body>
</html>



<?php
mysqli_free_result($result); //釋放查詢結果(記憶體)
mysqli_close($conn); //解除資料庫連線
?>
