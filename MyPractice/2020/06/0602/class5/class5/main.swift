class Planet {
   var name: String
   init(name: String) {
      self.name = name
   }
   convenience init() {
      self.init(name: "[No Planets]")
   }
}

let plName = Planet(name: "Mercury")
print("Planet name is: \(plName.name)")

let noplName = Planet()
print("No Planets like that: \(noplName.name)")

class planets: Planet {
   var count: Int
   init(name: String, count: Int) {
      self.count = count
      super.init(name: name)
   }
   override convenience init(name: String) {
      self.init(name: name, count: 1)
   }
}
