import UIKit

class MyTest
{
    var i = 0
}


var myTest: MyTest!

weak var myTest2:MyTest!

myTest = MyTest()

myTest2 = MyTest()

print("引用計數\(CFGetRetainCount(myTest2) - 1)")
