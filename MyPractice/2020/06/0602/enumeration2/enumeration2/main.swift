enum functions {
   case a, b, c, d
   init?(funct: String) {
      switch funct {
      case "one":
         self = .a
      case "two":
         self = .b
      case "three":
         self = .c
      case "four":
         self = .d
      default:
         return nil
      }
   }
}
let result = functions(funct: "two")

if result != nil {
   print("With In Block Two \(result!)")
}
let badresult = functions(funct: "five")

if badresult == nil {
   print("Block Does Not Exist")
}
