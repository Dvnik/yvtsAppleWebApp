// I define a "TYPE" with enumeration to decribe "The days in a week" for myself!!


/*
print("What day is today?(0:Sun, 1:Mon,  ...... 6:Sat)")

var day: Int
day = Int(readLine()!)!

switch day {
    case 0:
        print("Beautiful Sunday")
    case 1:
        print("Blue Monday")
    case 2:
        print("Warming up Tuesday")
    case 3:
        print("Hardworking Wednesday")
    case 4:
        print("Expecting Thursday")
    case 5:
        print("Waguwagu Friday")
    case 6:
        print("Happy Saturday")
    default:
        print("Don't know what you input.")
    
}

print("=======OVER========")
*/


enum DayofaWeek: Int {
    case Sunday
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
}


print("What day is today?(0:Sun, 1:Mon,  ...... 6:Sat)")

var day:DayofaWeek?
var input = Int(readLine()!)!

if input == 0 {
    day = .Sunday
}else if input == 1{
    day = .Monday
}else if input == 2{
    day = .Tuesday
}else if input == 3{
    day = .Wednesday
}else if input == 4{
    day = .Thursday
}else if input == 5{
    day = .Friday
}else if input == 6{
    day = .Saturday
}

switch day! {
    case .Sunday:
        print("Beautiful Sunday")
    case .Monday:
        print("Blue Monday")
    case .Tuesday:
        print("Warming up Tuesday")
    case .Wednesday:
        print("Hardworking Wednesday")
    case .Thursday:
        print("Expecting Thursday")
    case .Friday:
        print("Waguwagu Friday")
    case .Saturday:
        print("Happy Saturday")
}

print("=======OVER========")
