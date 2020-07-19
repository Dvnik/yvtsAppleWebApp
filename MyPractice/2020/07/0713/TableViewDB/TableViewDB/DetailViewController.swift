

import UIKit

class DetailViewController: UIViewController
{
    // 紀錄上一頁的表格控制器實體
    weak var myTableViewController:MyTableViewController!
    
    //紀錄目前資料
    var currentData = Student()
    //紀錄目前輸入元件的Y軸底緣位置
    var currentObjectBottomYPosition:CGFloat = 0
    
    @IBOutlet weak var lblNo: UILabel!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var imgPicture: UIImageView!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtClass: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    // MARK: - Target Action
    // 文字輸入匡開始編輯事件
    @IBAction func editingDidBegin(_ sender: UITextField)
    {
        print("開始編輯")
        // 個別指定鍵盤樣式
        switch sender.tag
        {
            case 3:// 電話
                sender.keyboardType = .phonePad
            case 6:
                sender.keyboardType = .emailAddress
            default:
                sender.keyboardType = .default
        }
        
        // 計算輸入元件的Y軸底緣位置
        currentObjectBottomYPosition = sender.frame.origin.y + sender.frame.size.height
    }
    
    
    
    //每個會叫出鍵盤的文字輸入匡，當對應到Did End On Exit事件後，按下Return鍵才會收起鍵盤
    @IBAction func didEndOnExit(_ sender: UITextField)
    {
        // 此事件只需對應，不需實作即可按下Return鍵才會收起鍵盤
//        print("按下Return鍵")
    }
    
    //由通知中心呼叫的鍵盤彈出事件
    @objc func keyboardWillShow(_ sender:Notification)
    {
        print("鍵盤彈出！")
        print("通知資訊：\(sender)")
        
        if let keyboardHeight = (sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height
        {
            print("鍵盤高度：\(keyboardHeight)")
            // 計算扣除鍵盤後的可視高度
            let visibleHeight = self.view.bounds.size.height - keyboardHeight
            // 如果「Y軸底緣位置」比「可視高度」還高，表示元件被鍵盤遮住
            if currentObjectBottomYPosition > visibleHeight
            {
                // 移動「Y軸底緣位置」與「可視高度」之間的差值(即被遮住的範圍高度，再少10點)
                self.view.frame.origin.y -= currentObjectBottomYPosition - visibleHeight + 10
                
            }
        }
    }
    
    @objc func keyboardWillHide()
    {
        print("鍵盤收合！")
        // 將畫面移回原來的位置
        self.view.frame.origin.y = 0
    }
    
    // 拍照按鈕
    @IBAction func btncamera(_ sender: UIButton)
    {
        
    }
    // 相簿按鈕
    @IBAction func btnPhotoAlbum(_ sender: UIButton)
    {
        
    }
    // 導航到地址
    @IBAction func btnNaviToAddress(_ sender: UIButton)
    {
        
    }
    //修改資料
    @IBAction func btnUpdate(_ sender: UIButton)
    {
        
        
        //回寫上一頁的陣列資料
        myTableViewController.arrTable[myTableViewController.currentRow] = Student(no: lblNo.text!, name: txtName.text!, gender: 0, picture: imgPicture.image?.jpegData(compressionQuality: 0.8), phone: txtPhone.text!, address: txtAddress.text!, email: txtEmail.text!, myclass: txtClass.text!)
        
        print("修改過後的當筆資料：\(myTableViewController.arrTable[myTableViewController.currentRow])")
    }
    // MARK: - View Life Cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()

        //取得系統目前預設的通知中心實體
        let notificationCenter = NotificationCenter.default
        // 向通知中心註冊鍵盤彈出通知
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        // 向通知中心註冊鍵盤收合通知
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        print("本頁資料：\(myTableViewController.arrTable[myTableViewController.currentRow])")
        // 取得目前資料
        currentData = myTableViewController.arrTable[myTableViewController.currentRow]
        
        lblNo.text = currentData.no
        txtName.text = currentData.name
        if currentData.gender == 0
        {
            txtGender.text = "女"
        }
        else
        {
            txtGender.text = "男"
        }
        
        
        if let aPicture = currentData.picture
        {
            imgPicture.image = UIImage.init(data: aPicture)
        }
        
        txtPhone.text = currentData.phone
        txtClass.text = currentData.myclass
        txtAddress.text = currentData.address
        
        txtEmail.text = currentData.email
    }
    //觸碰開始
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        //收起任何啟用中鍵盤
        self.view.endEditing(true)
    }


}
