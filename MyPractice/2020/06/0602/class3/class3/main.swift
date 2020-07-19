/*
class mainClass {
   var no1 : Int // local storage
   init(no1 : Int) {
      self.no1 = no1 // initialization
   }
}

class subClass : mainClass {
   var no2 : Int
   init(no1 : Int, no2 : Int) {
      self.no2 = no2
      super.init(no1:no1)
   }
   // Requires only one parameter for convenient method
   override convenience init(no1: Int) {
      self.init(no1:no1, no2:0)
   }
}

let res = mainClass(no1: 20)
let pr = subClass(no1: 30, no2: 50)

print("res is: \(res.no1)")
print("res is: \(pr.no1)")
print("res is: \(pr.no2)")
*/

class mainClass {
   var no1 : Int // local storage
   init(no1 : Int) {
      self.no1 = no1 // initialization
   }
}

class subClass : mainClass {
   var no2 : Int
   init(no1 : Int, no2 : Int) {
      self.no2 = no2
      super.init(no1:no1)
   }
   // Requires only one parameter for convenient method
   override convenience init(no1: Int) {
      self.init(no1:no1, no2:0)
   }
}

let res = mainClass(no1: 20)
let pr = subClass(no1: 30, no2: 50)
let pr2 = subClass(no1: 23)

print("res is: \(res.no1)")
print("res is: \(pr.no1)")
print("res is: \(pr.no2)")
