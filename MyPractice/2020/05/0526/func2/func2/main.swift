
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

print("Input two integers, this app caculates them for you.")


var a, b:Int

print("first:", terminator: "")
a = Int(readLine()!)!

print("second:", terminator: "")
b = Int(readLine()!)!

print("Yout input \(a) and \(b)")
var aaa = add(first: a, second: b)

print("sum = \(add(first: a, second: b))")
print("sub = \(sub(first: a, second: b))")
print("mul = \(mul(first: a, second: b))")
print("div = \(div(first: a, second: b))")
