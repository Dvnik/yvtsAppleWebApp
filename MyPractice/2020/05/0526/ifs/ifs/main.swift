
var varA:Int = 100;
var varB:Int = 200;
/*
/* Check the boolean condition using if statement */
if varA == 100 {
   /* If condition is true then print the following */
   print("First condition is satisfied");

   if varB == 200 {
      /* If condition is true then print the following */
      print("Second condition is also satisfied");
   }
}
*/
/*
if varA == 100 && varB == 200 {
    print("Second condition is also satisfied.")
}

print("Value of variable varA is \(varA)");
print("Value of variable varB is \(varB)");
*/

var index = 10

switch index {
case 100:
    print("Value of index is 100.")
    fallthrough
case 10, 15, 5:
    print("value of index if")
default:
    print("Not find")
}



