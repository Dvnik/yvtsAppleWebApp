

import Foundation


var output:OutputStream

if let output = OutputStream(toFileAtPath: "/Users/trixie/Desktop/iOS_practice/0602/test/test/data.csv", append: false) {
    output.open()
    
    var helloWorld = "學號,姓名,英文,數學\n"
    helloWorld += "1,john,88,95\n"
    helloWorld += "2,mary,56,54\n"
    helloWorld += "3,tom,66,84"
    
    let data = helloWorld.data(using: String.Encoding.utf8, allowLossyConversion: false)!
    let dataMutablePointer = UnsafeMutablePointer<UInt8>.allocate(capacity: data.count)
    
    // Copies the bytes to the Mutable Pointer
    data.copyBytes(to: dataMutablePointer, count: data.count)
    
    // Cast to regular UnsafePointer
    let dataPointer = UnsafePointer<UInt8>(dataMutablePointer)
    
    // Your stream
    output.write(dataPointer, maxLength: data.count)
    
    output.close()
}
else
{
    print("ERROR!!")
}
