


//var students_score = ["john": 100, "mary" : 85, "tom" : 77]
//
//
//var namesOfIntegers = [Int: String]()
//
//namesOfIntegers[16] = "sixteen"
//// namesOfIntegers now contains 1 key-value pair
//namesOfIntegers = [:]
//// namesOfIntegers is once again an empty dictionary of type [Int: String]


var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]

print("The airports dictionary contains \(airports.count) items.")
// Prints "The airports dictionary contains 2 items."

if airports.isEmpty {
    print("The airports dictionary is empty.")
} else {
    print("The airports dictionary is not empty.")
}
// Prints "The airports dictionary is not empty."

airports["LHR"] = "London"
// the airports dictionary now contains 3 items

airports["LHR"] = "London Heathrow"
// the value for "LHR" has been changed to "London Heathrow"

if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
    print("The old value for DUB was \(oldValue).")
}
else {
    print("Not find key can update.")
}
// Prints "The old value for DUB was Dublin."


