

import UIKit

class ViewController: UIViewController
{
    //TODO: 縮放
    @IBOutlet weak var imgShore: MoveableImageView!
    
    // 記錄每次矩陣轉換後的狀態
    var transformIdentity = CGAffineTransform.identity
    // 記錄每次觸碰的起點與終點
    var touchStartPosition = CGPoint.zero
    var touchEndPosition = CGPoint.zero
    // 小星星圖示
    @IBOutlet weak var imgStar: UIImageView!
    
    
    
    
    
    
    
     // 在底面上操作的旋轉手勢
    @objc func gestureRotationInView(_ sender: UIRotationGestureRecognizer)
    {
        print("旋轉手勢的弧度：\(sender.rotation)")
        
        switch sender.state
        {
        case .began:
            // 記錄上一次layerApple圖層最後的矩陣轉換狀態
            transformIdentity = imgShore.layer.affineTransform()
        case .changed, .ended:
            // 取得以上一次layerApple圖層旋轉過後的矩陣，再繼續往下旋轉的新矩陣
            let transform = transformIdentity.rotated(by: sender.rotation)
            // 將旋轉過後的新矩陣，設定給圖層來執行旋轉
            imgShore.layer.setAffineTransform(transform)
        default:
            break
        }
    }
    // 在底面上操作的縮放手勢
    @objc func gesturePinchInView(_ sender: UIPinchGestureRecognizer)
    {
        print("縮放手勢的值:\(sender.scale)")
        switch sender.state
        {
        case .began:
            // 記錄上一次layerApple圖層最後的矩陣轉換狀態
            transformIdentity = imgShore.layer.affineTransform()
        case .changed, .ended:
            // 取得以上一次layerApple圖層縮放過後的矩陣，再繼續往下縮放的新矩陣
            let transform = transformIdentity.scaledBy(x: sender.scale, y: sender.scale)
            // 將縮放過後的新矩陣，設定給圖層來執行縮放
            imgShore.layer.setAffineTransform(transform)
        default:
            break
        }
    }
    
    
    
    
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // 允許圖片與使用者互動(即接受手勢)
        imgShore.isUserInteractionEnabled = true
        // 將旋轉手勢加在圖片上
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(gestureRotationInView(_:)))
        imgShore.addGestureRecognizer(rotationGesture)
        // 將縮放手勢加在圖片上
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(gesturePinchInView(_:)))
        imgShore.addGestureRecognizer(pinchGesture)
        // 允許底面與使用者互動(預設狀態)
        self.view.isUserInteractionEnabled = true
        self.view.isMultipleTouchEnabled = true// 允許同時感應多根手指觸碰
        // 預設先看不到小星星
        self.imgStar.alpha = 0
    }
    //MARK: - Touch Event
    //觸碰開始
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        super.touchesBegan(touches, with: event)
        print("觸碰開始，共有\(touches.count)根手指觸碰！")
        
        for aFinger in touches
        {
            print("觸碰開始的手指位置：\(aFinger.location(in: self.view))")
        }
        //記錄其中一根手指的觸碰位置
        touchStartPosition = touches.first!.location(in: self.view)
        // 計算觸碰原點和圖片中心點之間的座標差值(x為圖片寬度的一半，x為圖片高度的一半
        let diffPosition = CGPoint(x: touchStartPosition.x - (imgStar.bounds.width / 2), y: touchStartPosition.y - (imgStar.bounds.height / 2))
        // 讓小星星移動到點擊位置
        imgStar.frame.origin = diffPosition
    }
    //觸碰中移動
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        super.touchesMoved(touches, with: event)
        for aFinger in touches
        {
            print("移動中的手指位置：\(aFinger.location(in: self.view))")
        }
        //記錄其中一根手指的觸碰結束位置
        touchEndPosition = touches.first!.location(in: self.view)
        
        
    }
    //觸碰結束
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        super.touchesEnded(touches, with: event)
        for aFinger in touches
        {
            print("觸碰結束的手指位置：\(aFinger.location(in: self.view))")
        }
        //記錄其中一根手指的觸碰結束位置
        touchEndPosition = touches.first!.location(in: self.view)
        
        UIView.animate(withDuration: 0.25, animations: {
            // 第一階段動畫：顯示小星星
            self.imgStar.alpha = 1
        }) { (finished) in
            // 第二段動畫：隱藏小星星
            UIView.animate(withDuration: 0.25) {
                self.imgStar.alpha = 0
            }
        }
    }

}

