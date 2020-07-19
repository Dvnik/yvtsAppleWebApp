let input = "Swift Tutorails"

//let x:String.Index = input.index(input.startIndex, offsetBy: -3)
let x:String.Index = input.index(input.endIndex, offsetBy: -3)

print(input[x])
