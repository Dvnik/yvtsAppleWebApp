
// 注意！！為了後面實用在集合上！稍微修改此函數功能===>只讓他判斷前面的樹有沒有比後面的大(用true/false來表結果)
func ascend(a1:Int, a2:Int) -> Bool {
    
    if a1 > a2 {
        return true
    }
    return false
}


let abc = {
    (a1: Int, a2: Int) -> Bool
    in
    if a1 > a2 {
        return true
    }
    return false
}

// swift 對一些"既存很久的老，古典算法"，也會有"深度的語意" ===>表現出來的就是語法的簡潔
let abc1 = {
    (a1: Int, a2: Int) -> Bool
    in
    return a1 > a2
}

var x = 78, y = 88
//ascend(a1: &x, a2: &y)
//abc(&x, &y)
print("\(x), \(y)")



