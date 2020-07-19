print("Input two integer numbers, this app will caculate them for you")


print("Input first one:", terminator: "")

var first_number_real = Float(readLine(strippingNewline: true)!)!

print("Input second one:", terminator: "")
var second_number_real = Float(readLine(strippingNewline: true)!)!

print("The sum is \(first_number_real + second_number_real)")
print("The substraction is \(Int(first_number_real - second_number_real))")
print("The multiplation is \(Int(first_number_real * second_number_real))")
print("The division is \(first_number_real / second_number_real)")
