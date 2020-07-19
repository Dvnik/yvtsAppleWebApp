
/*
 *
    class 與 struct的不同處
 1. struct 會自動建立一個可設定所有元素的建構子，class不會自動做
 2. struct 多重指定變數時，會用「複製」的方式指定給新的變數，即複製一個新的記憶體區塊給新的變數；class則是會增加引數計數，讓多個變數共用一塊記憶體。
 3. struct 並不是實體，因此比class能運用的計算還要少。
 4. struct 不能“被繼承”
 
 */
struct studentS {
    var mark1:Int
    var mark2:Int
    var mark3:Int
}


class studentC {
    var mark1:Int
    var mark2:Int
    var mark3:Int
    init() {
        mark1 = 100
        mark2 = 200
        mark3 = 300
    }
    init(mark1:Int, mark2:Int, mark3:Int) {
        self.mark1 = mark1
        self.mark2 = mark2
        self.mark3 = mark3
    }
}

var johnS = studentS(mark1: 12, mark2: 34, mark3: 56)
var johnC = studentC(mark1: 77, mark2: 88, mark3: 99)

var dataS:studentS
dataS = johnS
/*
print("the first mark of john is \(johnS.mark1)")
print("the data mark of in my document is \(dataS.mark1)")


johnS.mark1 = 15

print("the first mark of john is \(johnS.mark1)")
print("the data mark of in my document is \(dataS.mark1)")
 
print(Unmanaged<AnyObject>.passUnretained(johnS as AnyObject).toOpaque())
print(Unmanaged<AnyObject>.passUnretained(dataS as AnyObject).toOpaque())
*/



var dataC:studentC
dataC = johnC

print("the first mark of john is \(johnC.mark1)")
print("the data mark of in my document is \(dataC.mark1)")


johnC.mark1 = 15

print("the first mark of john is \(johnC.mark1)")
print("the data mark of in my document is \(dataC.mark1)")

print(Unmanaged.passUnretained(johnC).toOpaque())
print(Unmanaged.passUnretained(dataC).toOpaque())





// = << 指定
// == << 純量相等判定
// === <<
