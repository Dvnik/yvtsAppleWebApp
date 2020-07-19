
class sides {
   var corners = 4
   var description: String {
      return "\(corners) sides"
   }
}

let rectangle = sides()
print("Rectangle: \(rectangle.description)")

class pentagon: sides {
    override init() {
        
      super.init()
      corners = 5
   
    }
    
    
    
}

let bicycle = pentagon()
print("Pentagon: \(bicycle.description)")
