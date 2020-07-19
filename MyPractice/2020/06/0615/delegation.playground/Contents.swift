import UIKit

//下面的例子定義了一個只含有一個"實體方法"的『協定』：
protocol RandomNumberGenerator      //隨機數字產生器協定
{
    //協定中必要的"實體方法"，其回傳值必須為Double型別的隨機數字（假設介於0.0~1.0區間）
    func random() -> Double     //要如何產生出隨機的數字，則由採納協定的型別自行實作！
}

//以下類別採納了RandomNumberGenerator協定，提供了所謂『線性同餘產生器』(linear congruential generator)的偽隨機數算法：
class LinearCongruentialGenerator: RandomNumberGenerator    //線性同餘產生器類別
{
    //宣告用於『線性同餘遞迴公式』的計算數字
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    //實作『RandomNumberGenerator協定』的"實體方法"
    func random() -> Double
    {
        //<方法一>原範例以偽隨機方式實作，每次隨機數字順序相同
//        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy:m))
//        //以前的寫法：lastRandom = (lastRandom * a + c) % m PS.truncatingRemainder為除法取餘數
//        return lastRandom / m
        

        //<方法二>完全隨機，以arc4random函式取得UInt32的隨機數字，再除以UInt32的最大值，取得0.0~1.0之間的隨機數
        return Double(arc4random()) / Double(UINT32_MAX)
    }
}



//產生『線性同餘產生器』類別實體
let generator = LinearCongruentialGenerator()
print("一個隨機數字：\(generator.random())")
print("另一個隨機數字：\(generator.random())")

//<自行練習>多次取得隨機數字
generator.random()
generator.random()


let generator1 = LinearCongruentialGenerator()
generator1.random()
generator1.random()
generator1.random()
generator1.random()



//下面是把『協定』當作"型別"使用的例子：
class Dice      //骰子類別
{
    //骰子有幾面
    let sides: Int
    

    //隨機數字產生器（把『RandomNumberGenerator協定』當作"型別"來使用）
    let generator: RandomNumberGenerator

    /*
    "初始化方法"需傳入『骰子面數』和『隨機數字產生器協定』的實體
    注意：『隨機數字產生器協定』的實體必須"自行實作"random協定方法！
    */
    init(sides: Int, generator: RandomNumberGenerator)
    {
        self.sides = sides
        self.generator = generator
    }
    

    //擲骰子方法：利用『隨機數字產生器協定實體』中的random方法計算出骰子的隨機點數
    func roll() -> Int
    {
        //先將0.0~1.0間的『隨機數字』與『骰子面數』相乘，將結果取成"整數"後，再加上1回傳
        return Int(generator.random() * Double(sides)) + 1
    }
}

//呼叫『初始化方法』時，第二個傳入參數是LinearCongruentialGenerator類別的實體，利用()將採用"RandomNumberGenerator協定"的『LinearCongruentialGenerator類別』初始化為實體之後傳入：
var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())

//以迴圈來擲五次骰子
for _ in 1...5
{
    print("擲出隨機點數：\(d6.roll())")
}


//================代理機制（Delegation）================
/*
『代理機制』是一種設計模式，它允許"類別"或"結構"將一些需要它們負責的功能"委託給"（代理給）其他型別的實體。
『代理機制』的實作方式是藉由定義『協定』來封裝那些需要被委託的功能，這樣就能確保採納『協定』的型別能提供這些功能。
『代理機制』可以用來回應特定的動作或接收外部資料來源所提供的資料，而不需要知道外部資料來源在底層運作的型別。
*/

//以下定義了兩種用於骰子遊戲的協定：

//骰子遊戲的協定（可以在任何含有骰子的遊戲中被採用）
protocol DiceGame
{
    //一顆骰子
    var dice: Dice { get }
    //玩遊戲的方法
    func play()
}

//追蹤骰子遊戲過程的協定
protocol DiceGameDelegate
{
    //遊戲開始（傳入採納了DiceGame協定的實體）
    func gameDidStart(game: DiceGame)
    //開始新一輪擲骰子的時候（傳入採納了DiceGame協定的實體、擲出的骰子點數）
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    //遊戲結束（傳入採納了DiceGame協定的實體）
    func gameDidEnd(game: DiceGame)
}

//以下的SnakesAndLadders類別是『蛇與梯子遊戲』的新版本（在05.控制流程章節有該遊戲的詳細介紹）
class SnakesAndLadders: DiceGame    //<新版>遊戲以類別封裝，且採納了DiceGame協定
{                                   //注意：這是"設計"代理機制的類別！（通常為Framework中的複雜類別）
    //遊戲盤面大小由一個finalSquare常數儲存
    let finalSquare = 25
    //<新版>增加一個骰子屬性（舊版只有記錄骰子點數）
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    //現在所在位置(需限定0~25)
    var square = 0  //0代表在盤面之外的開始位置
    //遊戲盤面使用Int陣列來表達（由0到25，一共26個）
    var board: [Int]
    

    //<新版>增加"初始化方法"來設定屬性初值
    init()
    {
        /*
        <為遊戲盤面設定初值>
        某些方塊被設定成有蛇或梯子的指定值。梯子底部的方塊是正值，使你可以向上移動，蛇頭的方塊是負值，會讓你向下移動
        */
        //先訂出26個格子，填上預設值零
        board = Array(repeating: 0, count: finalSquare + 1)
        //從梯子底部向上爬升時要增加的值
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        //從蛇頭下滑時要減掉的值
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    

    //<新版>增加骰子遊戲代理人
    var delegate: DiceGameDelegate?
    /*
    注意：
    因為delegate不是遊戲的必備條件，delegate被定義為採納DiceGameDelegate協定的選擇屬性。
    因為delegate是選擇值，因此會被自動賦予初始值nil。
    隨後，可以在遊戲中為delegate設定適當的值。
    */
    

    //<新版>將所有的遊戲邏輯轉移到play協定方法中
    func play()
    {
        //從盤面外面0的位置開始（最後一格是25）
        square = 0
        

        //<新版>遊戲代理人呼叫『遊戲開始』的代理方法（使用選擇性串連呼叫，若沒有指定代理人，此呼叫將優雅地失效，不會當掉！）
        delegate?.gameDidStart(game: self)  //在複雜類別中，代理人可以靠代理機制傳出複雜的執行後結果
        

        //迴圈結束的條件是現在所在位置必須剛好落在最後的方格25
        gameLoop: while square != finalSquare
        {
            //擲出骰子點數（骰子面數的隨機數字）
            let diceRoll = dice.roll()
            

            //<新版>遊戲代理人呼叫『開始新一輪擲骰子』的代理方法
            delegate?.game(game: self, didStartNewTurnWithDiceRoll: diceRoll)
            

            //若是按照骰子的點數前進之後（現在位置＋骰子點數）
            switch square + diceRoll
            {
                //到達最後一個方塊25，則遊戲結束
                case finalSquare:
                    //使用break語法結束整個while迴圈
                    break gameLoop
                //將square+diceRoll的結果設定給newSquare，並檢查是否超過最後一個方塊25
                case let newSquare where newSquare > finalSquare:
                    //若超出最後一個方塊，就再擲一次骰子（重新執行一次while迴圈）
                    continue gameLoop
                //本次移動有效
                default:
                    //按照骰子的點數前進
                    square += diceRoll
                    //前進後若碰到梯子則爬上去，碰到蛇頭則滑下來
                    square += board[square]
            }
        }
        //<新版>遊戲代理人呼叫『遊戲結束』的代理方法
        delegate?.gameDidEnd(game: self)
    }
}
/*
註：
在以上的類別中，當代理人去呼叫代理方法時，參數可以設計成傳遞更複雜的執行結果給代理人，譬如：網路傳輸完成或從某個資料來源獲得的資料，這樣代理人就可以取得複雜類別的執行結果加以應用！
*/
