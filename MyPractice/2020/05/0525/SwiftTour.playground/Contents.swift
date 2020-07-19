import UIKit

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
    var simpleDescription: String { get }  //唯讀屬性
    mutating func adjust()                 //可以異動型別屬性值的方法（mutatin關鍵字僅提供給『值型別』使用）
}

//類別、列舉、結構都可以引用協定
class SimpleClass: ExampleProtocol
{
    //協定屬性
    var simpleDescription: String = "A very simple class."
    var anotherProperty: Int = 69105
    //協定方法（注意：類別中不可加mutating，因為類別是reference type『引用型別』）
    func adjust()
    {
        simpleDescription += "  Now 100% adjusted."
    }
}
var a = SimpleClass()
a.adjust()
let aDescription = a.simpleDescription

struct SimpleStructure: ExampleProtocol
{
    //協定屬性
    var simpleDescription: String = "A simple structure"
    //協定方法（注意：在value type『值型別』中必須可加上mutating關鍵字，才能異動值型別的屬性值）
    mutating func adjust()
    {
        simpleDescription += " (adjusted)"
    }
}
var b = SimpleStructure()
b.adjust()
let bDescription = b.simpleDescription


//【練習16】在ExampleProtocol協定中，增加另外一個需求，並且調整SimpleClass類別和SimpleStructure結構，來符合新的需求。
 
