import UIKit

//for-in迴圈可以同時取出字典中的key與value

let interestingNumbers = [

    "Prime": [2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    "Square": [1, 4, 9, 16, 25],
]

//註：Prime質數、Fibonacci費氏數列

var largest = 0
var largKind = ""

for (kind, numbers) in interestingNumbers
{

    print("字典內容：[\(kind),\(numbers)]")
    //列示value的陣列內容
    for number in numbers
    {
        if number > largest
        {
            largKind = kind
            largest = number
        }
    }
}

print(largest)
print(largKind)

//【練習6】沿用上一段的字典與迴圈，在其中添加另一個變數，用來找出哪一種型別的數字最大。

//以while迴圈來重複執行代碼，直到條件改變
var n = 2
while n < 100
{
//    n = n * 2
    n *= 2
}
print(n)

//重複執行的條件可以放在結尾，這樣可以保證迴圈至少執行了一次（do while迴圈，改成repeat while語法）
var m = 2
repeat
{
//    m = m * 2
    m *= 2
} while m < 100
print(m)
//以下C語言形式的for迴圈，Swift3.0以後不支援！
//var secondForLoop = 0
//for var i = 0; i < 4; ++i
//{
//    secondForLoop += i
//}

//使用..<（不含上標）或...（包含上標）來標示for迴圈的執行計數
var firstForLoop = 0
for i in 0..<4
{
    firstForLoop += i
}
print(firstForLoop)

// 使用到轉區間for-in迴圈
firstForLoop = 0
for i in (0..<4).reversed()
{
    firstForLoop += i
    print("第\(i+1)次firstForLoop：\(firstForLoop)")
}

firstForLoop = 0
for i in (0...4).reversed()
{
    firstForLoop += i
    print("第\(i+1)次firstForLoop：\(firstForLoop)")
}

// ----------------------------------------------
// 迴圈正轉(從0到10)，每次加二(不含上標)
var totalCount = 0
for i in stride(from: 0, to: 10, by: 2)
{
    totalCount += i
    print("第\(i+1)次totalCount：\(totalCount)")
}
// 迴圈正轉(從0到10)，每次加二(包含上標)
totalCount = 0
for i in stride(from: 0, through: 10, by: 2)
{
    totalCount += i
    print("第\(i+1)次totalCount：\(totalCount)")
}

// 迴圈反轉(從0到10)，每次減二(不含上標)
totalCount = 0
for i in stride(from: 10, to: 0, by: -2)
{
    totalCount += i
    print("第\(i+1)次totalCount：\(totalCount)")
}
// 迴圈反轉(從0到10)，每次減二(包含上標)
totalCount = 0
for i in stride(from: 10, through: 0, by: -2)
{
    totalCount += i
    print("第\(i+1)次totalCount：\(totalCount)")
}

//==========函式與閉包（Functions and Closures）==========
//**********函式的回傳值標示在後方**********
func greet(person: String, day: String) -> String {
    return "Hello \(person), today is \(day)."
}
greet(person: "Bob", day: "Tuesday")

//【練習7】刪除函式中的day參數，添加一個參數來表示今天吃了什麼午飯。

func greet2(person: String, lunch: String) -> String {
    return "\(person) eat lunch is \(lunch)."
}

print(greet2(person: "Bob", lunch: "Checken"))

//預設情況下，函式使用參數名稱（parameter names）作為引數標籤（labels for arguments）。在參數名稱前方可以自定引數標籤，或使用 _ 來避免使用引數標籤。
func greet(_ person: String, on day: String) -> String
{
    return "Hello \(person), today is \(day)."
}

greet("John", on: "Wednesday")

// 如果函式沒有參數、沒有回傳值，以下列格式定義：
func noReturnFunction() -> Void {
    
}
// 執行函式
noReturnFunction()
// 函式沒有回傳值時『-> Void』可以省略，但沒有參數的情況，『()』不能省略
func noReturnFunc() // -> Void
{
    
}



//**********使用tuple（元組）回傳一組資料**********

//此函式接收一個陣列，要找出陣列中最大值與小值，並且計算總和後，以tuple當作函式的回傳值
func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int)
{
    var min = scores[0]
    var max = scores[0]
    var sum = 0
    for score in scores
    {
        if score > max
        {
            max = score
        }
        else if score < min
        {
            min = score
        }
        sum += score
    }
    //回傳tuple
    return (min, max, sum)
}

let statistics = calculateStatistics(scores: [5, 3, 100, 3, 9])

//tuple可以使用名稱或索引來存取

print(statistics.sum)   //使用名稱存取tuple

print(statistics.2)     //使用索引存取tuple

//**********函式可以接收不定個數的參數**********
func sumOf(numbers: Int...) -> Int  //不定個數的參數在函式中視為『陣列』
{
    var sum = 0
    //迴圈逐一列出參數中的陣列值
    for number in numbers
    {
        sum += number
    }
    return sum
}

sumOf()             //沒有傳入參數

sumOf(numbers: 42, 597, 12)  //傳入三個參數後合成一個陣列

//【練習8】撰寫一個計算參數之平均值的函式
func avargeOf(numbers: Int...) -> Float
{
    var sum = 0
    for number in numbers
    {
        sum += number
    }
    
    return Float(sum) / Float(numbers.count)
}
avargeOf(numbers: 42, 597, 12, 100)

//**********可以使用巢狀函式**********
func returnFifteen() -> Int
{
    var y = 10
    //定義一個函式內的函式
    func add()
    {
        y += 5
    }
    //執行內部函式
    add()
    return y
}
returnFifteen()

//注意：函式是一等型別（first-class type），所以函式可以作為另一個函式的回傳值或參數。
//**********函式可以當做另一個函式的回傳值**********
func makeIncrementer() -> ((Int) -> Int)
{
    //定義一個函式內的函式
    func addOne(number: Int) -> Int
    {
        return 1 + number
    }
    return addOne  //回傳內部的函式
}
// 函式變數
//宣告函式變數，透過執行makeIncrementer函式，可以取得(Int)->Int型別的函式，且已包含函式內部的實作！
var increment = makeIncrementer()
increment(7)    //注意：實際使用時，參數會往下傳遞給內部函式！



//**********函式可以當做另一個函式的參數**********
/*
    函式中的第二個參數，要求必須傳入一個參數（其型別為Int），且回傳值為Bool的函式
    此函式在找出陣列中是否有任何一個元素，可以符合第二個參數的運作邏輯！
*/
//注意：此函式只是單純地將『第一個參數』的陣列值，一一傳入『第二個參數』的函式當中，並且依據第二個參數回傳的Bool值再回傳相同的Bool值（第二個參數在此階段並未實作，意圖將第二個參數的實作轉交給呼叫這個函式的使用者）
func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool
{
    //迴圈列出第一個參數的每一個陣列元素
    for item in list
    {
        //把每一個陣列元素item代入第二個參數中函式中作為參數
        if condition(item)      //此處在呼叫參數二的函式！
        {
            return true
        }
    }
    return false
}
//定義一個lessThanTen函式（使用於hasAnyMatches函式的第二個參數），其中一個參數的型別為Int，且回傳值是Bool（要當做hasAnyMatches第二個參數）
func lessThanTen(number: Int) -> Bool
{
    return number < 10      //作為參數的函式，運作邏輯定義在這裡
}
//定義一個陣列（要當做hasAnyMatches函式的第一個參數）
var numbers = [20, 19, 7, 12]
//<方法一>呼叫函式，傳入一個陣列與一個lessThanTen函式，找出陣列中是否有任何一個元素小於10
hasAnyMatches(list: numbers, condition: lessThanTen)
// <方法二>第二個參數，以『匿名函式』方式傳入實作 PS.『匿名函式』即為『閉包』(closure)
hasAnyMatches(list: numbers, condition: {(number: Int) -> Bool in return number < 10 })
// <方法三>第二個參數，以『尾隨閉包』(Tralling Closure)

hasAnyMatches(list: numbers) { (number) -> Bool in
    return number < 10
}

//{
//    (number: Int) -> Bool
//    in
//    return number < 10
//}
//**********函式就是Closure（閉包）**********
/*
函式實際上是一種特殊的閉包，你可以使用{}來創建一個匿名閉包。
閉包可以捕獲並存取所在作用域中的變數與函式，即使閉包事後才在不同的作用域被執行！
*/

//將陣列元素逐一對應到Closure的參數中（注意：numbers.map會回傳一個Closure處理過後的陣列實體）
let newArray = numbers.map({   //『 let newArray = 』是自行加入的！
    (number: Int) -> Int in
    let result = 3 * number
    return result
})
newArray  //顯示對應後由closure計算後的陣列

let newArray2 = numbers.map { (number) -> String in
    return "\(number)!"
}
newArray2


//【練習9】重寫map方法內的閉包，把陣列中所有的奇數值都換成0
let renewArray = numbers.map { (number) -> Int in
//    if number % 2 > 0
//    {
//        return 0
//    }
//    else
//    {
//        return number
//    }
    
    // <方法二>
    if number % 2 != 0
    {
        return 0
    }
    return number
}
renewArray


//還有其他方法撰寫閉包：
//-----------忽略閉包參數的型別和回傳值-----------
let mappedNumbers = numbers.map({ number in 3 * number })
print(mappedNumbers)

//---------使用索引來代表閉包中的參數-------------
//以Closure來排序陣列<簡化寫法一>
let sortedNumbers = numbers.sorted { $0 > $1 }// $0代表閉包的參數1，$1代表參數2
print(sortedNumbers)

// <補充> 陣列的排序方法
let sortedNumbers1 = numbers.sorted { (item1, item2) -> Bool in
    return item1 > item2 // 閉包定義出由大到小的排序邏輯
}
sortedNumbers1
// 以下為簡化寫法<簡化寫法二>
numbers.sorted(by: > )

let sortedNumbers2 = numbers.sorted { (item1, item2) -> Bool in
    return item1 < item2  // 閉包定義出由小到大的排序邏輯
}
sortedNumbers2

let sortedNumbers3 = numbers.sorted() // 不傳參數的預設排序方法為由小到大排序(注意：此方法僅限simple value!)
sortedNumbers3
// 如果陣列元素為複合值，只能使用自訂排序方法
let dic1 = ["name": "Perkin", "gender": "1", "age": "43"]
let dic2 = ["name": "Mary", "gender": "0", "age": "23"]
let dic3 = ["name": "John", "gender": "1", "age": "33"]
let dic4 = ["name": "Jane", "gender": "0", "age": "12"]
let dic5 = ["name": "Kevin", "gender": "1", "age": "50"]
let arrPerson = [dic1, dic2, dic3, dic4, dic5]
let newArtPerson = arrPerson.sorted { (dic1, dic2) -> Bool in
    return Int(dic1["age"]!)! > Int(dic2["age"]!)!
}
//===============物件和類別（Objects and Classes）================
//『屬性』宣告在類別之內與『常數』和『變數』的宣告方式相同；『方法』與『函式』的撰寫方式也相同
class Shape
{
    var numberOfSides = 0 // 屬性：一個形狀有幾邊
    // 方法：列印形狀訊息
    func simpleDescription() -> String
    {
        return "A shape with \(numberOfSides) sides."
    }
}
// 產生實際的物件(物件在Swift傾向稱為實體-instance)
var shape = Shape() // 呼叫：類別()來執行初始化產生物件
shape.numberOfSides // 讀取屬性值
shape.numberOfSides = 7 // 設定屬性值
shape.numberOfSides
var shapeDescription = shape.simpleDescription()


//【練習10】在上面的類別中使用let增加一個常數屬性，再多定義一個接收一個參數的方法。
