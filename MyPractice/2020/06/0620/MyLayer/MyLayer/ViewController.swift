
import UIKit

class ViewController: UIViewController
{
    // 風景圖層
    var layerShore:CALayer!
    // 陰影圖層
    var layerShadow:CALayer!
    // 蘋果圖層
    var layerApple:CALayer!
    // 記錄每次矩陣轉換後的狀態
    var transformIdentity = CGAffineTransform.identity
    
    //MARK: - Target Action
    //「將圖片載入圖層」按鈕
    @IBAction func buttonPaintInLayer(_ sender: UIButton)
    {
        // Step1.初始化一個圖層
        layerShore = CALayer()
        // Step2.設定圖層大小
        layerShore.frame = CGRect(x: 50, y: 120, width: 300, height: 300)
        // Step3.<方法一>在layerShore圖層塗上
//        layerShore.backgroundColor = UIColor.cyan.cgColor
//        layerShore.backgroundColor = UIColor(red: 230/255, green: 180/255, blue: 200/255, alpha: 0.3).cgColor
        
        // Step3.<方法二>在layerShore圖層繪製圖片
        layerShore.contents = UIImage(named: "shore.jpg")?.cgImage
        layerShore.contentsGravity = .resizeAspectFill // 調整圖層的縮放模式
        layerShore.masksToBounds = true  // 設定邊緣裁切
        // Step4.將layerShore圖層加到「底面self.view」的圖層上
        self.view.layer.addSublayer(layerShore)
        // Step5.按鈕只允許按下一次，之後讓按鈕失效
        sender.isEnabled = false
        
    }
    //「設定陰影」按鈕
    @IBAction func buttonSetShadow(_ sender: UIButton)
    {
        if layerShore != nil
        {
            // 當陰影塗層不存在，風景圖層已經存在時
            if layerShadow == nil
            {
                // Step1.初始化陰影塗層
                layerShadow = CALayer()
                // Step2.設定陰影圖層大小，與風景圖層一致
                layerShadow.frame = layerShore.frame
                
                // Step3-1.設定陰影圖層本身的背景顏色為紅色
                layerShadow.backgroundColor = UIColor.red.cgColor
                // Step3-2.設定陰影圖層的陰影顏色
                layerShadow.shadowColor = UIColor(red: 100/255, green: 25/255, blue: 45/255, alpha: 0.8).cgColor
                // Step4. 設定陰影圖層上陰影的偏移量
                layerShadow.shadowOffset = CGSize(width: 15, height: 15)
                // Step5.設定陰影的透明度（透明度預設為0）
                layerShadow.shadowOpacity = 0.8
                // Step6.顯現陰影圖層在風景圖層之後
                self.view.layer.insertSublayer(layerShadow, below: layerShore)
                // Step7.確認陰影與風景的圓角一致
                layerShadow.cornerRadius = layerShore.cornerRadius
                // 更改按鈕文字
                sender.setTitle("取消陰影", for: .normal)
            }
            else
            {
                // 把陰影圖層從畫面移除
                layerShadow.removeFromSuperlayer()
                // 釋放陰影圖層
                layerShadow = nil
                // 更改按鈕文字
                sender.setTitle("設定陰影", for: .normal)
                
            }
        }
    }
    //「設定圓角」按鈕
    @IBAction func buttonSetCornerRadius(_ sender: UIButton)
    {
        // 設定正圓形圓角(條件：1.圖片為正方形，2.圓角為寬度的一半)
//        layerShore.cornerRadius = layerShore.frame.size.width / 2
        // 當風景圖層已經存在時
        if layerShore != nil
        {
            
            // 而且陰影圖層也存在時
            if layerShadow != nil && layerShadow.cornerRadius == 0
            {
                // 取風景圖層的圓角
                layerShore.cornerRadius = 20
                // 更改按鈕文字
                sender.setTitle("取消圓角", for: .normal)
//                // 而且陰影圖層也存在時   // <--移除if-else 之外
//                if layerShadow != nil
//                {
//                    // 將陰影的圓角設定成跟風景圖層
//                    layerShadow.cornerRadius = layerShore.cornerRadius
//                }
            }
            else// 當已經取出圓角時
            {
                // 恢復成沒有圓角
                layerShore.cornerRadius = 0;
                // 更改按鈕文字
                sender.setTitle("設定圓角", for: .normal)
//                if layerShadow != nil
//                {
//                    // 將陰影的圓角設定成跟風景圖層
//                    layerShadow.cornerRadius = layerShadow.cornerRadius
//                }
            }
            
            
            
            // 而且陰影圖層也存在時
            if layerShadow != nil
            {
                // 將陰影的圓角設定成跟風景圖層
                layerShadow.cornerRadius = layerShore.cornerRadius
            }
        }
    }
    
    
    
    @IBAction func sliderValueChanged(_ sender: UISlider)
    {
        // 取得特定旋轉角度過後的新矩陣(運用矩陣的仿射運算函式計算，參數為弧度，須將角度換算成弧度)
        let transform = CGAffineTransform(rotationAngle: CGFloat(sender.value) / 180 * CGFloat.pi)
        // 將旋轉過後的新矩陣，設定給圖層來執行旋轉
        layerApple.setAffineTransform(transform)
    }
    
    // 在底面上操作的旋轉手勢
    @IBAction func gestureRotationInView(_ sender: UIRotationGestureRecognizer)
    {
        print("旋轉手勢的弧度：\(sender.rotation)")
//        // 取得特定旋轉角度過後的新矩陣(運用矩陣的仿射運算函式計算，參數為弧度，須將角度換算成弧度)
//        let transform = CGAffineTransform(rotationAngle: sender.rotation)
//        // 將旋轉過後的新矩陣，設定給圖層來執行旋轉
//        layerApple.setAffineTransform(transform)
        
        switch sender.state
        {
        case .began:
            // 記錄上一次layerApple圖層最後的矩陣轉換狀態
            transformIdentity = layerApple.affineTransform()
        case .changed, .ended:
            // 取得以上一次layerApple圖層旋轉過後的矩陣，再繼續往下旋轉的新矩陣
            let transform = transformIdentity.rotated(by: sender.rotation)
            // 將旋轉過後的新矩陣，設定給圖層來執行旋轉
            layerApple.setAffineTransform(transform)
        default:
            break
        }
    }
    // 在底面上操作的縮放手勢
    @IBAction func gesturePinchInView(_ sender: UIPinchGestureRecognizer)
    {
        print("縮放手勢的值:\(sender.scale)")
        switch sender.state
        {
        case .began:
            // 記錄上一次layerApple圖層最後的矩陣轉換狀態
            transformIdentity = layerApple.affineTransform()
        case .changed, .ended:
            // 取得以上一次layerApple圖層縮放過後的矩陣，再繼續往下縮放的新矩陣
            let transform = transformIdentity.scaledBy(x: sender.scale, y: sender.scale)
            // 將縮放過後的新矩陣，設定給圖層來執行縮放
            layerApple.setAffineTransform(transform)
        default:
            break
        }
    }
    
    
    
    
    
    //MARK: - View LifeCycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // <方法一>操作底圖背景色的"表層"顏色
//        self.view.backgroundColor = UIColor.purple
//        self.view.backgroundColor = UIColor(red: 120/255, green: 0/255, blue: 68/255, alpha: 1)
        // <方法二>操作底圖背景色的"圖層"顏色
//        self.view.layer.backgroundColor = UIColor.purple.cgColor
        self.view.layer.backgroundColor = UIColor(red: 150/255, green: 200/255, blue: 138/255, alpha: 1).cgColor
        // Step1.初始化一個layerApple圖層
        layerApple = CALayer()
        // Step2.設定圖層大小
        layerApple.frame = CGRect(x: 35, y: 450, width: 150, height: 150)
        // Step3.在layerApple圖層繪製圖片
        layerApple.contents = UIImage(named: "apple.png")?.cgImage
        layerApple.contentsGravity = .resizeAspectFill // 調整圖層的縮放模式
        layerApple.masksToBounds = true  // 設定邊緣裁切
        // Step4.將layerShore圖層加到「底面self.view」的圖層上
        self.view.layer.addSublayer(layerApple)
    }


}

