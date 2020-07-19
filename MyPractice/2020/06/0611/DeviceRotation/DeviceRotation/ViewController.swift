

import UIKit

class ViewController: UIViewController
{
    
    @IBOutlet weak var imgPicture: UIImageView!
    
    var deviceWidth:CGFloat = 0
    var deviceHeight:CGFloat = 0
    
    
    
    @IBAction func doAnimate()
    {
        var runDuration = 0.25
        /*
         UIView的amimate方法，可以操作以下屬性的動畫：
         1.frame:相對於其他位置及大小
         2.bounds:自己的位置及大小
         3.center:中央點座標
         4.transform:旋轉
         5.alpha:透明度(0.0~1.0)
         6.contentStrethc:放大縮小(PS.也可以操作frame寬與高)
         **/
        UIView.animate(withDuration: runDuration, animations: {
                        // 第一段動畫：水平移動移動到畫面的右方
                            self.imgPicture.frame.origin.x = self.deviceWidth - 50 - self.imgPicture.frame.size.width
            self.imgPicture.alpha = 0.3
                        }) { (finished) in
                            // 第二段動畫：垂直移動到畫面的下方
                            UIView.animate(withDuration: runDuration, animations: {
                                self.imgPicture.frame.origin.y = self.deviceHeight - 50 - self.imgPicture.frame.size.height
                                self.imgPicture.alpha = 1
                            }) { (finished) in
                                // 第三段動畫：水平移動到畫面的前方
                                UIView.animate(withDuration: runDuration, animations: {
                                    self.imgPicture.frame.origin.x = 50
                                    self.imgPicture.alpha = 0.3
                                }) { (finished) in
                                    // 第四段動畫：垂直移動到畫面的上方
                                    UIView.animate(withDuration: runDuration) {
                                        self.imgPicture.frame.origin.y = 50
                                        self.imgPicture.alpha = 1
                                    }
                                }
                                
                            }
                        }
        
        
        
        
    }
    
    
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("viewDidLoad")
        // 檢測目前執行此App
        switch self.traitCollection.userInterfaceIdiom
        {
        case .pad:
            print("此裝置為iPad.")
        case .phone:
            print("此裝置為iPhone")
        default:
            print("無法判別")
        }
        // 確認目前的螢幕大小
        print(self.view.frame)
        // 記錄螢幕的寬高
        deviceWidth = self.view.frame.size.width
        deviceHeight = self.view.frame.size.height
        print("寬：\(deviceWidth)高：\(deviceHeight)")
    }
    
    // 當畫面完成佈置時(包含設備旋轉時)
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        print("viewDidLayoutSubviews")
        deviceWidth = self.view.frame.size.width
        deviceHeight = self.view.frame.size.height
        print("寬：\(deviceWidth)高：\(deviceHeight)")
        // 更動位置必須在完成限制條件的配置之後
        self.imgPicture.frame = CGRect(x: 60, y: 60, width: 250, height: 250)
        switch UIDevice.current.orientation
        {
            case .landscapeLeft, .landscapeRight:
                // 更換圖片
                self.imgPicture.image = UIImage(named: "landscape")
            case .portrait, .portraitUpsideDown:
                // 更換圖片
                self.imgPicture.image = UIImage(named: "portrait")
            default:
                // 更換圖片
                self.imgPicture.image = UIImage(named: "portrait")
        }
//        // 按一下「執行動畫按鈕」
//        doAnimate()

    }
    // 當設備寬高的Compact或Regular有變化時（注意：iPad永遠不會呼叫這個事件，因為都是Regular）
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator)
    {
        super.willTransition(to: newCollection, with: coordinator)
        // 注意：newCollection 與 self.traitCollection 為同一個裝置型態管理的實體
        // 如果裝置的寬度(horizontalSizeClass)為特定模式時
        if newCollection.horizontalSizeClass == .compact
        {
            print("寬度：Compact")
        }
        else if newCollection.horizontalSizeClass == .regular
        {
            print("寬度：Regular")
        }
        
        // 如果裝置的高度(verticalSizeClass)為特定模式時
        if newCollection.verticalSizeClass == .compact
        {
            print("高度：Compact")
        }
        else if newCollection.verticalSizeClass == .regular
        {
            print("高度：Regular")
        }
        
        
    }
    //
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator)
    {
        super.viewWillTransition(to: size, with: coordinator)
        print("viewWillTransition to size!!!")
//        switch UIDevice.current.orientation
//        {
//            case .faceDown:
//                print("裝置朝下")
//                // 更換圖片
//                self.imgPicture.image = UIImage(named: "portrait")
//            case .faceUp:
//                print("裝置朝上")
//            // 更換圖片
//            self.imgPicture.image = UIImage(named: "portrait")
//            case .landscapeLeft:
//                print("裝置向左")
//            // 更換圖片
//            self.imgPicture.image = UIImage(named: "landscape")
//            case .landscapeRight:
//                print("裝置向右")
//            // 更換圖片
//            self.imgPicture.image = UIImage(named: "landscape")
//            case .portrait:
//                print("裝置直立")
//            // 更換圖片
//            self.imgPicture.image = UIImage(named: "landscape")
//            case .portraitUpsideDown:
//                print("裝置上下顛倒")
//            default:
//                print("未知裝置")
//
//        }
        
        print("解析度為：\(size.width) x \(size.height)")
        // 執行伴隨旋轉產生的動畫
        coordinator.animate(alongsideTransition: { (context) in
           // 按一下「執行動畫按鈕」
            self.doAnimate()
        }, completion: nil)
    }

}

