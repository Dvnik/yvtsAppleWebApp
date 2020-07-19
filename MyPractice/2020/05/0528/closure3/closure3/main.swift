

var count:[Int] = [5, 10, -6, 75, 20]
print(count)
// 呼叫陣列物件的sort方法(不用參數預設排升冪)
//count.sort()
//print(count)
// 注意！！sorted函數不會改動count!!而是排序後交出一個新的陣列
//var new_count = count.sorted()
//print(new_count)
//
//
//var ascend_count = count.sorted(by: <)
//print(ascend_count)


// 尾隨閉包
var ascend_count = count.sorted(by: ){return $0 < $1 }

print(ascend_count)
