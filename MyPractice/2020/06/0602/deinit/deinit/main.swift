import Foundation

class JLCat {
    var number:Int?
    var species:String?
    var cost:Float?
    var erase: Bool = true
    
    init(number:Int, species:String, cost:Float) {
        self.number = number
        self.species = species
        self.cost = cost
        // wow!! swift String is powerful enough to do output
        let test = "\(self.number!),\(self.species!),\(self.cost!),"

        do {
            try test.write(
                toFile: "/Users/trixie/Desktop/iOS_practice/0602/deinit/deinit/data.txt",
                atomically: true,
                encoding: String.Encoding.utf8)
        }
        catch {
            print("無法寫入！！錯誤是：\(error)")
        }
    }
    
    deinit {
        if(self.erase)
        {
            print("GONE!!will clear yout data.txt")
            do {
            try "".write(
                toFile: "/Users/trixie/Desktop/iOS_practice/0602/deinit/deinit/data.txt",
                atomically: true,
                encoding: String.Encoding.utf8)
            }
            catch {
                print("無法寫入！！錯誤是：\(error)")
            }
        }
        else
        {
                print("leave data!")
        }
    }
}


print("======PET SHOP OPEN=========")
print("We ship in a cat")
var c1:JLCat?

c1 = JLCat(number: 1, species: "波斯", cost: 600)

while(true) {
    print("Are you want to leave?(y:yes, other:no)")
    let go = readLine()!
    if go == "y" {
        
        print("Keep data?(y:yes, other:no)")
        let keep = readLine()!
        if keep == "y" {
            c1!.erase = false
        }
        break
    }
}



c1 = nil


/*
var output:OutputStream
if let output = OutputStream(toFileAtPath: "/Users/trixie/Desktop/iOS_practice/0602/deinit/deinit/data.txt", append: true)
{
    // too many low level operation, we'll do this when you are good enough
    output.write(<#T##buffer: UnsafePointer<UInt8>##UnsafePointer<UInt8>#>, maxLength: <#T##Int#>)
}
else
{
    print("There are problems to build a output stream")
}
*/

print("=====OVER======")



