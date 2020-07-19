print("Input two integer numbers, this app will caculate them for you")


print("Input first one:", terminator: "")

var first_number:String
first_number = readLine(strippingNewline: true)!
var first_number_real:Int
first_number_real = Int(first_number)!

print("Input second one:", terminator: "")
var second_number:String
second_number = readLine(strippingNewline: true)!
var second_number_real:Int
second_number_real = Int(second_number)!

print("You input \(first_number) and \(second_number)")

print("The sum is \(first_number_real + second_number_real)")
print("The substraction is \(first_number_real - second_number_real)")
print("The multiplation is \(first_number_real * second_number_real)")
print("The division is \(first_number_real / second_number_real)")
