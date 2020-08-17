<?PHP
//http://studio-pj.com/class_exercise/delete_data.php?no=K668
//http://192.168.62.9/MyDataBase/delete_data.php?no=B105
//指定網頁的中文格式
header("Content-type: text/html; charset=utf-8");
//連接資料庫
$user = "root"; //資料庫帳號
$password = "1qaz@wsx"; //資料庫密碼
$host = "127.0.0.1"; //資料庫IP
$db = "mydb"; //資料庫名稱
$conn = mysqli_connect($host, $user, $password) or die("資料庫連線錯誤！");
//指定連線的資料庫
mysqli_select_db($conn, $db);
//指定資料庫使用的編碼
mysqli_query($conn, "SET NAMES utf8");

//讀取要刪除資料的primary key
$pkNo = $_GET['no'];

//安全性檢查（僅提示參考性做法）
//    $loginName = $_GET['loginName'];
//    $password = $_GET['password']
//
//    if $loginName == ''
//    {
//        exit
//    }

//============先檢查資料庫資料是否存在============
$selectSQL = sprintf("select * from student where no='%s'", $pkNo);
//執行select指令
$result = mysqli_query($conn, $selectSQL) or die(mysqli_error());
if ($row_array = mysqli_fetch_row($result)) {
    //該筆資料存在
    $dataExist = 1;
} else {
    //找不到該筆資料
    $dataExist = 0;
}
//===============實際刪除資料庫資料===============
//準備delete指令
$deleteSQL = sprintf("delete from student where no='%s'", $pkNo);
//執行delete指令
$result = mysqli_query($conn, $deleteSQL) or die(mysqli_error());

if ($dataExist == 1 && $result == 1) {
    //刪除伺服器上對應學號的上傳檔案
    @unlink('images/' . $pkNo . '.jpg');
    //回傳執行成功
    echo "1";
} else {
    //回傳執行失敗
    echo "0";
}
//關閉資料庫連結
mysqli_close($conn);
