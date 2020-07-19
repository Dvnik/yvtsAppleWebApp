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
func someFunction(callback: () throws -> Void) rethrows
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
    defer   //函式要返回之前的最後時間，才會執行這個區段(包含有拋出錯誤的情況協定與擴展)
    {
        fridgeIsOpen = false
    }
    //檢查陣列中是否包含與傳入參數相同的元素
    let result = fridgeContent.contains(food)
    return result
}
fridgeContains("banana")
print(fridgeIsOpen)
