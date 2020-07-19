/*
var someInts = [1, 2, 3]

print(someInts)
*/
/*
var threeDoubles = Array(repeating: 0.0, count: 3)
print(threeDoubles)
*/
var shoppingList = ["Eggs", "Milk"]
print("The shopping list contains \(shoppingList.count) items.")
// Prints "The shopping list contains 2 items."
if shoppingList.isEmpty {
    print("The shopping list is empty.")
} else {
    print("The shopping list is not empty.")
}
// Prints "The shopping list is not empty."
shoppingList.append("Flour")
// shoppingList now contains 3 items, and someone is making pancakes
shoppingList += ["Baking Powder"]
// shoppingList now contains 4 items
shoppingList += ["Chocolate Spread", "Cheese", "Butter"]
// shoppingList now contains 7 items
var firstItem = shoppingList[0]
// firstItem is equal to "Eggs"
shoppingList[0] = "Six eggs"
// the first item in the list is now equal to "Six eggs" rather than "Eggs"
shoppingList[4...6] = ["Bananas", "Apples"]
// shoppingList now contains 6 items
print(shoppingList)
shoppingList.insert("Maple Syrup", at: 0)
// shoppingList now contains 7 items
// "Maple Syrup" is now the first item in the list
