

import UIKit

class ViewController: UIViewController
{
    //TODO: 縮放
    @IBOutlet weak var imgShore: UIImageView!
    
    // 記錄每次矩陣轉換後的狀態
    var transformIdentity = CGAffineTransform.identity
    
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
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(gesturePinchInView(_:)))
        imgShore.addGestureRecognizer(pinchGesture)
    }


}

