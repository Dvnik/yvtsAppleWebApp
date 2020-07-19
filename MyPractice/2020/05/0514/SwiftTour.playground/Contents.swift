import UIKit
// 列印除錯訊息
print("Hello, world!")

//==============簡單值（Simple Values）==============
//使用let來宣告一個常數，用var來宣告一個變數。
var myVariable = 42  // 單一等號為設定值
myVariable = 50 // 因為宣告為變數，可以改值

// myVariable = 1.33 // 但是不能更改為不同型別的值

print(myVariable)

let myConstant = 42
// myConstant = 60 // 此行錯誤，因為常數不能變動


var str = "Hello, playground" // 第一次設值時為文字，故推測此變數的型別為String
str = "Wellcome"



//由給定值來推測型別
let implicitInteger = 70
let implicitDouble = 70.0
let explicitDouble: Double = 70     //明確指定型別

var expicitDouble2: Double // 未設定值之前，無法使用變數
expicitDouble2 = 69.88
print(expicitDouble2)

let explicitInteger: UInt // 宣告無號整數

explicitInteger = 48 // 第一次設定常數值之後即不可變動
print(explicitInteger)


//【練習1】宣告一個常數，明確指定型別為Float並指定初始值為4
let constantFloat: Float
constantFloat = 4


//沒有隱含的性型別轉換，不同型別須自行轉型
let label = "寬度："  // String
let width = 94  // Int
let widthLabel = label + String(width)  //數字轉型文字


let testInt = Int(label) // 轉型不一定成功，一旦不成功，其值為空值(nil)

let strInt = "123"
let aInt = Int(strInt)
print(aInt!)

//【練習2】刪除最後一行中的String，錯誤提示是什麼？
// Binary operator '+'cannot be applied to operands of type 'String' and 'Int'


//更簡易的方法在字串中插入數值
let apples = 3
let oranges = 5
let appleSummary = "有\(apples)顆蘋果"
let fruitSummary = "有\(apples + oranges)個水果"
 
//使用三個"來製作包含"符號的多行文字區段
let quotation = """
I said "I have \(apples) apples."
And then I said "I have \(apples + oranges) pieces of fruit."
"""


//【練習3】使用\()把一個浮點數的計算轉換成字串，並加上某人的名字，和他打個招呼。<計算BMI：體重÷身高的二次方>
// 宣告名字
var myName = "Bob"
// 宣告體重
var myWeight = 59.8
// 宣告身高
var myHeight = 1.66
var bmi = myWeight / (myHeight * myHeight)
// 串接訊息
print("Hi, \(myName). Your BMI is \(bmi)")
// 字串的格式化函式
String(format: "%@你好！你的BMI是：%.2f", myName, bmi)

//==============集合型別（Collection Type）==============
/*
 Swift語言提供經典的陣列、集合和字典三種集合型別來儲存集合資料。
 陣列（Array）用來按順序儲存相同型別的集合資料。
 集合（Set）是無序而且值不會重複的集合資料。
 字典（Dictionary）是無序的鍵值配對之集合資料。
 Swift語言裡的陣列、集合和字典中儲存的資料型別必須明確。
 注意：
 Swift的Array、Set和Dictionary型別被實作為泛型集合。
 */

//建立陣列或字典都是用[]
var shoppingList = ["catfish", "water", "tulips", "blue paint"]
shoppingList[1]
shoppingList[1] = "bottle of water"
shoppingList

var intList:[Int] // 宣告整數陣列
intList = [1, 2, 3]
intList.append(4)
intList
intList.remove(at: 2)
intList
intList.insert(5, at: 2)
//----------字典的用法--------------
var occupations = [
    "Malcolm": "Captain",
    "Kaylee": "Mechanic",       //最後一個元素有逗號也沒關係！
]
occupations["Kaylee"]    // 字典查詢到值時
occupations["Jayne"]     // 字典查詢不到值時，回傳nil
occupations["Jayne"] = "Public Relations"  // 當key不存在時，會新增一筆字典的值
occupations
occupations["Kaylee"] = "Programmer"
occupations
 
occupations.removeValue(forKey: "abc")
occupations.removeValue(forKey: "Jayne")
occupations
occupations.removeAll()
occupations

//在陣列中加入新元素
shoppingList.append("blue paint")
print(shoppingList)

//陣列與字典的初始化（指定型別）
var emptyArray = [String]()
emptyArray.append("abc")
var emptyDictionary = [String: Float]()
emptyDictionary["a"] = 1.22

//當型別可以被推測出來時（譬如：設定第二次設定新值或傳遞參數給某一個函式時），可以不指定型別
shoppingList = []
occupations = [:]
// 對比
shoppingList = [String]()
occupations = [String:String]()


//==============流程控制（Control Flow）==============
//判斷式和迴圈的()可以省略，{}部分不可省略！
// C-style for statement has been removed in Swift 3
/**
 for (int i = 0; i < 100 i++)
 {
     
 }
 */
// Swift For Type 3 ( in array or dictionary)
let individualScores = [75, 43, 103, 87, 12]
var teamScore = 0
for score in individualScores       //注意：score直接使用不需事先宣告！
{
    if score > 50       //if判斷是必須是Boolean敘述，不可以寫成 if score { }
    {
        teamScore += 3
    }
    else
    {
        teamScore += 1
    }
}
print(teamScore)



for (index, item) in individualScores.enumerated()
{
    print("索引：\(index)，值：\(item)")
}

// Swift For Type 1
//for index in 1...100
//{
//    print (index)
//}
// Swift For Type 2
//let base = 3
//let power = 10
//var answer = 1
//for _ in 1...power {
//    answer *= base
//}
//print("\(base) to the power of \(power) is \(answer)")
// Prints "3 to the power of 10 is 59049"

//可以組合if與let來檢測optional變數是否有值
var optionalString: String? = "Hello"
print(optionalString == nil)// 判斷String包裝盒是否有內容物
if optionalString != nil   // 當String包裝盒有內容物時
{
    print(optionalString!)// 將包裝盒拆封(unwrap)，再進行列印
}
else
{
    print("包裝內沒有文字")
}

var optionalName: String? = "John Appleseed"   //測試：var optionalName: String?
var greeting = "Hello!"

// 此行可以把包裝盒的內容物清空
//optionalName = nil
// <方法一>判斷包裝盒內容物
if optionalName != nil
{
    greeting = "Hello, \(optionalName!)"// 要記得解包
}
// <方法二>判斷包裝盒內容物
if let name = optionalName  //選擇性綁定（Optional Binding）
{
    greeting = "Hello, \(name)"     //此處name已經拆封
}

//如果optionalName沒有值，就不會執行if內的敘述；如果optionalName有值，會將值拆封（unwrap）再設定給name


//【練習4】把optionalName改成nil，greeting會是什麼？添加一個else敘述，當optionalName是nil時，設定一個不同的值給greeting變數。
optionalName = nil
if let name = optionalName  //選擇性綁定（Optional Binding）
{
    greeting = "Hello, \(name)"     //此處name已經拆封
}
else
{
    greeting = "Hello, Friend."
}
print(greeting)


//使用??運算符號為『選擇值』（optional value）提供預設值
var nickName: String? = nil
let fullName: String = "John Appleseed"
// <方法三>判斷包裝盒內容物??語法
let informalGreeting = "Hi \(nickName ?? fullName)"  //注意??前後必需空白

// 三改一
if nickName != nil
{
    let informalGreeting = "Hi \(nickName!)"
    print(informalGreeting)
}

// 三改二
if let aNickName = nickName
{
    let informalGreeting = "Hi \(aNickName)"
    print(informalGreeting)
}
else
{
    let informalGreeting = "Hi \(fullName)"
    print(informalGreeting)
}


//switch支援所有資料型別和各種比對運算（不只限於數字和相等運算），每段也不需使用break結束
let vegetable = "red pepper"
switch vegetable // 檢測 vegetable的內容
{
    case "celery":
        print("Add some raisins and make ants on a log.")
    case "cucumber", "watercress":
        print("That would make a good tea sandwich.")
    case let x where x.hasSuffix("pepper"):     //hasSuffix檢測字串結尾
        print("Is it a spicy \(x)?")
    default: // 當前面的case 無法涵蓋所有狀況時，必須要有Default段
        print("Everything tastes good in soup.")
}


//【練習5】刪除default語句，看看會有什麼錯誤？
// Switch must be exhaustive
