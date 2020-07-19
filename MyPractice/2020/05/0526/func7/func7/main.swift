

/*
var x = 123
var y = 456

print("before: x=\(x) y=\(y)")

// do something... to exchange x and y

var tmp:Int

tmp = x
x = y
y = tmp

print ("after: x=\(x) y=\(y)")
 
*/
/*
func exchange(first: Int, second: Int) {
    var tmp:Int
    
    tmp = first
    first = second // 你不可以這麼作：重新指定值()內的參數
    // 因為()內的參數都被當作"常數" constant(相當於用let宣告了)
    second = tmp
    
}
*/
// 如果想要"更動"傳入的參數！！！
// 必須通知編譯器：我要改動的不是已經視為常數的傳入值
func exchange(first: inout Int, second: inout Int) {
    var tmp:Int
    
    tmp = first
    first = second
    second = tmp
    
}

var x = 123, y = 456


print("before: x=\(x) y=\(y)")

exchange(first: &x, second: &y) // 注意！！傳入時前面要加&

print ("after: x=\(x) y=\(y)")
