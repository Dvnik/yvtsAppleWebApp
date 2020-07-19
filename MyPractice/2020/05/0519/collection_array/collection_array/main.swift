
/*
var friends:[String] = ["john", "mary", "tom", "jack", "mark"]

for temp in friends {
    print("\(temp)", terminator: "")
}

*/
//========

var friends:[String] = ["john", "mary", "tom", "jack", "mark"]
//print("friends陣列的第1個元素是:\(friends[0])")
//print("friends陣列的第4個元素是:\(friends[3])")

for index in 0...4 {
    print("friends陣列的第\(index + 1)個元素是:\(friends[index])")
}


