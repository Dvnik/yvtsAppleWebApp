

import UIKit

class MyCell: UITableViewCell
{
    
    @IBOutlet weak var lblNo: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var imgPicture: UIImageView!
    
    //當儲存格參考storyboard的畫面配置被初始化成功時
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        // <方法二>取大頭照圓角
        imgPicture.clipsToBounds = true
        imgPicture.contentMode = .scaleAspectFill
        imgPicture.layer.cornerRadius = imgPicture.bounds.size.width / 2
    }
    
    // 
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
