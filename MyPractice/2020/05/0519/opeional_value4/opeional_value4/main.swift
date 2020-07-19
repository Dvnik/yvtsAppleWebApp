

print("=======GUESSING NUMBER GAME=====")

print("Guess what number in my mind now?(between 0~9)")

var YOU_GUESS:Int8
YOU_GUESS = Int8(readLine()!)!


if YOU_GUESS >= 10
{
    print("WRONG!! Too big!! and out of bound")
}
else if YOU_GUESS <= 9 && YOU_GUESS >= 7
{
    print("Oh!Oh! WRONG! Too big")
}
else if YOU_GUESS == 6 {
    print("BINGO!!")
}
else if YOU_GUESS <= 5 && YOU_GUESS >= 0
{
    print("Oh!Oh! WRONG! Too big")
}
else {
    print("WRONG!! Too small! and out of bound")
}


print("=======GAME OVER========")


