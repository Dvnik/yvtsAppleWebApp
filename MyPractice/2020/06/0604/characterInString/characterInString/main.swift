let phrase = "The final score was 32-31"

var numberOfDigits = 0;
var numberOfLetters = 0;
var numberOfSymbols = 0;

for c in phrase {
    if(c.isNumber)
    {
        
        numberOfDigits += 1
    }
    else if c.isLetter
    {
        numberOfLetters += 1
    }
    else if (c.isSymbol || c.isPunctuation || c.isCurrencySymbol || c.isMathSymbol)
    {
        numberOfSymbols += 1
    }
}


print("Digit Count:\(numberOfDigits), Letter Count:\(numberOfLetters), Symbol Count:\(numberOfSymbols)")
