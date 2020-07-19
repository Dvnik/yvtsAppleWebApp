

import UIKit

class MoveableImageView: UIImageView
{

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        super.touchesMoved(touches, with: event)
        
        if let touch = touches.first
        {
            //計算x軸移動前後的差值
            let deltaX = touch.location(in: self).x - touch.previousLocation(in: self).x
            //計算y軸移動前後的差值
            let deltaY = touch.location(in: self).y - touch.previousLocation(in: self).y
            // 以xy的差值來進行矩陣位置轉換
            self.transform = self.transform.translatedBy(x: deltaX, y: deltaY)
        }
    }
}
