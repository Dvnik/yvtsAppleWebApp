

import Foundation
/*
// String creation using String literal
var stringA = "Hello, Swift 4!"
print( stringA )

// String creation using String instance
var stringB = String("Hello, Swift 4!")
print( stringB )

//Multiple line string

let stringC = """
Hey this is a
example of multiple Line
string by tutorialsPoint

"""
print(stringC)
*/
/*
// stringA can be modified
var stringA = "Hello, Swift 4!"
stringA += "--Readers--"
print( stringA )

// stringB can not be modified
let stringB = String("Hello, Swift 4!")
stringB += "--Readers--"
print( stringB )
*/

var unicodeString = "Dog???"

print("UTF-8 Codes: ")
for code in unicodeString.utf8 {
   print("\(code) ")
}

print("\n")

print("UTF-16 Codes: ")
for code in unicodeString.utf16 {
   print("\(code) ")
}
