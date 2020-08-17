import UIKit

class AddViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate,URLSessionTaskDelegate
{
    //紀錄上一頁的表格控制器實體
    weak var myTableViewController:MyTableViewController!
    //紀錄目前輸入元件的Y軸底緣位置
    var currentObjectBottomYPosition:CGFloat = 0
    
    @IBOutlet weak var txtNo: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var imgPicture: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtClass: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    //輸入性別或班別時推入的滾輪元件
    var pkvGender:UIPickerView!
    var pkvClass:UIPickerView!
    //提供性別及班別滾輪的資料來源
    let arrGender = ["女","男"]
    let arrClass = ["手機程式設計","網頁程式設計","智能裝置開發"]
    //--------------------MySQL增加-------------------
    // 記錄主要網域名稱（網址開頭的部分）
    let webDomain = "http://192.168.62.9/MyDataBase/"
    // 記錄目前處理中的網路服務（web service），指網址結尾的部分
    var strURL = ""
    // 記錄目前處理中網址物件（由網址的開頭部分+網址結尾部份）
    var url:URL!
    // 取得預設的網路串流物件
    var session:URLSession!
    // 宣告網路傳輸任務
    var dataTask:URLSessionDataTask!
    // 判斷大頭照是否已經上傳到伺服器（預設大頭照已上傳）
    var isFileUploaded = true
    //------------------------------------------------
    //MARK: - 自訂函式
    //檔案上傳封裝方法(第一個參數：已選定的圖片，第二個參數：處理上傳檔案的photo_upload.php，第三個參數：提交檔案的input file id，第四個參數：存放到伺服器端的檔名)
     func FileUpload(_ image:UIImage,withURLString urlString:String,byFormInputID idName:String,andNewFileName newFileName:String)
     {
         //轉換圖檔成為Data(壓縮jpg)
         let imageData = image.jpegData(compressionQuality: 0.8)!
         //準備URLRequest
         let request = NSMutableURLRequest()     //注意不能寫成：var request = NSURLRequest()
         //從參數取得上傳檔案的網址
         request.url = URL(string: urlString)
         request.httpMethod = "POST"
         
         //產生boundary識別碼來界定要傳送的資料
         let boundary = ProcessInfo.processInfo.globallyUniqueString
         // set Content-Type in HTTP header
         let contentType = "multipart/form-data; boundary=" + boundary
         request.addValue(contentType, forHTTPHeaderField: "Content-Type")
         
         //準備Post Body
         let body = NSMutableData()
         
         //以boundary識別碼來製作分隔界線（開始）
         let boundaryStart = String(format: "\r\n--%@\r\n", boundary)
         //Post Body加入分隔界線（開始）
         body.append(boundaryStart.data(using: .utf8)!)
         
         //加入Form
         let formData = String(format: "Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", idName, newFileName)    //此行的userfile需對應到接收上傳的php內變數名稱，newFileName為上傳後存檔的名稱
         //Post Body加入Form
         body.append(formData.data(using: .utf8)!)
         
         //檔案型態
         let fileType = String(format: "Content-Type: application/octet-stream\r\n\r\n")
         body.append(fileType.data(using: .utf8)!)
         
         //加入圖檔
         body.append(imageData)
         
         //以boundary識別碼來製作分隔界線（結束）
         let boundaryEnd = String(format: "\r\n--%@--\r\n", boundary)
         //Post Body加入分隔界線（結束）
         body.append(boundaryEnd.data(using: .utf8)!)
         
         //把Post Body交給URL Reqeust
         request.httpBody = body as Data
         
         //設定上傳任務
         let uploadTask = session.uploadTask(with: request as URLRequest, from: nil) {
            (echoData, response, error)
            in
             //取得伺服器上傳檔案的回應訊息
             let strEchoMessage = String(data: echoData!, encoding: .utf8)
             if strEchoMessage == "success"
             {
                 //標示檔案已上傳
                 self.isFileUploaded = true
             }
         }
         //執行檔案上傳任務
         uploadTask.resume()
     }
    //MARK: - Target Action
    //文字輸入框開始編輯事件
    @IBAction func editDidBegin(_ sender: UITextField)
    {
        print("開始編輯")
        //個別指定鍵盤樣式
        switch sender.tag
        {
            case 3:  //電話
                sender.keyboardType = .phonePad
            case 6:  //Email
                sender.keyboardType = .emailAddress
            default:
                sender.keyboardType = .default
        }
        //計算輸入元件的Y軸底緣位置
        currentObjectBottomYPosition = sender.frame.origin.y + sender.frame.size.height
    }
    
    //每個會叫出鍵盤的文字輸入框，當對應到Did End On Exit事件後，按下Return鍵才會收起鍵盤
    @IBAction func didEndOnExit(_ sender: UITextField)
    {
        //此事件只需對應，不需實作即可按下Return鍵收起鍵盤！
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
            //計算扣除鍵盤後的可視高度
            let visibleHeight = self.view.bounds.size.height - keyboardHeight
            //如果『Y軸底緣位置』比『可視高度』還高，表示元件被鍵盤遮住
            if currentObjectBottomYPosition > visibleHeight
            {
                //移動『Y軸底緣位置』與『可視高度』之間的差值（即被遮住的範圍高度，再少10點）
                self.view.frame.origin.y -= currentObjectBottomYPosition - visibleHeight + 10
            }
        }
    }
    //由通知中心呼叫的鍵盤收合事件
    @objc func keyboardWillHide()
    {
        print("鍵盤收合！")
        //將畫面移回原來的位置
        self.view.frame.origin.y = 0
    }
    
    //拍照按鈕
    @IBAction func btncamera(_ sender: UIButton)
    {
        if !UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            print("此裝置沒有相機")
            return      //直接離開函式
        }
        //初始化影像挑選控制器
        let imagePicker = UIImagePickerController()
        //設定影像挑選控制器為相機
        imagePicker.sourceType = .camera
        //允許編輯相片
        imagePicker.allowsEditing = true
        //設定相機相關的代理事件實作在此類別
        imagePicker.delegate = self
        //開啟相機
        self.show(imagePicker, sender: nil)
        // 標示檔案未上傳
        isFileUploaded = false
    }
    //相簿按鈕
    @IBAction func btnPhotoAlbum(_ sender: UIButton)
    {
        if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        {
            print("此裝置沒有相簿")
            return      //直接離開函式
        }
        //初始化影像挑選控制器
        let imagePicker = UIImagePickerController()
        //設定影像挑選控制器為相簿
        imagePicker.sourceType = .photoLibrary
        //允許編輯相片
        imagePicker.allowsEditing = true
        //設定相機相關的代理事件實作在此類別
        imagePicker.delegate = self
        //開啟相簿
        self.show(imagePicker, sender: nil)
        // 標示檔案未上傳
        isFileUploaded = false
    }
    //上傳照片按鈕
    @IBAction func btnFileUpload(_ sender: UIButton!)
    {
        
        if imgPicture == nil
        {
            //製作訊息視窗
            let alert = UIAlertController(title: "檔案上傳錯誤", message: "沒有選定大頭照無法上傳", preferredStyle: .alert)
            //初始化訊息視窗準備使用的按鈕
            let btnOK = UIAlertAction(title: "確定", style: .destructive, handler: nil)
            //將按鈕加入訊息視窗
            alert.addAction(btnOK)
            //顯示訊息視窗
            self.present(alert, animated: true, completion: nil)
            //離開函式
            return
        }
        //顯示上傳進度條
        progressView.progress = 0
        progressView.isHidden = false
        //準備即將上傳的檔名
        let serverFileName = String(format: "%@.jpg", txtNo.text!)
        //執行「檔案上傳封裝方法」上傳大頭照
        FileUpload(imgPicture.image!, withURLString: webDomain+"photo_upload.php", byFormInputID: "userfile", andNewFileName: serverFileName)
        
        
        //利用檔案管理員刪除以下下載的暫存檔案
        let fileManage = FileManager()
        try? fileManage.removeItem(atPath: NSHomeDirectory() + "/Library/Caches")
    }
    //新增資料按鈕
    @IBAction func btnInsert(_ sender: UIButton)
    {
        //Step0.比對介面資料是否合法
        if txtNo.text!.isEmpty || txtName.text!.isEmpty || imgPicture.image == nil || txtPhone.text!.isEmpty || txtAddress.text!.isEmpty || txtEmail.text!.isEmpty
        {
            //製作訊息視窗
            let alert = UIAlertController(title: "資料輸入錯誤", message: "任何一個欄位都不可空白", preferredStyle: .alert)
            //初始化訊息視窗準備使用的按鈕
            let btnOK = UIAlertAction(title: "確定", style: .default, handler: nil)
            //將按鈕加入訊息視窗
            alert.addAction(btnOK)
            //顯示訊息視窗
            self.present(alert, animated: true, completion: nil)
            //離開函式
            return
        }
        
        txtClass.text = arrClass[pkvClass.selectedRow(inComponent: 0)]
        //Step1.如果檔案未上傳
        if !isFileUploaded
        {
            // 按一下檔案上傳按鈕
            self.btnFileUpload(nil)
        }
        //Step2.更新資料庫資料
        //http://192.168.62.9/MyDataBase/insert_data.php?no=Q345&name=康百世&gender=1&picture=images/Q345.jpg&phone=09333e34&address=台北市中山北路一段109號&email=ters@dfjd&myclass=智能裝置開發
        //Step2-1.以中文編碼成即將呼叫的網址
        let strOriginalURL = String(format: webDomain + "insert_data.php?no=%@&name=%@&gender=%d&picture=images/%@.jpg&phone=%@&address=%@&email=%@&myclass=%@", txtNo.text!, txtName.text!, pkvGender.selectedRow(inComponent: 0), txtNo.text!, txtPhone.text!, txtAddress.text!, txtEmail.text!, txtClass.text!)
        print("中文未編碼的網址：\(strOriginalURL)")
        
        //Step2-2.將網址的中文部分進行百分比編碼
        strURL = strOriginalURL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        print("中文百分比編碼後的網址：\(strURL)")
        //Step2-3.以編碼過後的網址來初始化URL實體
        url = URL(string: strURL)
        //Step2-4.準備更新任務
        dataTask = session.dataTask(with: url, completionHandler: {
            (echoData, response, error)
            in
            //取得伺服器更新的回應訊息
            let strEchoMessage = String(data: echoData!, encoding: .utf8)
            if strEchoMessage == "1"
            {
                DispatchQueue.main.async {
                    //製作訊息視窗
                    let alert = UIAlertController(title: "資料處理訊息", message: "資料新增成功！", preferredStyle: .alert)
                    //初始化訊息視窗準備使用的按鈕
                    let btnOK = UIAlertAction(title: "確定", style: .default, handler: nil)
                    //將按鈕加入訊息視窗
                    alert.addAction(btnOK)
                    //顯示訊息視窗
                    self.present(alert, animated: true, completion: nil)
                }
                
            }
            else
            {
                DispatchQueue.main.async {
                    //製作訊息視窗
                    let alert = UIAlertController(title: "資料處理訊息", message: "資料新增失敗！", preferredStyle: .alert)
                    //初始化訊息視窗準備使用的按鈕
                    let btnOK = UIAlertAction(title: "確定", style: .destructive, handler: nil)
                    //將按鈕加入訊息視窗
                    alert.addAction(btnOK)
                    //顯示訊息視窗
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
        })
        //Step2-5.執行更新
        dataTask.resume()
        
        //Step3.回寫上一頁的陣列資料(picture欄位未處理)
        let newRow =
            Student(no: txtNo.text!.uppercased(), name: txtName.text!, gender: String(pkvGender.selectedRow(inComponent: 0)), picture: "images/\(txtNo.text!).jpg", phone: txtPhone.text!, address: txtAddress.text!, email: txtEmail.text!, myclass: txtClass.text!)
        myTableViewController.arrTable.append(newRow)
        
        //Step3.執行陣列排序(以學號由小到大排序)
        myTableViewController.arrTable.sort {
            (student1, student2) -> Bool
            in
            return student1.no < student2.no
        }
        //製作訊息視窗
        let alert = UIAlertController(title: "資料處理訊息", message: "資料新增成功！", preferredStyle: .alert)
        //初始化訊息視窗準備使用的按鈕
        let btnOK = UIAlertAction(title: "確定", style: .default, handler: nil)
        //將按鈕加入訊息視窗
        alert.addAction(btnOK)
        //顯示訊息視窗
        self.present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - View Life Cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //先隱藏進度條
        self.progressView.isHidden = true
        //取得系統目前預設的通知中心實體
        let notificationCenter = NotificationCenter.default
        //向通知中心註冊鍵盤彈出通知
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        //向通知中心註冊鍵盤收合通知
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        //建立性別滾輪（注意：tag值對應原textfield的tag值）
        pkvGender = UIPickerView()
        pkvGender.tag = 2
        //建立班別滾輪（注意：tag值對應原textfield的tag值）
        pkvClass = UIPickerView()
        pkvClass.tag = 4
        //指派此類別實作滾輪的資料來源與相關代理事件
        pkvGender.dataSource = self
        pkvGender.delegate = self
        pkvClass.dataSource = self
        pkvClass.delegate = self
        
        //將性別滾輪與班別滾輪替換原先預設的虛擬鍵盤
        txtGender.inputView = pkvGender
        txtClass.inputView = pkvClass
        //-------------------MySQL增加-------------------------------
        // URLSessionDelegate
        session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        //----------------------------------------------------------
    }
    
     //MARK: - UIImagePickerControllerDelegate
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
        {
            print("影像資訊：\(info)")
            
    //        if let image = info[.originalImage] as? UIImage
            if let image = info[.editedImage] as? UIImage
            {
                //將拍照結果顯示在大頭照位置
                imgPicture.image = image
                //退掉相機畫面
                picker.dismiss(animated: true, completion: nil)
            }
            
        }
    
    //MARK: - Touch Event
    //觸碰開始
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        //收起任何啟用中鍵盤
        self.view.endEditing(true)
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
        if pickerView.tag == 2  //提供性別滾輪的數量
        {
            return arrGender.count
        }
        else if pickerView.tag == 4  //提供班別滾輪的數量
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
            case 2:      //提供性別的文字
                return arrGender[row]
            default:     //提供班別的文字
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
