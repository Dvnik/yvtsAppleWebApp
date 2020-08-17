<?PHP
//insert into student(no,name,gender,picture,phone,address,email,class) values('222','測試',1,'images/222.jpg','091234343','地址','xyz@email.com','手機程式設計')

//http://192.168.62.9/MyDataBase/insert_data.php?no=Q345&name=康百世&gender=1&picture=images/Q345.jpg&phone=09333e34&address=台北市中山北路一段109號&email=ters@dfjd&myclass=智能裝置開發

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

//準備insert指令
$insertSQL = sprintf("insert into student(no,name,gender,picture,phone,address,email,myclass) values('%s','%s',%d,'%s','%s','%s','%s','%s')", $_GET['no'], $_GET['name'], $_GET['gender'], $_GET['picture'], $_GET['phone'], $_GET['address'], $_GET['email'], $_GET['class']);
//執行update指令
$result = mysqli_query($conn, $insertSQL) or die(mysqli_error());
//關閉資料庫連結
mysqli_close($conn);
//回傳執行狀態
echo $result;
