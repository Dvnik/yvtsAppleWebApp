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
    var numberOfSides = 0 // 屬性：一個形狀有幾邊 (可讀寫屬性)
    let dimension = "3D" // 【練習10】屬性：維度屬性(唯獨屬性 get-only)
    // 方法：列印形狀訊息
    func simpleDescription() -> String
    {
        return "A shape with \(numberOfSides) sides."
    }
    
    func shapeWithHeight(height: UInt) -> String
    {
        return "這是\(dimension)模型，高度：\(height)公分"
    }
}
// 產生實際的物件(物件在Swift傾向稱為實體-instance)
// 注意：當所有屬性都有初值時，類別會自動拿到一個不帶參數的「預設」初始化方法
var shape = Shape() // 呼叫：類別()來執行初始化產生物件
shape.numberOfSides // 讀取屬性值
shape.numberOfSides = 7 // 設定屬性值
shape.numberOfSides
shape.dimension// 實測【練習10】
shape.shapeWithHeight(height: 10)
// 執行方法
var shapeDescription = shape.simpleDescription()


//【練習10】在上面的類別中使用let增加一個常數屬性，再多定義一個接收一個參數的方法。

//類別的初始化方法（屬性的初始化可以在宣告之時或初始化方法中進行）
class NamedShape // 當一個類別沒有繼承自任何「父類別」(Superclass)時，稱為基礎類別(Bass Class)
{
    var numberOfSides: Int = 0
    var name: String // stored properties
//    let abc: Double
    // 當類別中有任何一個屬性沒有初值時，不用自動得到預設不帶參數的初始化方法，必須自訂以下的初始化方法
    // Return from initializer without initializing all stored properties
    init(name: String)
    {
        self.name = name // 自訂初始化方法，必須將沒有初始值的屬性，都設定初值！
//        self.abc = 3.99
    }
    // 自行定義一個不帶參數的初始化方法
    init()
    {
        self.name = "no name shape"
        
    }
    
//    init(name: String, abc: Double)
//    {
//        self.name = name
//        self.abc = abc
//    }

    func simpleDescription() -> String
    {
        return "A shape with \(numberOfSides) sides."
    }
}

var nameShapen = NamedShape(name: "正方形")
nameShapen.name
nameShapen.numberOfSides
nameShapen.simpleDescription()
// 因為namedShape宣告為變數，可以重新初始化「相同類別」的實體！
nameShapen = NamedShape()
nameShapen.name



//類別的繼承以冒號分隔（但類別也可以不繼承自任何類別）
class Square: NamedShape // Square類別是NamedShape的子類別(Subclass)
{
    var sideLength: Double
    /* 以下為繼承自父類別NamedShape的屬性
     var numberOfSides: Int = 0
     var name: String // stored properties
     func simpleDescription() -> String
     {
         return "A shape with \(numberOfSides) sides."
     }
     **/
    

    init(sideLength: Double, name: String)
    {
        // Step1. 先設定自己的屬性值
        self.sideLength = sideLength  //要加上self，以區隔與參數相同名稱的內部變數
        // Step2. 設定從父類別中繼成過來的屬性（沒有初始值的部分）
        super.init(name: name)// 注意：此處Step2只能呼叫服類別的初始化方法
        // 以上Step1和Step2完成了<第一階段初始化程序>，此時類別實體已經完成記憶體配置
        // Step3. 進一步更改現有的屬性值
        numberOfSides = 4   //父類別屬性
        // 以上Step3完成了<第二階段初始化程序>，即在初始化過程中，直接更動特定的屬性值！
    }
    // 方法：計算形狀面積
    func area() ->  Double
    {
        return sideLength * sideLength
    }
    //覆寫父類別的方法時，需標明關鍵字override
    override func simpleDescription() -> String
    {
        return "A square with sides of length \(sideLength)."
    }
}
// 測試Square類別實體
let test = Square(sideLength: 5.2, name: "my test square")
test.sideLength
test.area()
test.simpleDescription()


//【練習11】製作一個繼承自NamedShape類別的Circle類別，初始化方法接收兩個參數，一個是半徑，一個是名稱，實作area和simpleDescription方法。

class Circle : NamedShape
{
    /* 以下為繼承自父類別NamedShape的屬性
     var numberOfSides: Int = 0
     var name: String // stored properties
     func simpleDescription() -> String
     {
         return "A shape with \(numberOfSides) sides."
     }
     **/
    // 半徑屬性
    var radius:Double
//    let pi = 3.1416
    
    init(radius:Double, name:String)
    {
        // Step1. 先設定自己的屬性值
        self.radius = radius
        // Step2. 設定從父類別中繼成過來的屬性（沒有初始值的部分）
        super.init(name: name)
        // 以上Step1和Step2完成了<第一階段初始化程序>，此時類別實體已經完成記憶體配置
        // Step3. 進一步更改現有的屬性值(此步驟可以省略)
        // 此處維持圓形的numberOfSides屬性值為0邊
    }
    
    func area() -> Double
    {
        // 'M_PI' is deprecated: Please use 'Double.pi' or '.pi' to get the value of correct type and avoid casting.
        return radius * radius * Double.pi
    }
    
    override func simpleDescription() -> String
    {
        let strArea = String(format: "%.2f", area())
        
        return "圓形：\(name)的半徑為 \(radius)，面積為\(strArea)"
    }
}

// 測試Circle類別實體
let aCircle = Circle(radius: 4.9, name: "大餅")
aCircle.radius
aCircle.area()
aCircle.simpleDescription()

/*
 類別的屬性有兩種型態：
 1.儲存屬性~stored property
   var 宣告為可讀寫的"儲存"屬性
   let 宣告為唯讀的"儲存"屬性
 2.計算屬性~computed property
   同時設定get與set函式為可讀寫的"計算"屬性
   只設定get函式為唯讀"計算"屬性
 */
//替『計算屬性』(computed property)設定get與set
class EquilateralTriangle: NamedShape
{
    /* 以下為繼承自父類別NamedShape的屬性
     var numberOfSides: Int = 0
     var name: String // stored properties
     func simpleDescription() -> String
     {
         return "A shape with \(numberOfSides) sides."
     }
     **/
    var sideLength: Double = 0.0    //可讀寫的"儲存"屬性
    

    init(sideLength: Double, name: String)
    {
        //注意：以下初始化程序之次第不可任意調換！
        self.sideLength = sideLength   //1.初始化自己的屬性值
        super.init(name: name)         //2.呼叫父類別的初始化方法
        numberOfSides = 3              //3.變更父類別的屬性值（必須在父類別初始化之後）
    }
    //計算屬性（周邊總長度）只能以var宣告(不可使用let宣告)
    // 'let' declarations cannot be computed properties
    var perimeter: Double
    {
        // 此處因為同時宣告了get和set，所以perimeter屬性為可讀寫的"計算"屬性
        get// 定義"取值"斷固定使用get關鍵字
        {
            return 3.0 * sideLength
        }
        set// 定義"設值"斷固定使用set關鍵字
        {
            sideLength = newValue / 3.0  //newValue是隱含名稱，set後可以另外明確指定名稱?
        }
    }
    //【補充練習】
    var area: Double
    {
        // （海龍公式：a、b、c為三角形的邊長，先計算s=(a+b+c)/2，再計算sx(s-a)x(s-b)x(s-c)，接著以此計算值來開根號sqrt()。）
        let s = perimeter / 2
        let k = s * (s - sideLength) * (s - sideLength) * (s - sideLength)
        return sqrt(k)
        
    }
    //覆寫父類別的方法
    override func simpleDescription() -> String
    {
        return "An equilateral triangle with sides of length \(sideLength)."
    }
}
var triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")
print(triangle.perimeter)       //計算屬性取值
triangle.perimeter = 9.9        //計算屬性設值
print(triangle.sideLength)


//【補充練習】替上述的EquilateralTriangle類別加上一個新的『計算屬性』，回傳三角形的面積。（海龍公式：a、b、c為三角形的邊長，先計算s=(a+b+c)/2，再計算sx(s-a)x(s-b)x(s-c)，接著以此計算值來開根號sqrt()。）
triangle.area


//*******************『儲存屬性』用於即將設定屬性值之時*******************
//『三角形與正方形類別』內含一個三角形的類別實體與正方形的類別實體，此類別可以確保所設定的三角形之單邊長度和正方形的單邊長度相等
class TriangleAndSquare
{
    //宣告一個繼承自等邊三角形的類別實體（有sideLength『儲存屬性』）
    var triangle: EquilateralTriangle
    {
        willSet     //此處在三角形屬性即將設值時觸發
        {
            square.sideLength = newValue.sideLength      //三角形的單邊長度，設定給正方形的單邊長度
        }
    }
    //宣告一個繼承自等邊正方形的類別實體（有sideLength『一般屬性』）
    var square: Square
    {
        willSet     //此處在正方形屬性即將設值時觸發
        {
            triangle.sideLength = newValue.sideLength    //正方形的單邊長度，設定給三角形的單邊長度
        }
    }
    //『三角形與正方形類別』的初始化方法（參數一：size會同時設定給正方形和三角形的單邊長度）
    init(size: Double, name: String)
    {
        square = Square(sideLength: size, name: name)                 //初始化正方形的類別實體（此時還不會觸發square屬性的willSet）
        triangle = EquilateralTriangle(sideLength: size, name: name)  //初始化三角形的類別實體（此時還不會觸發triangle屬性的willSet）
    }
}
// 測試TriangAndSquare
var triangleAndSquare = TriangleAndSquare(size: 10, name: "another test shape")
print(triangleAndSquare.square.sideLength)
print(triangleAndSquare.triangle.sideLength)

triangleAndSquare.square = Square(sideLength: 50, name: "larger square")
print(triangleAndSquare.triangle.sideLength)

triangleAndSquare.square = Square(sideLength: 30, name: "medium square")
print(triangleAndSquare.triangle.sideLength)


//選擇值（Optional Value）的兩種宣告方法<注意?出現的位置>
var optionalSquare: Square? = Square(sideLength: 2.5, name: "optional square")  // 注意：此處原範例宣告為let
// 當執行選擇性串連呼叫，最後一定拿到選擇值！
let sideLength = optionalSquare?.sideLength     //選擇性串連呼叫（Optional Chaining）

let aNewMessage = optionalSquare?.simpleDescription()
// 選擇性綁定(Optional Binding)，配合選擇性串連呼叫(Optional Chaining)
if let aNewMessage = optionalSquare?.simpleDescription()
{
    print(aNewMessage)
}
//使用選擇值
optionalSquare!.simpleDescription()
optionalSquare?.simpleDescription()
sideLength!


//=============列舉和結構（Enumerations and Structures）=============
//**********列舉（Enumerations）**********
//列舉跟類別和其他型別一樣都可以定義方法
enum Rank: Int      //列舉撲克牌數字
{
    case ace = 1            //指定初始化值，才可以使用.rawValue
    case two, three, four, five, six, seven, eight, nine, ten // 2-10
    case jack, queen, king                                    //11-13
    func simpleDescription() -> String
    {
        switch self
        {
            case .ace:
                return "ace"
            case .jack:
                return "jack"
            case .queen:
                return "queen"
            case .king:
                return "king"
            default:
                return String(self.rawValue)  //回傳列舉型別所對應的數字
        }
    }
}
let ace = Rank.ace
let aceRawValue = ace.rawValue

var aRank = Rank.jack
aRank = Rank.five
aRank.rawValue


//【練習12】撰寫一個函式，透過比較它們的原始值來比較兩個Rank值（並且回傳比較後的結果）。

func compareRank(rank1:Rank, rank2:Rank) -> String
{
    if rank1.rawValue > rank2.rawValue
    {
        return "rank1 比 rank2 大"
    }
    else if rank1.rawValue < rank2.rawValue
    {
        return "rank1 比 rank2 小"
    }
    else
    {
        return "rank1 比 rank2 相等"
    }
}
// 測試
compareRank(rank1: ace, rank2: aRank)
compareRank(rank1: Rank.king, rank2: Rank.nine)
compareRank(rank1: Rank.five, rank2: aRank)
compareRank(rank1: .five, rank2: .queen)

// ======================<補充>不帶原始值的列舉===========================
//以下是指南針四個方向的一個範例
enum CompassPoint1   //注意：沒有給每一個『列舉成員』提供對應的值
{
    case north
    case south
    case east
    case west
    
    func simpleDescription() -> String
    {
        switch self
        {
            case .north:
                return "北方"
            case .east:
                return "東方"
            case .south:
                return "南方"
            case .west:
                return "西方"
            // Default will never be executed
//            default:
//                return "其他方向"
        }
    }
}
// 測試方向列舉
let cp1 = CompassPoint1.east
cp1.simpleDescription()
// ======================<補充>帶原始值的列舉===========================
enum CompassPoint2: Int
{
    // 注意：預設狀態原始值Int從0起算，每個case自動加1
    case north   // 原始值0
    case south   // 原始值1
    case east    // 原始值2
    case west    // 原始值3
    // 如果列舉帶有原始值，會"自動拿到"以下的「可失敗初始化方法」Failable Initalizers
//    init?(rawValue:Int)
//    {
//        switch rawValue {
//            case 0:
//                self = .north
//            case 1:
//                self = .south
//            case 2:
//                self = .east
//            case 3:
//                self = .west
//            default:
//                return nil
//        }
//    }
    
    func simpleDescription() -> String
    {
        switch self
        {
            case .north:
                return "北方"
            case .east:
                return "東方"
            case .south:
                return "南方"
            case .west:
                return "西方"
        }
    }
}
// 測試方向列舉的第一種，取得列舉實體的方法
var cp2:CompassPoint2? = CompassPoint2.west
if let aCp2 = cp2?.simpleDescription()
{
    print("現在方向：\(aCp2)")
}
//cp2 = CompassPoint2.east
if let cp2 = CompassPoint2(rawValue: 2)
{
    cp2.simpleDescription()
}
//有原始值的列舉型別的可以使用預設的初始化方法init?(rawValue:) 注意：此方法為『可失敗的初始化方法』！
if let convertedRank = Rank(rawValue: 3)
{
    convertedRank.simpleDescription()
}


// ======================<補充>帶原始值的列舉===========================
enum CompassPoint3: String
{
    case north = "N"  // 原始值"N"
    case south = "S"  // 原始值"S"
    case east  // = "E"  // 原始值
    case west    // 原始值3
    
    func simpleDescription() -> String
    {
        switch self
        {
            case .north:
                return "北方"
            case .east:
                return "東方"
            case .south:
                return "南方"
            case .west:
                return "西方"
        }
    }
}

// 測試CompassPoint3
var cp3:CompassPoint3? = CompassPoint3.south
cp3?.rawValue
cp3 = CompassPoint3(rawValue: "east")
cp3?.simpleDescription()
cp3 = CompassPoint3(rawValue: "K") // 初始化方法傳入了不合法字串，無法產生對應的列舉實體，所以cp3為nil
cp3?.simpleDescription()

// 有原始直的列舉型別可以使用預設的初始化方法init?(rawValue:)注意：此方法為「可失敗的初始化方法」！
if let convertedRank = Rank(rawValue: 3)
{
    convertedRank.simpleDescription()
}

//列舉型別可以不用提供原始值（注意：這樣會造成沒有初始化方法init?(rawValue:)，.rawValue屬性也不可使用）
enum Suit: Int      //列舉撲克牌花色(注意：原範例不帶原始指，加上Int原始直是為了組成整副撲克牌的練習)
{
    // 【練習13】將這個花色的列舉改成使用『原始值』
    case spades, hearts, diamonds, clubs
    func simpleDescription() -> String
    {
        switch self
        {
            case .spades:       //當型別已知時，可以使用點語法存取
                return "♠︎"
            case .hearts:
                return "♥︎"
            case .diamonds:
                return "♦︎"
            case .clubs:
                return "♣︎"
        }
    }
    //【練習13】替Suit列舉增加一個color方法
    func color() -> String
    {
        switch self
        {
            case .clubs, .spades:
                return "黑"
            case .diamonds, .hearts:
                return "紅"
        }
    }
}
let hearts = Suit.hearts
let heartsDescription = hearts.simpleDescription()


//【練習13】替Suit列舉增加一個color方法，對spades和clubs回傳"黑"，對hearts和diamonds回傳"紅"（並且將這個花色的列舉改成使用『原始值』）。
hearts.color()
Suit.spades.color()

//============列舉的關聯值============
/*
 一個列舉成員的實體可以有實體的關聯值。相同列舉成員的實體可以有不同的關聯值。
 在產生列舉成員實體的時候，傳入列舉成員實體的關聯值即可。
 關聯值和原始值是不同的：列舉成員的原始值對於所有實體都是相同的，而且你是在定義列舉的時候就設定了原始值。
 

 例如，考慮從伺服器獲取日出和日落的時間。伺服器會回傳正常結果或者錯誤資訊。
*/
enum ServerResponse
{
    case result(String, String)
    case error(String)
    //【練習14】加上潮汐的漲潮、退潮
    case tide(String, String)
    // 此檢測方法在【練習14】之後加上
    func simpleDescription() -> String
    {
        switch self
        {
            case let .result(sunrise, sunset):  //替關聯值命名
                return "日出：\(sunrise)，日落：\(sunset)"
            case let .error(error):
                return "錯誤訊息：\(error)"
            case let .tide(rising, ebb)://【練習14】
                return "漲潮：\(rising)，退潮：\(ebb)"
        }
    }
}
let success = ServerResponse.result("6:00 am", "8:09 pm")
let failure = ServerResponse.error("Out of cheese.")
// 此處已經改到ServerResponse列舉內的simpleDescription()方法
//switch success
//{
//    // <方法一>檢測關聯值得完整寫法
////case .result(let sunrise, let sunset):
////    print("日出：\(sunrise)，日落：\(sunset)")
////case .error(let error):
////    print("錯誤訊息：\(error)")
//    // <方法二>檢測關聯值得簡化寫法(把let關鍵字往前提出到case之後)
//    case let .result(sunrise, sunset):  //替關聯值命名
//        print("日出：\(sunrise)，日落：\(sunset)")
//    case let .error(error):
//        print("錯誤訊息：\(error)")
//    case let .tide(rising, ebb)://【練習14】
//        print("漲潮：\(rising)，退潮：\(ebb)")
//}



//【練習14】替ServerResponse和switch增加第三種情況（以潮汐tide漲潮rising、退潮ebb為例）。
success.simpleDescription()
failure.simpleDescription()
let tide = ServerResponse.tide("5:30 am", "7:20 pm")
tide.simpleDescription()


//**********結構（Structures）**********
/*
以struct關鍵字建立結構。結構提供很多類似類別的行為，包括一般方法和初始化方法。
其中最重要的是：結構會在傳遞的時候拷貝其值，而類別則是傳遞引用。
*/
struct Card  //撲克牌結構
{
    var rank: Rank  //撲克牌數字列舉型別
    var suit: Suit  //撲克牌花色列舉型別
    // 注意：此方法定義為「實體方法」 Instance Method(參考下方說明)
    func simpleDescription() -> String      //回傳撲克牌數字和花色
    {
        return "\(suit.simpleDescription())\(rank.simpleDescription())"  //此行調整過
    }
    //【練習15】回傳一副完整的撲克牌 注意：此方法應定義為型別方法TypeMethod，使用static關鍵字宣告(參考下方說明)
    static func fullDeckOfCards() -> [Card]
    {
        var cards = [Card]()
        // 外迴圈跑點數
        for i in Rank.ace.rawValue...Rank.king.rawValue
        {
            for j in Suit.spades.rawValue...Suit.clubs.rawValue
            {
                // 以Rank和Suit的實體來組成單一撲克牌結構
                let card = Card(rank: Rank(rawValue: i)!, suit: Suit(rawValue: j)!)
                // 將單一撲克牌結構實體加入陣列
                cards.append(card)
            }
        }
        return cards
    }
}
// 測試撲克牌結構(使用逐一成員的初始化方法 member-wise initializer)
let threeOfSpades = Card(rank: .three, suit: .spades)  //傳入參數型別已知，可以使用點語法
let threeOfSpadesDescription = threeOfSpades.simpleDescription()


//【練習15】幫Card結構增加一個方法，讓這個方法回傳一副完整的撲克牌，並且讓每一張牌的數字（rank）和花色（suit）對應起來。

let totalCards = Card.fullDeckOfCards()
totalCards.count

/*
『方法』（Methods）是與"特定型別"關聯的『函式』（functions）。
類別、結構、列舉都可以定義『實體方法』（Instance Method）。『實體方法』為型別的實體，封裝了具體的任務與功能。
類別、結構、列舉也可以定義『型別方法』（Type Method）。『型別方法』與型別本身關聯，型別方法與Objective-C中的『類別方法』（class methods）相似。
 
 宣告"類別"的『型別方法』，在方法的func關鍵字之前加上static關鍵字或class關鍵字。
 （『型別方法』使用class關鍵字來宣告，將允許子類別"覆寫"父類別的實作）
 宣告"結構"和"列舉"的『型別方法』，在方法的func關鍵字之前加上static關鍵字。
*/

//下面的範例演示了『型別的儲存屬性』與『型別的計算屬性』的語法：
struct SomeStructure
{
    static var storedTypeProperty = "Some value."   //結構型別的『儲存屬性』
    static var computedTypeProperty: Int            //結構型別的『計算屬性』
    {
        return 1
    }
}
enum SomeEnumeration
{
    static var storedTypeProperty = "Some value."   //列舉型別的『儲存屬性』
    static var computedTypeProperty: Int            //列舉型別的『計算屬性』
    {
        return 6
    }
}
class SomeClass
{
    static var storedTypeProperty = "Some value."   //類別型別的『儲存屬性』
    //類別型別的『計算屬性』，不允許子類別覆寫時，使用static關鍵字
    static var computedTypeProperty: Int
    {
        return 27
    }
    //類別型別的『計算屬性』，允許子類別覆寫時，使用class關鍵字
    class var overrideableComputedTypeProperty: Int
    {
        return 107
    }
}
// 測試型別屬性
SomeStructure.computedTypeProperty


//===================比較『類別』和『結構』=====================
/*
Swift中『類別』和『結構』有很多共同點，如下：
● 定義"屬性"（properties）來儲存"值"（values）
  Define properties to store values

● 定義"方法"（methods）來提供"功能"（functionality）
  Define methods to provide functionality

● 定義"標註"（subscripts）以『標註語法』來存取其中的"值"
  Define subscripts to provide access to their values using subscript syntax

● 定義"初始化方法"（initializers）用於設定初始化狀態
  Define initializers to set up their initial state

● 可以"擴展"預設實作之外的功能
  Be extended to expand their functionality beyond a default implementation

● 採納"協定"（protocols）來對某個『類別』提供"特定之標準功能"
  Conform to protocols to provide standard functionality of a certain kind

『類別』還擁有『結構』所沒有的附加功能，如下：
● 繼承（Inheritance）允許一個『類別』繼承另一個『類別』的特性
● 型別轉換（Type casting）允許在執行時期"檢查與解譯"（check and interpret）一個『類別實體的型別』
● 反初始化方法（Deinitializers）允許一個『類別實體』釋放掉任何已經被分配的資源
● 引用計數（Reference counting）允許"多次引用"同一個『類別實體』

注意：
『結構』在程式碼傳遞的過程中總是被複製一份，不會使用"引用計數"。
*/


/*
注意：
當你定義一個新『類別』或『結構』的時候，實際上你是定義了一個新的Swift型別。
因此請使用大寫開頭的駝峰式命名法（UpperCamelCase）來為『類別』或『結構』命名（如 SomeClass 和SomeStructure等），以便符合標準Swift型別的大寫命名風格（如String、Int和Bool）。
相對而言，請使用小寫開頭的駝峰式命名法（lowerCamelCase）來為『類別』或『結構』之中的"屬性"與"方法"命名（如framerate和incrementCount）。
*/

//以下是定義『結構』和定義『類別』的範例：
struct Resolution   //解析度的『結構』
{
    //這個『結構』包含了兩個名為width和height的『儲存屬性』，當這兩個屬性被初始化為整數0的時候，它們會被推斷為Int型別。
    var width = 0
    var height = 0
    //注意： 因為以上每一個結構成員都帶有初值，所有會自動拿到兩個初始方法，一個是沒有參數的初始化方法，一個是逐一成員的初始化方法
}
//註：『儲存屬性』是捆綁和儲存在『類別』或『結構』中的常數或變數。

//影像模式的『類別』
class VideoMode
{
    //四個儲存屬性
    var resolution = Resolution()   //解析度（被初始化為一個『Resolution結構』的實體）
    var interlaced = false          //掃瞄方式（交錯或非交錯）
    var frameRate = 0.0             //畫面更新頻率
    var name: String?               //模式名稱會被自動設定成一個預設值nil，因為是選擇性型別
}

//---------------『類別』和『結構實體』（Class and Structure Instances）---------------
//為了描述一個『特定的』解析度或影像模式，我們需要使用初始化語法來產生它們的實體：
let someResolution = Resolution()
let someVideoMode = VideoMode()
//在『結構』或『類別』的型別名稱後跟隨一對空的小括號來初始化，其屬性均會被初始化為預設值。

//---------------存取屬性（Accessing Properties）---------------
//使用"點語法"存取實體中的屬性
print("someResolution的width屬性值：\(someResolution.width)")

//也可以存取"子屬性"
print("someVideoMode的width屬性值：\(someVideoMode.resolution.width)")

//也可以使用"點語法"來為屬性變數設值
someVideoMode.resolution.width = 1280
print("現在someVideoMode的width屬性值是：\(someVideoMode.resolution.width)")

/*
注意：
跟Objective-C語言不同，Swift允許直接設定『結構屬性』的"子屬性"。
上面的最後一個範例，直接設定了someVideoMode中resolution屬性的width這個"子屬性"，不需要重新設定"resolution屬性"。
*/
// Objective-C只能使用以下語法直接變更結構屬性的所有成員
//someVideoMode.resolution = Resolution(width: 1280, height: 768)

//--------『結構成員』的初始化方法(Memberwise Initializers for structure Types)-------
//所有『結構』都會自動產生一個初始化其『結構成員』的方法
let vga = Resolution(width: 640, height: 480)
//註：『類別』與『結構』不同，『類別實體』並不會自動產生帶有"類別預設值"的初始化方法。


//=========『結構』和『列舉』是"值型別"（Structures and Enumerations Are Value Types）=========
/*
當一個"值型別"（value type）被設定給一個變數、常數，或本身被傳遞給一個函式的時候，其實是將值複製過去。

在之前的章節中，我們已經大量使用了"值型別"。
實際上，在Swift中，所有基礎型別：整數（Integer）、浮點數（floating-point）、布林值（Booleans）、字串（string)、陣列（array）和字典（dictionaries）都是"值型別"，都是以『結構』的形式在背景運作。

在Swift中，所有的『結構』和『列舉』都是"值型別"。
這意味著它們的實體，以及實體中所包含的任何"值型別"的屬性，在程式碼中傳遞的時候都會被"複製"。
*/

//下面這個範例使用了Resolution『結構』：
let hd = Resolution(width: 1920, height: 1080)     //HD高解析度
var cinema = hd     //cinema的值其實是hd的一個副本拷貝，而不是hd本身

print("cinema現在的寬度是\(cinema.width)像素")
//接著，為了符合數位影院放映的需求（寬：2048像素，高：1080像素），cinema的width屬性要稍微修改成符合2K標準：
cinema.width = 2048

print("cinema現在的寬度是\(cinema.width)像素")

//但是原來的hd實體中的width屬性還是維持1920
print("hd的寬度還是\(hd.width)像素")

//==========『類別』是"引用型別"（Classes Are Reference Types）===============
/*
與"值型別"不同，"引用型別"在被設定到一個變數、常數或本身被傳遞給一個函式的時候，並不是將值複製過去。
因此，引用的會是已經存在的實體本身。
*/

//下面這個範例使用了之前定義的VideoMode『類別』：
let tenEighty = VideoMode()    // 此處記憶體配置空間的「引用技術」(reference counting)為1
let tenEighty1 = VideoMode()
let tenEighty2 = VideoMode()
tenEighty.resolution.width
tenEighty.resolution.height

tenEighty.resolution = hd  // 拷貝1920X1080的結構值
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

//將『類別實體』tenEighty設定給新的常數alsoTenEighty，同時對alsoTenEighty的畫面更新頻率進行修改：
let alsoTenEighty = tenEighty   // 此處記憶體配置空間的「引用技術」(reference counting)為2
// 注意：此語法為記憶體的引用
alsoTenEighty.frameRate = 30.0

//查看tenEighty的frameRate屬性，我們會發現這個VideoMode實體的"更新頻率"也跟個變成30了
print("tenEighty的frameRate屬性現在是：\(tenEighty.frameRate)")

/*
註：
因為『類別』是"引用型別"，所以tenEight和alsoTenEight實際上是引用相同的VideoMode實體。
換句話說，它們只是同一個實體的兩種不同稱呼而已。
*/

//--------------恆等運算子（Identity Operators）--------------
/*
因為『類別』是"引用型別"，有可能有多個常數和變數在背景同時引用某一個『類別實體』。
（註：對於『『結構』』和『列舉』來說，這並不成立。因為它們是"值型別"，在被設定到常數、變數或傳遞到函式時，總是會被複製。）

如果能夠判定兩個常數或變數是否引用同一個『類別實體』將會很有幫助。
為了達到這個目的，Swift內建了兩個恆等運算子：
完全等於 （ === ） Identical to
不完全等於 （ !== ） Not identical to
*/

//以下是運用這兩個運算子檢測兩個常數或變數是否引用同一個實體：
if tenEighty === alsoTenEighty  // 檢查是否使用同一個記憶體配置區域
{
    print("tenEighty和alsoTenEighty引用了相同的VideoMode實體")
}

if tenEighty === tenEighty1
{
    print("tenEighty和tenEighty1引用了相同的VideoMode實體")
}
else
{
    print("tenEighty和tenEighty1引用了不同的VideoMode實體")
}

/*
請注意"完全等於"（用三個等號表示，===） 與"等於"（用兩個等號表示，==）的不同：
● "完全等於"（Identical to）表示兩個『類別』的常數或變數引用同一個『類別實體』。
● "等於"（Equal to）表示兩個實體的值"相等"（equal）或"相同"（equivalent），判定時要遵照『型別』設計者所定義的標準來評判。

當你在定義你的自定『類別』和『結構』的時候，你有義務來決定判定兩個實體"相等"的標準。
*/

//--------------指標（Pointers）--------------
//當Swift常數或變數引用了某個"引用型別"的實體之時（refers to an instance of some reference type）概念跟C語言中的指標類似，不同的是並不直接指向記憶體中的某個位址，而且也不會要求你使用星號（*）來表明你在建立一個引用。

//=======使用『類別』還是使用『結構』？（Choosing Between Classes and Structures）========
/*
在你的程式碼中，你可以使用『類別』和『結構』來定義你的"自定資料型別"（custom data types）。

然而，『結構實體』總是透過值來傳遞，『類別實體』總是透過引用傳遞。這意味兩者適用不同的任務。
當你在考量一種"資料架構與功能"（data constructs and functionality）的時候，你需要決定每一種"資料架構"應該定義成『類別』，還是要定義成『結構』。

按照通用准則，當符合一條或多條以下條件時，請考慮定義成『結構』：
● 『結構』的主要目的是用來封裝"少量相關的簡易資料值"（a few relatively simple data values）。
● 可以合理預期一個『結構實體』在設定或傳遞時，"被封裝的值"（encapsulated values）將會被複製而不是被引用。
● 任何儲存在『結構』中的"屬性"也都是"值型別"，這些"屬性"預期也將會被複製，而不是被引用。
● 『結構』不需要繼承另一個已存在型別的屬性或行為。

以下是適合『結構』的一些候選範例：
● 幾何形狀的大小～封裝一個width屬性和height屬性，兩者均為Double型別。
● 一定範圍內的路徑～封裝一個start屬性和length屬性，兩者均為Int型別。
● 三維座標系統內的一點～封裝x、y和z屬性，三者均為Double型別。

在所有其他案例中，定義一個『類別』，產生一個它的實體，並透過引用來管理和傳遞。
實際上，這意味著絕大部分的"自定資料架構"都應該是『類別』，而非『結構』。
*/



//=========協定與擴展（Protocols and Extensions）=========
//------------協定（Protocols）------------
//定義協定
protocol ExampleProtocol
{
    var simpleDescription: String { get }  // 至少唯讀屬性（可以是儲存屬性或計算屬性）
    mutating func adjust()                 //可以異動型別屬性值的方法（mutating關鍵字僅提供給『值型別』使用）
            // 注意：類別實作此方法時，不需加上mutating關鍵字，但結構和列舉實作此方法時，需要加上mutating關鍵字
    //【練習16】在ExampleProtocol協定中，增加另外一個需求(requirement)
    var aDouble: Double { get set } // 至少為可讀寫屬性（不可實作為唯獨）
}

//類別、列舉、結構都可以引用協定（注意：如果類別有繼承自其他類別，繼承的類別在冒號的第一個位置，其餘皆為協定！）
class SimpleClass: ExampleProtocol
{
    //協定屬性（以可以讀寫的儲存屬性實作）
    var simpleDescription: String = "A very simple class."
    // 此屬性為類別本身的實體屬性
    var anotherProperty: Int = 69105
    //【練習16】協定屬性（以可讀寫的儲存屬性實作）
    // 供以下計算屬性aDouble儲存使用的私有屬性
    private var tmpDouble: Double = 0
    var aDouble: Double
    {
        get {
            return tmpDouble
        }
        set{
            tmpDouble = newValue
        }
    }
    //協定方法（注意：類別中不可加mutating，因為類別是reference type『引用型別』）
    func adjust() // 此方法實作調整實體屬性simpleDescription的值
    {
        simpleDescription += "  Now 100% adjusted."
    }
}
// 測試simple Class類別
var a = SimpleClass()
// 先確認調整前的屬性值
a.simpleDescription
// 執行屬性調整方法
a.adjust()
// 確認調整過後的屬性值
let aDescription = a.simpleDescription

a.aDouble = 3.99
//a.tmpDouble // 'tmpDouble' is inaccessible due to 'private' protection level
a.aDouble
a.aDouble = 2.678
a.aDouble

struct SimpleStructure: ExampleProtocol
{
    //協定屬性（以結構成員的形式實作）
    var simpleDescription: String = "A simple structure"
    //【練習16】協定屬性（以結構成員的形式實作）
    var aDouble: Double = 1.2134567
    //協定方法（注意：在value type『值型別』中必須可加上mutating關鍵字，才能異動值型別的屬性值）
    mutating func adjust()
    {
        simpleDescription += " (adjusted)"
        aDouble = 4.8 //【練習16】
    }
}
// 測試SimpleStructure結構
var b = SimpleStructure()
// 先確認調整前的屬性值
b.simpleDescription
// 執行屬性調整方法
b.adjust()
// 確認調整過後的屬性值
let bDescription = b.simpleDescription
//【練習16】測試新成員
b.aDouble

//【練習16】在ExampleProtocol協定中，增加另外一個需求(requirement)，並且調整SimpleClass類別和SimpleStructure結構，來符合新的需求。
// 另外再定義一個符合ExampleProtocol協定的『列舉』。

enum SimpleEnumeration : Int, ExampleProtocol
{
    case one = 1, two, three // 1,2,3
    case oneAjusted, twoAjusted, threeAjusted// 4,5,6
//    var simpleDescription: String // Enums must not contain stored properties(列舉不能包含儲存屬性)
    // 以唯讀計算屬性實作『協定屬性』
    var simpleDescription: String
    {
        switch self
        {
        case .one:
            return "<一>"
        case .two:
            return "<二>"
        case .three:
            return "<三>"
        case .oneAjusted:
            return "<一>+"
        case .twoAjusted:
            return "<二>+"
        case .threeAjusted:
            return "<三>+"
        }
    }
    
    var aDouble: Double {
        get
        {
            return Double(self.rawValue)
        }
        set
        {
            // 不處理，但是不可省略
        }
    }
    
    mutating func adjust()
    {
        switch self
        {
            // 列舉實體若為調整前的one、two、three，則更換成對應的調整過後的oneAjusted、twoAjusted、threeAjusted
            case .one:
                self = .oneAjusted
            case .two:
                self = .twoAjusted
            case .three:
                self = .threeAjusted
            default:
                // 列舉實體若已經為調整過後的oneAjusted、twoAjusted、threeAjusted，則不進行調整
                break
        }
    }
}
// 測試列舉
var c = SimpleEnumeration.two
c.simpleDescription
c.adjust()
c.simpleDescription
c.rawValue

String(format: "%.3f", c.aDouble)



//------------擴展（Extensions）------------
//『擴展』等同於OBJC的category，用於擴充『既有型別』(existing type)的功能。
extension Int: ExampleProtocol
{
    
    var simpleDescription: String
    {
        return "數字：\(self)"
    }
    mutating func adjust()
    {
        self += 42
    }
    // 因為 【練習16】新增加的協定屬性，故以計算屬性實作(注意：擴展不可以實作儲存屬性！)
    var aDouble: Double
    {
        get
        {
            return 0.0
        }
        set
        {
            
        }
    }
}
// 測試Int實體
print(7.simpleDescription)
// 注意：7視為常數，不可變動，不能執行變動方法
//7.adjust()
//自行測試以下三行
var i = 58
i.adjust()
print("調整過後是：\(i)")


//【練習17】為Double型別撰寫一個擴展，增加一個絕對值(absoluteValue)屬性來提供Double型別的絕對值。
extension Double
{
    var absoluteValue: Double
    {
//      // <方法一>自行判斷浮點數是否小於0
//        if self < 0
//        {
//            return -self
//        }
//        return self
//       // <方法二>使用取絕對值函式
//        return fabs(self)
        // <方法三>使用Double行別的現成屬性來取絕對值
        return self.magnitude
    }
}
// 注意：取絕對值，若為實體數字，-(負號)必須跟數字先運算！
-2.88.absoluteValue
(-2.88).absoluteValue
//
var j = 5.67
j.absoluteValue
j = -8.99
j.absoluteValue

//宣告一個採納了ExampleProtocol協定的物件實體，並將物件實體a設定給它
var protocolValue: ExampleProtocol = a   // a為SimpleClass的類別實體，此行為為『引用』，此時a的配置空間引用計數為2(注意：此處原範例為let)
print(protocolValue.simpleDescription)
// print(protocolValue.anotherProperty)  //去除註解符號來查看錯誤！
//注意：error是因為anotherProperty不是ExampleProtocol的協定方法，a實體雖然有anotherProperty屬性，但protocolValue實體只能辨認ExampleProtocol的協定方法，因為protocolValue實體宣告為ExampleProtocol協定方法的實體！

a.simpleDescription
protocolValue.simpleDescription
// 以類別的角度，此屬性是可讀可寫的儲存屬性，可以更動！
a.simpleDescription = "test test"
protocolValue.simpleDescription  // 經過更動，因為行定型別的實體protocolValue，與a共用記憶體配置區塊，所以屬性值也會看到更動！
// 以協定型別的角度，此屬性是唯讀，無法更動
//protocolValue.simpleDescription = "abcdef" // Cannot assign to property: 'simpleDescription' is a get-only property

// 透過型別轉換語法(as!)，可以將協定型別，轉型為實際上配置在記憶體空間的實際型別實體
(protocolValue as! SimpleClass).anotherProperty

// 注意：此時a的配置空間引用技術降為1
protocolValue = b  // b為SimpleStructure的結構實體，此行為為『抄錄』
b.simpleDescription
b.simpleDescription = "qqq"
b.simpleDescription
protocolValue.simpleDescription
// 以實際的結構實體來轉型使用
//let aStructure = protocolValue as! SimpleClass // error: Execution was interrupted, reason: signal SIGABRT.

// 重設列舉實體為調整前的case
c = SimpleEnumeration.three
protocolValue = c // c為SimpleEnumeration的結構實體，此行為為『抄錄』
c.simpleDescription
protocolValue.simpleDescription
c.adjust()
c.simpleDescription
protocolValue.simpleDescription

let aEnumeration = protocolValue as! SimpleEnumeration
c.rawValue

(protocolValue as! SimpleEnumeration).rawValue
// 以協定行別來限定函式參數的傳入值
func myTestFunction(aProtocol: ExampleProtocol)
{
    // 函式的實作可以不需要檢查是否有相關的屬性或方法存在，直接執行！
    aProtocol.simpleDescription
}

myTestFunction(aProtocol: a)  // call by reference
myTestFunction(aProtocol: b)  // call by value
myTestFunction(aProtocol: c)  // call by value
myTestFunction(aProtocol: 1)  // 因為Int也實作過ExampleProtocol，所以可以傳入函式
//myTestFunction(aProtocol: 3.99)

//=================協定合成（Protocol Composition）=================
//有時候必須要"同時"採納多個協定，可將多個協定利用protocol<SomeProtocol, AnotherProtocol>這樣的格式進行組合。

//先宣告兩種協定：
protocol Named  //名字協定
{
    var name: String { get }
}
protocol Aged   //年齡協定
{
    var age: Int { get }
}

//Person1結構"同時"採納了『名字協定』與『年齡協定』
struct Person1: Named, Aged     //加1
{
    //分別實作兩種協定中的屬性
    var name: String
    var age: Int
}

/*
以下宣告的全域函式，要求參數傳入必須是"同時"採納了『名字協定』與『年齡協定』這兩種協定之實體。
注意：
此參數並不關心參數的實際型別，只要參數符合這兩個協定即可。
*/
func wishHappyBirthday(celebrator: Named & Aged)
{
    print("生日快樂，\(celebrator.name) - 你\(celebrator.age)歲了!")
}

//產生"同時"採納兩種協定的實體（即Person1結構的實體）
let birthdayPerson = Person1(name: "Malcolm", age: 21)    //加1

//呼叫全域函式，傳入這個實體
wishHappyBirthday(celebrator: birthdayPerson)

/*
注意：
『協定合成』並不會生成新的、永久性的協定型別，而是將多個協定中的需求合成到一個只在局部作用域有效的"臨時協定"中。
*/


//===================錯誤處理（Error Handling）===================
//任何型別採納了Error協定可以用來表示錯誤
enum PrinterError: Error
{
    case outOfPaper //缺紙
    case noToner    //沒有碳粉
    case onFire     //找不到印表機
}
// 【練習19】其他錯誤的定義
enum OtherError: Error
{
    case unknow
}
/*
使用throw來拋出一個錯誤，並使用throws來表示一個可以拋出錯誤的函式。
如果在函式中拋出一個錯誤，這個函式會立刻返回並且呼叫該函式的程式會進行錯誤處理。
*/
func send(job: Int, toPrinter printerName: String) throws -> String
{
    if printerName == "Never Has Toner"
    {
        throw PrinterError.noToner
    }
    else if printerName == "Out Of Paper"
    {
        throw PrinterError.outOfPaper
    }
    else if printerName == "On Fire"
    {
        throw PrinterError.onFire
    }
    else if printerName == ""
    {
        throw OtherError.unknow
    }
    
    return "Job sent"
}
// 只使用try呼叫會拋出錯誤的函式，如果沒有錯誤發生，指令可以成功執行！
try send(job: 43, toPrinter: "asdfjild")
// 只使用try呼叫會拋出錯誤的函式，如果有錯誤發生，沒有進行錯誤捕捉時，程式運行會被鎖死(dead lock)
//try send(job: 33, toPrinter: "Never Has Toner")


/*
有多種方式可以用來進行錯誤處理，其中一種方式是使用do-catch。
在do程式區塊中，使用try來標記會拋出錯誤的函式。
在catch程式區塊中，除非你另外命名，否則錯誤會自動命名為error。
*/
do
{
    let printerResponse = try send(job: 1040, toPrinter: "Bi Sheng")
    print(printerResponse)
}
catch
{
    print(error)
    print(error.localizedDescription)
}


//【練習18】將printer name改為"Never Has Toner"來讓send(job:toPrinter:)函式拋出錯誤。
do
{
    let printerResponse = try send(job: 1040, toPrinter: "Never Has Toner")
    print(printerResponse)
}
catch
{
    print(error)
    print(error.localizedDescription)
}

//可以使用多個catch區塊來處理特定的錯誤。以類似switch中的case風格來寫catch。
do
{
    let printerResponse = try send(job: 1440, toPrinter: "Gutenberg")
    print(printerResponse)
}
catch PrinterError.onFire  //攔截PrinterError的onFire錯誤
{
    print("I'll just put this over here, with the rest of the fire.")
}
catch let printerError as PrinterError //攔截PrinterError的另外兩種錯誤
{
    print("Printer error: \(printerError).")
}
catch  // 攔截到不屬於PrinterError的其他錯誤
{
    print(error)
}


//【練習19】在do區段讓函式拋出錯誤，讓第一段的catch捕捉到錯誤。還有讓第二段和第三段也可以捕捉到錯誤。
// 第一次呼叫：錯誤讓第一段的catch捕捉到
do
{
    let printerResponse = try send(job: 1440, toPrinter: "On Fire")
    print(printerResponse)
}
catch PrinterError.onFire  //攔截PrinterError的onFire錯誤
{
    print("I'll just put this over here, with the rest of the fire.")
}
catch let printerError as PrinterError //攔截PrinterError的另外兩種錯誤
{
    print("Printer error: \(printerError).")
}
catch  // 攔截到不屬於PrinterError的其他錯誤
{
    print(error)
}
// 第二次呼叫：錯誤讓第二段的catch捕捉到
do
{
    let printerResponse = try send(job: 1440, toPrinter: "Out Of Paper")
    print(printerResponse)
}
catch PrinterError.onFire  //攔截PrinterError的onFire錯誤
{
    print("I'll just put this over here, with the rest of the fire.")
}
catch let printerError as PrinterError //攔截PrinterError的另外兩種錯誤
{
    print("Printer error: \(printerError).")
}
catch  // 攔截到不屬於PrinterError的其他錯誤
{
    print(error)
}
// 第三次呼叫：錯誤讓第三斷的catch捕捉到
do
{
    let printerResponse = try send(job: 1440, toPrinter: "")
    print(printerResponse)
}
catch PrinterError.onFire  //攔截PrinterError的onFire錯誤
{
    print("I'll just put this over here, with the rest of the fire.")
}
catch let printerError as PrinterError //攔截PrinterError的另外兩種錯誤
{
    print("Printer error: \(printerError).")
}
catch  // 攔截到不屬於PrinterError的其他錯誤
{
    print(error)
}


/*
另一種處理錯誤的方式使用try?將結果轉換為選擇值（optional）。
如果函式拋出錯誤，該錯誤會被拋棄並且回傳結果為nil。
否則的話，結果會是一個包含函式回傳值的選擇值。
*/
// 函式執行成功，函式的回傳直會轉換為選擇值。執行不成功則回傳nil
let printerSuccess = try? send(job: 1884, toPrinter: "Mergenthaler")
// 也可以配合選擇性榜定語法測試函式是否執行成功
if let printerFailure = try? send(job: 1885, toPrinter: "Never Has Toner")
{
    // 如果執行成功，拿到拆封過後的函式回傳值！
    print(printerFailure)
}
else
{
    print("函式執行失敗！")
}
// 如果函式本身不會拋出錯誤，但是錯誤是由「函式的參數」拋出來(閉包)拋出時，可以使用rehrows關鍵字定義函式
func someFunction(callback: () throws -> Void) rethrows// -> Void
{
    try callback()
}

// 測試
someFunction {
    print("success")
}

// 測試2
try? someFunction {
    throw OtherError.unknow
}

/*
使用defer程式區塊來表示在函式返回前，函式中最後執行的程式。
無論函式是否會拋出錯誤，這段程式都將執行。
利用defer語法，你可以把函式呼叫之初就要執行的程式和結束之時才需要執行的清除程式（cleanup code）寫在一起，雖然這兩者的執行時機截然不同。
*/

var fridgeIsOpen = false
let fridgeContent = ["milk", "eggs", "leftovers"]

func fridgeContains(_ food: String) -> Bool
{
    fridgeIsOpen = true
    defer   //函式要返回之前的最後時間，才會執行這個區段(包含有拋出錯誤的情況)
    {
        fridgeIsOpen = false
    }
    //檢查陣列中是否包含與傳入參數相同的元素
    let result = fridgeContent.contains(food)
    return result
}
fridgeContains("banana")
print(fridgeIsOpen)


//=================泛型（Generics）=================
func repeatItem(repeating item: Int, numberOfTimes: Int) -> [Int]
{
    var result = [Int]()
    for _ in 0..<numberOfTimes
    {
        result.append(item)
    }
    return result
}


let items = repeatItem(repeating: 66, numberOfTimes: 10)
var items1 = items
items1[0] = 33


func repeatItem(repeating item: String, numberOfTimes: Int) -> [String]
{
    var result = [String]()
    for _ in 0..<numberOfTimes
    {
        result.append(item)
    }
    return result
}
repeatItem(repeating: "test", numberOfTimes: 10)
// 定義泛用型別的函式
//使用第二個參數來製成第一個參數的陣列
func repeatItem<Item>(repeating item: Item, numberOfTimes: Int) -> [Item]
{
    var result = [Item]()         //宣告泛型陣列
    for _ in 0..<numberOfTimes
    {
        result.append(item)       //加入泛型陣列
    }
    return result
}
let myItem = repeatItem(repeating: "knock", numberOfTimes:4)

repeatItem(repeating: 3.88, numberOfTimes: 5)
let newArr = repeatItem(repeating: SimpleClass(), numberOfTimes: 10)
newArr[2]

newArr.map { (aClass) -> String in
    return "\(aClass.simpleDescription), \(aClass.anotherProperty), \(aClass.aDouble)"
}

//方法、類別、列舉、結構都可以使用泛型
//Reimplement the Swift standard library's optional type
// 注意：列舉只有帶關聯值的形式，可以適用泛型！
enum OptionalValue<Wrapped>
{
    case none
    case some(Wrapped)
}
// 已明確指定型別的方式，使用列舉實體
var possibleInteger: OptionalValue<Int> = .none
possibleInteger
possibleInteger = .some(100)
possibleInteger
// 以型別推測機制的方式，使用列舉實體
var anotherType = OptionalValue.some("ABC")
anotherType
anotherType = .none
anotherType = .some("DEF")
anotherType

// 注意：以下此行錯誤，因為型別推測機制，無法利用不帶關聯值的case來推測出Wrapped型別
//var abcType = OptionalValue.none
// 注意：帶原始值的列舉，在定義時已經決定型別，所以不適用泛型！
enum abcEnumeration:Int
{
    case a,c
    case b
}

enum strEnumeration:String
{
    case abc
    case def
}

/*
泛型名稱之後使用where來指定其需求條件，例如：
要求該型別必需實作protocol
要求兩個型別必需一致
要求一個類別必須繼承自特定的父類別
*/


/*
Sequence是一種協定，普遍用於Array
採納此協定的型別T，可以使用T.Element來檢測其內含物的型別
*/
func anyCommonElements<T: Sequence, U: Sequence>(_ lhs: T, _ rhs: U) -> Bool
    where T.Element: Equatable, T.Element == U.Element
    //where條件：T的內含元素的型別必須實作過Equatable協定，且『T的內含元素的型別』要和『U的內含元素的型別』一致
{
    for lhsItem in lhs
    {
        for rhsItem in rhs
        {
            if lhsItem == rhsItem
            {
                return true
            }
        }
    }
    return false
}
// 測試
anyCommonElements([1, 2, 3], [3])
anyCommonElements(["a", "b", "c"], ["d", "e"])
//<補充> 改寫以上函式，只使用一種泛型T
func anyCommonElements1<T: Equatable>(_ lhs: [T], _ rhs: [T]) -> Bool
{
    for lhsItem in lhs
    {
        for rhsItem in rhs
        {
            if lhsItem == rhsItem
            {
                return true
            }
        }
    }
    return false
}
anyCommonElements1([1, 2, 3], [3])




//【練習20】修改anyCommonElements函式來建立一個函式，回傳一個陣列，其中記錄同時存在於兩個序列之中的共同元素。
func anyCommonElements2<T: Sequence, U: Sequence>(_ lhs: T, _ rhs: U) -> Array<T.Element>
    where T.Element: Equatable, T.Element == U.Element
    //where部分～T的內含元素的型別必須實作過Equatable協定，且『T的內含元素的型別』要和『U的內含元素的型別』一致
{
    var myArray = Array<T.Element>() // [T.Element]()
    for lhsItem in lhs
    {
        for rhsItem in rhs
        {
            if lhsItem == rhsItem
            {
                myArray.append(lhsItem)
            }
        }
    }
    return myArray
}
anyCommonElements2([1, 2, 3], [3])
 
//<補充>陣列和字典也可以使用泛型來指定其內裝元素的型別
let array1 = ["s1","s2"]
let array2 = [Int]()
let array3:[Double] = []
let array4 = Array<Int>() // [Int]()
let array5:Array<Double> = []
let dic11 = Dictionary<String, Double>() // [String:Double]()
let dic22:Dictionary<String, Double> = [:]
let dic33:[String:Double] = [:]

//【補充練習1】利用擴展來替『文字陣列』加上一個新的startOrEnd方法，其功能仿造原來的contains方法，但只檢查陣列中的元素是否以該字串開頭或結尾。（提示：『文字陣列』的contains方法只會比對陣列元素是否完全符合！）

// 先測試文字型別
let mytestString = "This is a book."
mytestString.hasPrefix("Th") // 檢查開頭字串
mytestString.hasSuffix("k!") // 檢查結尾字串
mytestString.contains("is") // 檢查不限定位置是否包含特定字串
mytestString.contains("Th") // 檢查不限定位置是否包含特定字串
mytestString.contains("k!") // 檢查不限定位置是否包含特定字串

let arrTest = ["abc", "def", "ghi"]
arrTest.contains("def")  // 檢查特定字串陣列之元素是否完全符合
arrTest[1].contains("ef")// 檢查特定字串陣列中之單一元素是否部分符合

extension Sequence where Iterator.Element == String // where 條件限定元素的型別必須為字串
{
  //比對字串出現在開頭或結尾，才回傳true（不含出現在中間的狀況）
   func startOrEnd(_ aStr:String) -> Bool
    {
        for element in self
        {
            if element.hasPrefix(aStr) || element.hasSuffix(aStr)
            {
                return true
            }
        }
        return false
    }
}
// 測試擴展的方法strtOfEnd
let strArray = ["333","dfdsf"]
strArray.contains("dfdsf") //只比對完全符合
strArray.contains("sf")    //無法比對部分符合
strArray[1].contains("sf") //『文字的實體方法』可以比對部分符合
strArray.startOrEnd("sf")  //只比對開頭或結尾是否符合
let intArray = [1, 2, 3]
intArray.contains(2)
// 注意：「數字陣列」並不會拿到擴展後的
//【補充練習2】讓自定類別採納Equatable協定strtOfEnd方法！
//實作Equatable協定
class NewClass:Equatable
{
    var aInt:Int = 0
    var aStr:String = ""
    

    init()
    {
        //維持原來不帶參數的初始化方法
    }
    

    init(aInt:Int,aStr:String)
    {
        self.aInt = aInt
        self.aStr = aStr
    }
    

    static func ==(lhs: NewClass, rhs: NewClass) -> Bool
    {
        return (lhs.aInt == rhs.aInt && lhs.aStr == rhs.aStr)
    }
}

let newClass1 = NewClass()
let newClass2 = NewClass(aInt: 3, aStr: "test")

if newClass1 == newClass2
{
    print("兩個類別實體相等")
}
else
{
    print("兩個類別實體不相等")
}
if newClass1 != newClass2
{
    print("兩個類別實體不相等")
}
else
{
    print("兩個類別實體相等")
}


//【補充練習2-1】
// 實作Comarable協定（因為Comarable協定引用了Equqatable協定，所以必須同時實作func==方法）
class NewClass1:Comparable
{
    var aInt:Int = 0
    var aStr:String = ""
    
    init()
    {
        //維持原來不帶參數的初始化方法
    }
    

    init(aInt:Int,aStr:String)
    {
        self.aInt = aInt
        self.aStr = aStr
    }
    // Comparable協定必須自行實作func < 函式，其餘的func>、func>=、func<=函式會自動提供「預設實作」
    static func < (lhs: NewClass1, rhs: NewClass1) -> Bool {
        return (lhs.aInt < rhs.aInt && lhs.aStr < rhs.aStr)
    }
    // 注意：Comparable協定提供「預設實作」的前提是同時要提供func==函式
    static func == (lhs: NewClass1, rhs: NewClass1) -> Bool {
        return (lhs.aInt == rhs.aInt && lhs.aStr == rhs.aStr)
    }
    
    
}
//【補充練習2-2】協定可以引用其他協定（譬如：Comparable協定，"Inherits From" Equatable協定）
protocol aProtocol
{
    var a:Int { get }
}

protocol bProtocol:aProtocol // b協定"沿用自"a協定
{
    var b:String { get }
}

class MyClass:bProtocol
{
    var a = 0
    let b = "test"
}

//-----------集合型別的雜湊值(Hash Values for Set Types)-----------
/*
維基百科的定義～
雜湊（英語：Hashing）是電腦科學中一種對資料的處理方法，通過某種特定的函數/算法（稱為雜湊函數/算法）將『要檢索的項目』與『用來檢索的索引』（稱為雜湊，或者雜湊值）關聯起來，生成一種便於搜索的資料結構（稱為雜湊表）。
*/

/*
一個型別為了儲存在集合中，該型別必須"可以雜湊"(hashable)～也就是說，該型別必須自己提供一個方法來計算它的雜湊值。
一個雜湊值是Int型別的值，物件進行比較時，這個雜湊值如果相同，則視為物件相等。
譬如：a==b時，必須遵循a.hashValue == b.hashValue的規則。

Swift的所有基本型別（例如：String,Int,Double和Bool）預設都是"可以雜湊的"，可以作為集合的『值』型別或字典的『鍵』型別。
沒有關聯值的列舉成員的值，預設也是可以雜湊的。（參考列舉章節）

註：Dictionary的『鍵』（key）也必須可以雜湊，需要其『鍵』可以雜湊的原因，是為了檢查其中是否已經包含了某個特定『鍵』的值。
*/

/*
注意：
你可以使用你的"自定型別"作為集合的『值』型別或字典的『鍵』型別，但你必須讓你的"自定型別"符合Swift標準函式庫中的『Hashable協定』。
符合『Hashable協定』的型別需要提供一個型別為Int的"唯讀屬性"hashValue。
由型別之hashValue屬性所回傳的值，不需要在"同一程式的不同執行周期"，或在"不同程式"之間一直保持相同的值。

因為『Hashable協定』採納了『Equatable協定』，所以採納該協定的型別也必須提供一個"是否相等"的運算子(==)之實作。
*/

//【補充練習3】自訂型別的雜湊值
struct MyPoint:Hashable,Comparable
{
    var x:Int
    var y:Int
    var z:Int
    
      //Hashable協定已經提供完整實作，只需引入協定即可，不可以自己實作hashValue屬性，但是可以實作func hash(into: inout Hasher)方法，來覆蓋預設實作
    
    //Equatable協定
    static func == (lhs: MyPoint, rhs: MyPoint) -> Bool
    {
        // <方法一>不使用雜湊值自行計算相等
//        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
        // <方法二>使用雜湊值自動比對相等
        return lhs.hashValue == rhs.hashValue
    }
    //Comparable協定
    static func <(lhs: MyPoint, rhs: MyPoint) -> Bool
    {
        // <方法一>不使用雜湊值自行比對大小
        let lhsXYZ = Int("\(lhs.x)\(lhs.y)\(lhs.z)")!
        let rhsXYZ = Int("\(rhs.x)\(rhs.y)\(rhs.z)")!
        return lhsXYZ < rhsXYZ
        // <方法二>使用雜湊值自動比對大小  注意：此方法會有Bug，因為數字較大的雜湊值不一定比較大！
//        return lhs.hashValue < rhs.hashValue
    }
}
// 實測
let aPoint = MyPoint(x: 10, y: 20, z: 30)
let bPoint = MyPoint(x: 10, y: 20, z: 30)
let cPoint = MyPoint(x: 30, y: 20, z: 10)

aPoint.x.hashValue
bPoint.x.hashValue
aPoint.y.hashValue
aPoint.z.hashValue

var aSet = Set<MyPoint>()
aSet.insert(aPoint)
aSet.insert(bPoint)
aSet.insert(cPoint)

aPoint.hashValue
bPoint.hashValue
cPoint.hashValue

//if aPoint.x == bPoint.x && aPoint.y == bPoint.y && aPoint.z == bPoint.z
//{
//
//}

if aPoint == bPoint
{
    print("a和b相等")
}
else if aPoint < bPoint
{
    print("a < b")
}
else if aPoint > bPoint
{
    print("a > b")
}


if aPoint == cPoint
{
    print("a和c相等")
}
else if aPoint < cPoint
{
    print("a < c")
}
else if aPoint > cPoint
{
    print("a > c")
}
