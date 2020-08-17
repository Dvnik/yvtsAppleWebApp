

import UIKit

class AddViewController:  UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate
{
    // 紀錄上一頁的表格控制器實體
    weak var myTableViewController:MyTableViewController!
    //紀錄目前輸入元件的Y軸底緣位置
    var currentObjectBottomYPosition:CGFloat = 0
    
    @IBOutlet weak var txtNo: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var imgPicture: UIImageView!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtClass: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    //輸入性別或班別時推入的滾輪元件
    var pkvGender:UIPickerView!
    var pkvClass:UIPickerView!
    //提供性別及班別滾輪的資料來源
    let arrGender = ["女", "男"]
    let arrClass = ["手機程式設計", "網頁程式設計", "智能裝置開發"]
    
    
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
        if !UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            print("此裝置沒有相機")
            return  // 直接離開函式
        }
        // 初始化影像挑選控制器
        let imagePicker = UIImagePickerController()
        // 設定影像挑選控制器為相機
        imagePicker.sourceType = .camera
        //允許編輯相片
        imagePicker.allowsEditing = true
        // 設定相機相關的代理事件實作在此類別
        imagePicker.delegate = self
        // 開啟相機
        self.show(imagePicker, sender: nil)
    }
    // 相簿按鈕
    @IBAction func btnPhotoAlbum(_ sender: UIButton)
    {
        if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        {
            print("此裝置沒有相簿")
            return  // 直接離開函式
        }
        // 初始化影像挑選控制器
        let imagePicker = UIImagePickerController()
        // 設定影像挑選控制器為相簿
        imagePicker.sourceType = .photoLibrary
        //允許編輯相片
        imagePicker.allowsEditing = true
        // 設定相機相關的代理事件實作在此類別
        imagePicker.delegate = self
        // 開啟相機
        self.show(imagePicker, sender: nil)
    }
    //新增資料按鈕
    @IBAction func btnInsert(_ sender: UIButton)
    {
        // Setp0.比對介面資料是否合法
        if txtNo.text!.isEmpty || txtName.text!.isEmpty || imgPicture.image == nil || txtPhone.text!.isEmpty || txtAddress.text!.isEmpty || txtEmail.text!.isEmpty
        {
            //製作訊息視窗
            let alert = UIAlertController(title: "資料輸入錯誤", message: "任何一個欄位都不可空白", preferredStyle: .alert)
            // 初始化訊息視窗準備使用的按鈕
            let btnOK = UIAlertAction(title: "確定", style: .default, handler: nil)
            // 將按鈕加入訊息視窗
            alert.addAction(btnOK)
            //顯示訊息視窗
            self.present(alert, animated: true, completion: nil)
            //離開函式
            return
        }
        txtClass.text = arrClass[pkvClass.selectedRow(inComponent: 0)]
        // Step1.更新資料庫資料
        //Todo:
        // Step2.回寫上一頁的陣列資料
        let newRow = Student(no: txtNo.text!, name: txtName.text!, gender: pkvGender.selectedRow(inComponent: 0), picture: imgPicture.image?.jpegData(compressionQuality: 0.8), phone: txtPhone.text!, address: txtAddress.text!, email: txtEmail.text!, myclass: txtClass.text!)
        myTableViewController.arrTable.append(newRow)
        // Step3.執行陣列排序(以學號由小到大排序)
        myTableViewController.arrTable.sort {
            (student1, student2) -> Bool
            in
            return student1.no < student2.no
        }

        //製作訊息視窗
        let alert = UIAlertController(title: "資料處理訊息", message: "資料新增成功", preferredStyle: .alert)
        // 初始化訊息視窗準備使用的按鈕
        let btnOK = UIAlertAction(title: "確定", style: .default, handler: nil)
        // 將按鈕加入訊息視窗
        alert.addAction(btnOK)
        //顯示訊息視窗
        self.present(alert, animated: true, completion: nil)
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
        //建立性別滾輪(注意：tag值對應原textfield的tag值)
        pkvGender = UIPickerView()
        pkvGender.tag = 2
        //建立班別滾輪(注意：tag值對應原textfield的tag值)
        pkvClass = UIPickerView()
        pkvClass.tag = 4
        //指派此類別實作滾輪的資料來源與相關代理事件
        pkvGender.dataSource = self
        pkvGender.delegate = self
        pkvClass.dataSource = self
        pkvGender.delegate = self
        //將性別滾輪與班別滾輪替換為原先預設的虛擬鍵盤
        txtGender.inputView = pkvGender
        txtClass.inputView = pkvClass
    }
    //MARK:- Touch Event
    //觸碰開始
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        //收起任何啟用中鍵盤
        self.view.endEditing(true)
    }
    //MARK: - UIImagePickerControllerDelegate
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
        {
            print("影像資訊:\(info)")
            
    //        if let image = info[.originalImage] as? UIImage
            if let image = info[.editedImage] as? UIImage
            {
                // 顯示拍照結果顯示在大頭照位置
                imgPicture.image = image
                //因為不會自動退掉畫面，要用手動退出
                //退掉相機畫面
                picker.dismiss(animated: true, completion: nil)
            }
        }
        
        //MARK: - UIPickerViewDataSource
        //滾輪有幾段(外迴圈數量)
        func numberOfComponents(in pickerView: UIPickerView) -> Int
        {
            return 1
        }
        //每一段滾輪有幾個選項(內迴圈數量)
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
        {
            if pickerView.tag == 2//提供性別滾輪的數量
            {
                return arrGender.count
            }
            else if pickerView.tag == 4//提供班別滾輪的數量
            {
                return arrClass.count
            }
            
            return 0
        }
        
        //MARK: - UIPickerViewDelegate
        //提供滾輪每一段每一行所呈現的文字
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
        {
            switch pickerView.tag
            {
                case 2:// 提供性別的文字
                    return arrGender[row]
                default:// 提供班別的文字
                    return arrClass[row]
                
            }
            
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
        {
            if pickerView.tag == 2
            {
                txtGender.text = arrGender[row]
            }
            else if pickerView.tag == 4
            {
                txtClass.text = arrClass[row]
            }
        }
}
