// 重新定義原有的運算子符號，稱作：運算子重載
// 等於的Class為Equatable
class SampleClass: Equatable {
    let myProperty: String
    init(s: String ) {
        myProperty = s
    }
}
// 基本語法
func == (lhs: SampleClass, rhs: SampleClass) -> Bool {
    // 此區塊重新定義相等的方式
    return lhs.myProperty == rhs.myProperty
}


let spClass1 = SampleClass(s: "Hello")
let spClass2 = SampleClass(s: "Hello")


print("spClass1 === spClass2 is \(spClass1 === spClass2)")// false
print("spClass1 !== spClass2 is \(spClass1 !== spClass2)")// true
print("spClass1 == spClass2 is \(spClass1 == spClass2)")// true
