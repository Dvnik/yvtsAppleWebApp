let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]

print(oddDigits.union(evenDigits).sorted())
// [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
print(oddDigits.intersection(evenDigits).sorted())
// []
print(oddDigits.subtracting(singleDigitPrimeNumbers).sorted())
// [1, 9]
print(oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted())
// [1, 2, 9]


