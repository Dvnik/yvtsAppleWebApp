
import Foundation

func love_times(times:Int) {
    for i in 1...times {
        print("I LOVE YOU. No.\(i)")
    }
}

func action_times(action:String, times:Int) -> Void {
    for i in 1...times {
        print("I \(action) YOU No.\(i)")
    }
}

func who_action_times(who:String, action:String, times:Int) -> Void {
    for i in 1...times {
        print("\(who) \(action) YOU No.\(i)")
    }
}

print("Who is it?")
let who = readLine()!

print("How many time do you want me to do to you?")

let act = readLine()!

print("How many times do you want me to \(act)")

let time = Int(readLine()!)!



