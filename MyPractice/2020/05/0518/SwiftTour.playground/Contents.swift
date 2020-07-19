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


