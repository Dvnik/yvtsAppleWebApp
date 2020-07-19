import Foundation
// 有25格
let finalSquare = 25
// 將25格連"ZOEO"與"最外面那格"宣告一個Int陣列 ==> board
var board = [Int](repeating: 0, count: finalSquare + 1)
// print(baord) // 每個index的值都是0，0表示普通格子

// 設定一些特殊格子
// 梯子用+? // 蛇用 -? ?表示前進或後退的數目（參考畫面）
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
let ladders = [
    board[03],
    board[06],
    board[09],
    board[10]
]

let snakes = [
    board[14],
    board[19],
    board[22],
    board[24]
]

// 範例很簡單！只用來表示一個人走的狀況

// 宣告一個人走的格子數(從0開始)

var square = 0
// 骰子決定走幾步：初值打0
var diceRoll = 0

// 因為不知道會走多久（前前後後的）所以用while迴圈
var step_count = 0
while square < finalSquare { // 這個不等式的真假可以決定是否繼續(while true會繼續)
    // 在這裡面！玩家要一直執骰子走下去！但是隨著骰子走條件就會變...
    
    // 每個回合都要
    
    // 1:執骰子
    diceRoll = Int.random(in: 1...6) // 真正擲骰子
    print("骰子擲出！\(diceRoll)點")
    /*
    diceRoll += 1 // 本題沒有真的擲！只是加1
    if diceRoll == 7 // 骰子只到6
    {
        diceRoll = 1 // 拉回從1開始
    }
 */
    // 2:走骰子直出的數目
    // square加上擲骰子就是往前走
    square += diceRoll
    step_count += 1
    // 3:處理是否遇到特殊格子
    if square < board.count { // 加完骰子直出的數字後，檢查看看是否到（超出）最後的位置
        // if we're still on the board, move up or down for a snake or a ladder
        // 如果沒有！就加上你的位置的那格的值！！
        // 因為如果是一般的格子，其值是0，加了沒影響
        if ladders.contains(board[square]){
            print("LUCKY, 可以多走\(board[square])步,", terminator: "")
        }
        if snakes.contains(board[square]) {
            print("SHIT, 需要倒退\(board[square])步,", terminator: "")
        }
        square += board[square]
    }
    print("現在走到：\(square)")
    sleep(1)
}
print("Game over!,骰了\(step_count)次走到終點")
