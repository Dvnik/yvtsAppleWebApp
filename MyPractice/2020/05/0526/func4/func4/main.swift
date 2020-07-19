


func minMax(array: [Int]) -> (min: Int, max: Int)? {
   if array.isEmpty { return nil }
   var currentMin = array[0]
   var currentMax = array[0]
   
   for value in array[1..<array.count] {
      if value < currentMin {
         currentMin = value
      } else if value > currentMax {
         currentMax = value
      }
   }
   return (currentMin, currentMax)
}

if let bounds = minMax(array: [8, -6, 2, 109, 3, 71]) {
   print("min is \(bounds.min) and max is \(bounds.max)")
}

var my_arr:[Int] = []

for _ in 1...10 {
    my_arr.append(Int.random(in: 1...20))
}
print(my_arr)

//print(minMax(array: my_arr)!)


if let result = minMax(array: my_arr)
{
    print(result)
}
else
{
    print("Your array passed in unqualified.")
    
}
