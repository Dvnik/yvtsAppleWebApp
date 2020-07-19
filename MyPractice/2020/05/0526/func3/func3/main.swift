func ls(array: [Int]) -> (large: Int, small: Int) {
   var lar = array[0]
   var sma = array[0]

   for i in array[1..<array.count] {
      if i < sma {
         sma = i
      } else if i > lar {
         lar = i
      }
   }
   return (lar, sma)
}

let num = ls(array: [40,12,-5,78,98])
print("Largest number is: \(num.large) and smallest number is: \(num.small)")



var my_arr:[Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0]
//for i in 0...9 {
//    my_arr.append(Int.random(in: 1...20))
//}
for i in 0...9 {
    my_arr[i] = Int.random(in: 1...20)
}
print(my_arr)

var result = ls(array: my_arr)
print("In your array, the biggest is \(result.0), smallest is \(result.1)")
