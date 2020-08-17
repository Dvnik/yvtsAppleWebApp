//
//  myTextFiledDelegator.swift
//  delegation
//
//  Created by Trixie Lulamoon on 2020/6/4.
//  Copyright © 2020 Trixie Lulamoon. All rights reserved.
//

import UIKit
// https://stackoverflow.com/questions/35992800/check-if-a-string-is-alphanumeric-in-swift/43031430
extension String {

    func isAlphanumeric() -> Bool {
        return self.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) == nil && self != ""
    }

    func isAlphanumeric(ignoreDiacritics: Bool = false) -> Bool {
        if ignoreDiacritics {
            return self.range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil && self != ""
        }
        else {
            return self.isAlphanumeric()
        }
    }

}

class myTextFiledDelegator: NSObject, UITextFieldDelegate
{
    func textFieldDidEndEditing(_ textField: UITextField)
    {
//        print("輸入完了！你輸入的內容：\(textField.text!)")
        // 回家作業，如何把以下內容組合
        var textIsIegal = true
        for c in textField.text!
        {
            let x:Character = c
            if x.asciiValue! > 47 && x.asciiValue! <= 57
            {
                print("Number:\(x) OK")
            }
            else if x.asciiValue! > 64 && x.asciiValue! < 91
            {
                print("Upper:\(x) OK")
            }
            else if x.asciiValue! > 96 && x.asciiValue! < 123
            {
                print("Lower:\(x) OK")
            }
            else
            {
                print("不支援字元 \(x)")
                textIsIegal = false
                break
            }
        }
        

        if textIsIegal
        {
            print("輸入的文字合法！")
        }
        else
        {
            print("輸入的文字不合法，請輸入數字／大寫／小寫之內的字元！！")
        }
        /*
        for c in textField.text!
        {
            let x:Character = c
            if x.asciiValue! < 48 || x.asciiValue! > 57
            {
                print("你輸入了數字以外的字元 \(x)")
                break
            }
         
            
        }
        
        for c in textField.text!
        {
            let x:Character = c
            if x.asciiValue! < 65 || x.asciiValue! > 90
            {
                print("你輸入了大寫字母以外的字元 \(x)")
                break
            }
         
            
        }
        for c in textField.text!
        {
            let x:Character = c
            if x.asciiValue! < 97 || x.asciiValue! > 122
            {
                print("你輸入了小寫字母以外的字元 \(x)")
                break
            }
         
            
        }
 */
        /*
        for c in textField.text! {
            if (c.isSymbol || c.isPunctuation || c.isCurrencySymbol || c.isMathSymbol)
            {
                print("你輸入有不合規定的字元")
                break
            }
        }
        
        */
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        print("xxxx")
        print(range)
        for c in textField.text! {
            if (c.isSymbol || c.isPunctuation || c.isCurrencySymbol || c.isMathSymbol)
            {
                print("你輸入有不合規定的字元")
                break
            }
        }
        
        // some condition
        return true
    }

}
