let houseAnimals: Set = ["🐶", "🐱"]
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]

print(houseAnimals)

print(houseAnimals.isSubset(of: farmAnimals))
// true
print(farmAnimals.isSuperset(of: houseAnimals))
// true
print(farmAnimals.isDisjoint(with: cityAnimals))
