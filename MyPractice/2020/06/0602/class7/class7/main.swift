
class classA {
    required init() {
        let a = 10
        print(a)
    }
}

class classB: classA {
    required init() {
        let b = 30
        print(b)
    }
    init(aaa:Int){
        print("ytest")
    }
}

let res = classA()
let pr = classB()
