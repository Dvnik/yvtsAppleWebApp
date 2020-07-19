

import UIKit

class ViewController: UIViewController
{
    
    @IBOutlet weak var imgPicture: UIImageView!
    
    
    var deviceWidth:CGFloat?
    var deviceHeight:CGFloat?

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
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
        // 更換圖片
        self.imgPicture.image = UIImage(named: "landsacpe")
    }
    
    // 當畫面完成佈置時
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        
        // 更動位置必須在完成限制條件的配置之後
        self.imgPicture.frame = CGRect(x: 60, y: 60, width: 250, height: 250)
    }

}

