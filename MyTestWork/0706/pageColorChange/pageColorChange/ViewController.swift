//
//  ViewController.swift
//  pageColorChange
//
//  Created by Trixie Lulamoon on 2020/7/6.
//  Copyright © 2020 yihsuan hong. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
    //MARK: - Values
    @IBOutlet weak var sliderRed: UISlider!
    
    @IBOutlet weak var sliderGreen: UISlider!
    
    @IBOutlet weak var sliderBlue: UISlider!
    
    @IBOutlet weak var previewUI: UIView!
    
    var usingColor: UIColor?
    
    @IBOutlet weak var hexLabel: UILabel!
    
    //MARK: - Target Action
    // 當Slider值改變時即時更改顏色與文字
    @IBAction func colorValueChanged(_ sender: UISlider)
    {
        if sender.restorationIdentifier == nil
        {
            return
        }
        usingColor = getUIColor(red: sliderRed.value, green: sliderGreen.value, blue: sliderBlue.value)
        previewUI.backgroundColor = usingColor
        showHexText()
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
    func showHexText() {
        let r:Int = Int(sliderRed.value)
        let g:Int = Int(sliderGreen.value)
        let b:Int = Int(sliderBlue.value)
        hexLabel.text = String(format: "%02x%02x%02x", r, g, b)
    }

    //MARK: - Life Cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        usingColor = getUIColor(red: sliderRed.value, green: sliderGreen.value, blue: sliderBlue.value)
        previewUI.backgroundColor = usingColor
        showHexText()
    }
    // 即將由連接線換頁
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "ToVC2"
        {
            let vc2 = segue.destination as! ViewController2
            vc2.showBgColor = usingColor
        }
    }

}

