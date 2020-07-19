


func add(first:Int, second:Int) -> Int {
    let answer = first + second
    return answer
}


func sub(first:Int, second:Int) -> Int {
    let answer = first - second
    return answer
}

func mul(first:Int, second:Int) -> Int {
    let answer = first * second
    return answer
}

func div(first:Int, second:Int) -> Double {
    let answer = Double(first) / Double(second)
    return answer
}

// fff 是一個 "函數的變數" 他的型態 (Int, Int) ->Int
// 所以 fff 可以把add, sub, mul 指定給他(注意！！div不行)
var fff:((Int, Int) -> Int)?

print("Input two integers, this app will caculate them for you")

print("First:", terminator:"")
var a = Int(readLine()!)!

print("Second:", terminator:"")

var b = Int(readLine()!)!

print("what kind of caculation you want to do (\"+\" ===> 1, \"-\" ===> 2, \"x\" ===> 3)")

var method = Int(readLine()!)!






if method == 1 {
//    print("You want to do  \"add\", so the anser is \(add(first: a, second: b))")
    fff = add
}
else if method == 2 {
//    print("You want to do  \"add\", so the anser is \(sub(first: a, second: b))")
    fff = sub
}
else if method == 3 {
//    print("You want to do  \"add\", so the anser is \(mul(first: a, second: b))")
    fff = mul
}

// 下面這個Optional binding 可以用 "xxxx ?? yyyy"這種心語法寫得更短！！
//print("The answer is \(fff ?? default v(a, b))")
/*
if let ok = fff {
    print("So the answer is \(ok(a, b))")
}
else{
    print("Yout function is not correctlly initialize")
}
*/
/// xxxx ?? yyyy ==== > 如果xxxx有就用！沒有就用yyyy =====> ?? 是一個"深度語意"
print("So the answer is \((fff ?? add) (a, b))")
