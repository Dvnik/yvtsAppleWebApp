class JLCat {
    func meow()
    {
        print("MEOW~~~")
    }
    
    static func test() {
        print("This is a class level method.")
    }
    
}
JLCat.test()

var obj = JLCat()
obj.meow()
