
var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
airports["LHR"] = "London Heathrow"
airports.updateValue("Dublin Airport", forKey: "DUB")
airports["APL"] = "Apple International"

//var my:(String, String)
//for my in airports {
//    print("機場代號:\(my.0), 機場全名:\(my.1)" )
//}
// swift 的特性
for (airportCode, airportName) in airports {
    print("機場代號:\(airportCode), 機場全名:\(airportName)" )
}

for airportCode in airports.keys {
    print("機場代號:\(airportCode)")
}

for airportName in airports.values {
    print("機場全名:\(airportName)")
}
