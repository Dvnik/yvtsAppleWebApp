

/*
var x:Int8 = 123

print("The variable x is \(x)")

var y:Int64 = 123

print(x == y)
print(x.hashValue == y.hashValue)
*/

var letters = Set<Character>()
print("letters is of type Set<Character> with \(letters.count) items.")
// Prints "letters is of type Set<Character> with 0 items."

letters.insert("a")
// letters now contains 1 value of type Character
letters = []
// letters is now an empty set, but is still of type Set<Character>


var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
// favoriteGenres has been initialized with three initial items

//print("I have \(favoriteGenres.count) favorite music genres.")
//// Prints "I have 3 favorite music genres."
//
//if favoriteGenres.isEmpty {
//    print("As far as music goes, I'm not picky.")
//} else {
//    print("I have particular music preferences.")
//}
//// Prints "I have particular music preferences."

favoriteGenres.insert("Jazz")
// favoriteGenres now contains 4 items

//if let removedGenre = favoriteGenres.remove("Rock") {
//    print("\(removedGenre)? I'm over it.")
//} else {
//    print("I never much cared for that.")
//}
//// Prints "Rock? I'm over it."
//
//if favoriteGenres.contains("Funk") {
//    print("I get up on the good foot.")
//} else {
//    print("It's too funky in here.")
//}
//// Prints "It's too funky in here."
//
//for genre in favoriteGenres {
//    print("\(genre)")
//}
//// Classical
//// Jazz
//// Hip hop
//
//for genre in favoriteGenres.sorted() {
//    print("\(genre)")
//}
//// Classical
//// Hip hop
//// Jazz


let xxx = favoriteGenres.sorted()
print(xxx)

