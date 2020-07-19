import UIKit

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
let cp1 = CompassPoint1.north
cp1.simpleDescription()

enum CompassPoint2: Int
{
    // 注意：預設狀態原始值Int從0起算，每個case自動加1
    case north // 原始值0
    case south// 原始值1
    case east// 原始值2
    case west// 原始值3
    
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
// 測試方向列舉
var cp2:CompassPoint2? = CompassPoint2.west
//cp2?.simpleDescription()
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

//列舉型別可以不用提供原始值（注意：這樣會造成沒有初始化方法init?(rawValue:)，.rawValue屬性也不可使用）
enum Suit       //列舉撲克牌花色
{
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
}
let hearts = Suit.hearts
let heartsDescription = hearts.simpleDescription()


//【練習13】替Suit列舉增加一個color方法，對spades和clubs回傳"黑"，對hearts和diamonds回傳"紅"（並且將這個花色的列舉改成使用『原始值』）。


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
}
let success = ServerResponse.result("6:00 am", "8:09 pm")
let failure = ServerResponse.error("Out of cheese.")

switch success
{
    case let .result(sunrise, sunset):  //替關聯值命名
        print("日出：\(sunrise)，日落：\(sunset)")
    case let .error(error):
        print("錯誤訊息：\(error)")
}


//【練習14】替ServerResponse和switch增加第三種情況（以漲潮、退潮為例）。
