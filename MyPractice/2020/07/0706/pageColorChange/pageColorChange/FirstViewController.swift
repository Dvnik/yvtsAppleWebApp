//
//  ViewController.swift
//  pageColorChange
//
//  Created by Trixie Lulamoon on 2020/7/6.
//  Copyright © 2020 yihsuan hong. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController
{
    
    //MARK: - Values
    @IBOutlet weak var sliderRed: UISlider!
    
    @IBOutlet weak var sliderGreen: UISlider!
    
    @IBOutlet weak var sliderBlue: UISlider!
    
    @IBOutlet weak var viewColor: UIView!
    
    var usingColor: UIColor?
    
    @IBOutlet weak var hexLabel: UILabel!
    
    //MARK: - Target Action
    // 當Slider值改變時即時更改顏色與文字
    // 紅綠藍三色滑桿的對應事件
    @IBAction func colorValueChanged(_ sender: UISlider)
    {
        usingColor = getUIColor(red: sliderRed.value,
                                green: sliderGreen.value,
                                blue: sliderBlue.value)
        viewColor.backgroundColor = usingColor
        showHexText()
    }
    // 自行載入第二頁換頁
    @IBAction func buttonNext(_ sender: UIButton) {
        let secondVC = self.storyboard?.instantiateViewController(identifier: "SecondViewController") as! SecondViewController
        secondVC.showBgColor = self.usingColor
        secondVC.modalPresentationStyle = .fullScreen
        self.present(secondVC, animated: true, completion: nil)
        
    }
    
    //MARK:- My Functions
    //將sliders的值轉成UIColor
    func getUIColor(red: Float, green: Float, blue: Float ) -> UIColor {
        var resultColor: UIColor
        
        resultColor = UIColor(red: CGFloat(red / 255),
                              green: CGFloat(green / 255),
                              blue: CGFloat(blue / 255),
                              alpha: CGFloat(1))
        
        return resultColor
    }
    // 顯示sliders的16進位訊息
    // 16進位格式化基本格式為%x，前面不足位數要補零的話就會變成%02x
    // 字母部分要大寫的話就直接用大寫的X即可：%X
    func showHexText() {
        let r:Int = Int(sliderRed.value)
        let g:Int = Int(sliderGreen.value)
        let b:Int = Int(sliderBlue.value)
        hexLabel.text = String(format: "%02X%02X%02X", r, g, b)
    }

    //MARK: - Life Cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        usingColor = getUIColor(red: sliderRed.value, green: sliderGreen.value, blue: sliderBlue.value)
        viewColor.backgroundColor = usingColor
        showHexText()
    }
    // 即將由連接線換頁
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "ToVC2"
        {
            // 由換頁線取得下一頁的執行實體
            let secondVC = segue.destination as! SecondViewController
            secondVC.showBgColor = usingColor
        }
    }

}

