import UIKit


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
