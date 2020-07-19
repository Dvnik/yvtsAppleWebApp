/*
enum Student {
   case Name(String)
   case Mark(Int,Int,Int)
}

var studDetails = Student.Name("Swift 4")
print(studDetails)
var studMarks = Student.Mark(98,97,95)

switch studMarks {
   case .Name(let studName):
      print("Student name is: \(studName).")
   case .Mark(let Mark1, let Mark2, let Mark3):
      print("Student Marks are: \(Mark1),\(Mark2),\(Mark3).")
}
*/

enum Month: Int {
   case January = 1, February, March, April, May, June, July, August,
      September, October, November, December
}

let yearMonth = Month.May.rawValue
print("Value of the Month is: \(yearMonth).")
