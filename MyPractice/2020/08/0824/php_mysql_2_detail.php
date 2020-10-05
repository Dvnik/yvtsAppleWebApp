<?php
require_once "connDB.php";
$cID = $_GET['cID'];
// echo $cID;

$sql = "SELECT * FROM `students` WHERE cID={$cID}"; // cID" . $cID;
$result = mysqli_query($conn, $sql);

$row = mysqli_fetch_array($result);
?>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>學生資料管理系統</title>
</head>
<body>
    <h1 align='center'>學生資料管理系統 - 更新資料</h1>
    <p align='center'><a href="php_mysql_2.php">回主頁面</a></p>
    <form action="php_mysql_2_update.php" method="POST" name=formAdd id="formAdd">

        <table border="2" align="center">
            <tr>
                <th>欄位</th>
                <th>資料</th>
            </tr>
            <tr>
                <td>姓名</td>
                <td><input type="text" name="cName" id="cName" value="<?=$row['cName']?>" ></td>
            </tr>
            <tr>
                <td>性別</td>
                <td>
                    <input type="radio" name="cSex" id="radio" value="M"
                    <?php
if ($row['cSex'] == "M") {
    echo "checked";
}
?>

                    >男
                    <input type="radio" name="cSex" id="radio" value="F"
                    <?php
if ($row['cSex'] == "F") {
    echo "checked";
}
?>
                    >女
                </td>
            </tr>
            <tr>
                <td>生日</td>
                <td><input type="date" name="cBirthday" id="cBirthday" value="<?=$row['cBirthday']?>" ></td>
            </tr>
            <tr>
                <td>電子郵件</td>
                <td><input type="email" name="cEmail" id="cEmail" value="<?=$row['cEmail']?>" ></td>
            </tr>
            <tr>
                <td>電話</td>
                <td><input type="tel" name="cPhone" id="cPhone" value="<?=$row['cPhone']?>" ></td>
            </tr>
            <tr>
                <td>住址</td>
                <td><input type="text" name="cAddr" id="cAddr" value="<?=$row['cAddr']?>" ></td>
            </tr>
            <tr>
                <td>身高</td>
                <td><input type="number" name="cHeight" id="cHeight" value="<?=$row['cHeight']?>" ></td>
            </tr>
            <tr>
                <td>體重</td>
                <td><input type="number" name="cWeight" id="cWeight" value="<?=$row['cWeight']?>" ></td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                <input type="hidden" name="cID" value="<?=$row['cID']?>">
                <input type="submit" name="button" id="button" value="修改資料">
                <input type="reset" name="button2" id="button2" value="重新填寫">
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
