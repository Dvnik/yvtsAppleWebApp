

struct studentMarks {
    var mark1:Int?
    var mark2:Int?
    var mark3:Int?
    var name:String = ""
    init() {
    }
    
    init(第一次月考 m1:Int, m2:Int, m3:Int) {
        mark1 = m1
        mark2 = m2
        mark3 = m3
    }
    init(m1:Int) {
        mark1 = m1
    }
    
    func 告訴大家我叫什麼名字() {
        print("我是\(self.name)")
    }
    
    func 物件() {
        print(self)
    }
    
}


var john:studentMarks
john = studentMarks(第一次月考: 77, m2: 88, m3: 99)
john.name = "約翰"
print(john.mark1!)
john.告訴大家我叫什麼名字()
john.物件()

var mary = studentMarks(m1: 99)
mary.name = "瑪莉"
mary.告訴大家我叫什麼名字()
mary.物件()

print("==========OVER=========")
