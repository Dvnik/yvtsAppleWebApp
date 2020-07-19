

var arr:[Int] = []

for _ in 1...10 {
    arr.append(Int.random(in: 1...100))
}


print(arr)

//arr.sort { (x, y) -> Bool in
//    return x < y
//}

for i in 0 ..< arr.count {
    for k in i ..< arr.count {
        if arr[i] > arr[k] {
            let temp = arr[i]
            arr[i] = arr[k]
            arr[k] = temp
        }
    }
}

print(arr)



