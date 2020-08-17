import UIKit
//定義單筆學生資料的結構(結構引入Codable協定，為了對應JSon的Key值)
struct Student:Codable
{
    var no = ""
    var name = ""
    var gender = "0"
    var picture = "" // 圖片僅記錄相對路徑
    var phone = ""
    var address = ""
    var email = ""
    var myclass = ""
}

/*
自訂儲存格處理：
Step1.設定大頭照的限制條件（固定在儲存格左側）
1.寬與高為100pt
2.上下左邊的限制條件為10pt
 
Step2.設定Label標題的限制條件（固定在大頭照右側）
1.以stack view裝載『學號：』、『姓名：』、『性別：』標籤
2.stack view屬性設定～Alignment：Fill，Distribution：Fill Equally，Spacing：10pt
3.設定stack view的高度與大頭照高度相等（決定高度，寬度自動）
4.設定stack view左側與大頭照距離10pt（決定x軸位置）
5.設定stack view的上緣對齊大頭照上緣（決定y軸位置）
 
Step3.設定Label資料內容的限制條件（固定在Label標題之右側）
1.以stack view裝載『學號』資料、『姓名』資料、『性別』資料的標籤
2.stack view屬性設定～Alignment：Fill，Distribution：Fill Equally，Spacing：10pt
3.設定stack view的高度與前一個stack view高度相等（決定高度，寬度自動）
4.設定stack view左側與前一個stack view距離10pt（決定x軸位置）
5.設定stack view與前一個stack view的上緣對齊（決定y軸位置）
*/

class MyTableViewController: UITableViewController, XMLParserDelegate
{
    //http://172.16.100.191/MyDataBase/select_data.php
    //--------------------MySQL增加-------------------
    // 記錄主要網域名稱（網址開頭的部分）
    let webDomain = "http://192.168.62.9/MyDataBase/"
    // 記錄目前處理中的網路服務（web service），指網址結尾的部分
    var strURL = ""
    // 記錄目前處理中網址物件（由網址的開頭部分+網址結尾部份）
    var url:URL!
    // 取得預設的網路串流物件
    let session = URLSession.shared
    // 宣告網路傳輸任務
    var dataTask:URLSessionDataTask!
    
    // 以下為處理XML解析所需的屬性
    // 記錄目前正在處理的XML標籤名稱（讀到XML開始標籤時填入）
    var tagName = ""
    // 記錄目前正在處理的XML標籤內容
    var tagContent = ""
    //-----------------------------------------------
    //紀錄單一資料行
    var structRow = Student()
    //查詢到的資料表所存放的陣列（用於離線資料集）
    var arrTable = [Student]()
    //目前被點選的資料行
    var currentRow = 0
    
    //MARK: - 自訂函式
    //從網路服務取得MySQL資料(XML)
    func getDataFromXML()
    {
        //指定提供XML網路服務的網址
        strURL = "select_data.php"
        //將主網域名稱串接XML網路服務的完整網址，形成URL實體
        url = URL(string: webDomain + strURL)
        //由網路串流物件來"準備"資料傳輸任務
        dataTask = session.dataTask(with: url, completionHandler: {
            (xmlData, reponse, error)
            in
            //當url存取成功時
            if error == nil
            {
                if let xml = xmlData
                {
                    print("XML資料：\(String(data: xml, encoding: .utf8)!)")
                    //先清空離線資料集
                    self.arrTable.removeAll()
                    //以XML資料來啟動XML解析器
                    let xmlParser = XMLParser(data: xml)
                    //指定XML解析過程的代理事件實作在此類別
                    xmlParser.delegate = self
                    //開始解析XML文件（此時會開始觸發XMLParserDelegate相關的代理事件）
                    xmlParser.parse()
                }
                else
                {
                    print("沒拿到XML資料！！")
                }
            }
            else
            {
                // 提示使用者網路斷線
                //製作訊息視窗
                let alert = UIAlertController(title: "網路連線訊息", message: "目前網路不通！", preferredStyle: .alert)
                //初始化訊息視窗準備使用的按鈕
                let btnOK = UIAlertAction(title: "確定", style: .default, handler: nil)
                //將按鈕加入訊息視窗
                alert.addAction(btnOK)
                //顯示訊息視窗
                self.present(alert, animated: true, completion: nil)
            }
        })
        //"執行"傳輸任務
        dataTask.resume()
    }
    
    //從網路服務取得MySQL資料(JSon)
    func getDataFromJSON()
    {
        //指定提供JSon網路服務的網址
        strURL = "select_to_json.php"
        //將主網域名稱串接JSon網路服務的完整網址，形成URL實體
        url = URL(string: webDomain + strURL)
        //由網路串流物件來"準備"資料傳輸任務
        dataTask = session.dataTask(with: url, completionHandler: {
            (jsonData, reponse, error)
            in
            //當url存取成功時
            if error == nil
            {
                //初始化JSon解碼器
                let decoder = JSONDecoder()
                // 讓JSon解碼器開始解碼JSon資料到Student結構的陣列中
                if let jData = jsonData, let studentResults = try? decoder.decode([Student].self, from: jData)
                {
                    self.arrTable = studentResults
                    //轉回主要執行緒，重整表格資料
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                else
                {
                    print("沒有取得解碼過後的JSON資料")
                }
            }
            else
            {
                // 提示使用者網路斷線
                //製作訊息視窗
                let alert = UIAlertController(title: "網路連線訊息", message: "目前網路不通！", preferredStyle: .alert)
                //初始化訊息視窗準備使用的按鈕
                let btnOK = UIAlertAction(title: "確定", style: .default, handler: nil)
                //將按鈕加入訊息視窗
                alert.addAction(btnOK)
                //顯示訊息視窗
                self.present(alert, animated: true, completion: nil)
            }
        })
        //"執行"傳輸任務
        dataTask.resume()
    }
    
    //MARK: - Target Action
    //導覽列的編輯按鈕
    @objc func buttonEditAction()
    {
        print("編輯按鈕被按下！")
        if !self.tableView.isEditing  //如果表格不在編輯狀態
        {
            //讓表格進入編輯狀態
            self.tableView.isEditing = true
            //更換按鈕文字
            self.navigationItem.leftBarButtonItem?.title = "完成"
        }
        else
        {
            //讓表格回復到非編輯狀態
            self.tableView.isEditing = false
            //更換按鈕文字
            self.navigationItem.leftBarButtonItem?.title = "編輯"
        }
    }
    
    //導覽列的新增按鈕
    @objc func buttonAddAction()
    {
        print("新增按鈕被按下！")
        //從Storyboard上以ID取得頁面的實體
        let addVC = self.storyboard!.instantiateViewController(identifier: "AddViewController") as! AddViewController
        //通知新增畫面目前表格控制器的實體
        addVC.myTableViewController = self
        //顯示新增畫面
        self.show(addVC, sender: nil)
    }
    
    //表格下拉更新的觸發函式
    @objc func handelRefresh()
    {
        //Step1.重新讀取實際的資料庫資料
        getDataFromJSON()
        //Step2.重整表格（重新執行Table view data source代理事件）
        self.tableView.reloadData()
        
        //Step3.結束表格的下拉更新狀態
        self.tableView.refreshControl?.endRefreshing()
    }
    
    //MARK: - View Life Cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
//        //從XML網路服務取得資料
//        getDataFromXML()
        //從JSon網路服務取得資料
        getDataFromJSON()
        //設定導覽列標題
        self.navigationItem.title = NSLocalizedString("NaviagtionTitle", tableName: "InfoPlist", bundle: Bundle.main, value: "", comment: "")
        //設定導覽列左側按鈕
        let localizeEdit = NSLocalizedString("EditButtonTitle", tableName: "InfoPlist", bundle: Bundle.main, value: "", comment: "")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: localizeEdit, style: .plain, target: self, action: #selector(buttonEditAction))
        //設定導覽列右側按鈕
        let localizeAdd = NSLocalizedString("AddButtonTitle", tableName: "InfoPlist", bundle: Bundle.main, value: "", comment: "")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: localizeAdd, style: .plain, target: self, action: #selector(buttonAddAction))
        //設定導覽列底圖
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "title.jpg"), for: .default)
        //初始化表格的下拉更新元件
        self.tableView.refreshControl = UIRefreshControl()
        //設定下拉更新元件的對應事件
        self.tableView.refreshControl?.addTarget(self, action: #selector(handelRefresh), for: .valueChanged)
    }
    
    //即將由換頁線換頁時
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)
        print("即將由換頁線換頁")
        //由線換頁取得下一頁
        let detailVC = segue.destination as! DetailViewController
        //將本頁的執行實體通知下一頁
        detailVC.myTableViewController = self
    }
    //由下一頁回來時
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        //重整表格（重新執行Table view data source代理事件）
        self.tableView.reloadData()
    }

    // MARK: - Table view data source
    //表格有幾段(表格外迴圈的數量) 即indexPath的section數量
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1        //表格不分段，只有一段
    }
    //表格的每一段要有幾個儲存格（表格內迴圈的數量）
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //如果表格有分段時
        return arrTable.count
    }

    //準備每一個儲存的顯示內容
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //取得MyCell自訂儲存格的類別實體（注意轉型！）
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MyCell
        print("現在準備Section:\(indexPath.section)，Row:\(indexPath.row)")
        //注意：以下兩個屬性必須配合儲存格Style的設定才能正常顯示！
        //使用預設儲存格
//        cell.textLabel?.text = list[indexPath.row]
//        cell.detailTextLabel?.text = "資料：\(indexPath.row)"
        
        //取得對應的單筆資料
        structRow = arrTable[indexPath.row]
        //在儲存格上顯示相關欄位
        cell.lblNo.text = structRow.no
        cell.lblName.text = structRow.name
        if structRow.gender == "0"
        {
            cell.lblGender.text = "女"
        }
        else
        {
            cell.lblGender.text = "男"
        }
        //========================呈現大頭照=========================
        print("大頭照路徑：\(webDomain + structRow.picture)")
        // 初始化大頭照路徑url實體
        url = URL(string: webDomain + structRow.picture)
        // 準備大頭照的資料傳輸任務
        dataTask = session.dataTask(with: url, completionHandler: {
            (imgData, response, error)
            in
            if error == nil
            {
                if let aPicData = imgData
                {
                    //轉回主要執行緒顯示大頭照
                    DispatchQueue.main.async {
                        cell.imgPicture.image = UIImage(data: aPicData)
                    }
                }
            }
            else
            {
                // 提示使用者網路斷線
                //製作訊息視窗
                let alert = UIAlertController(title: "網路連線訊息", message: "目前網路不通，無法取得大頭照！", preferredStyle: .alert)
                //初始化訊息視窗準備使用的按鈕
                let btnOK = UIAlertAction(title: "確定", style: .default, handler: nil)
                //將按鈕加入訊息視窗
                alert.addAction(btnOK)
                //顯示訊息視窗
                self.present(alert, animated: true, completion: nil)
            }
        })
        // 執行下載大頭照的資料傳輸任務
        dataTask.resume()
        //========================================================
        //指定特定儲存格右側裝飾圖示
//        if indexPath.row == 1
//        {
//            cell.accessoryType = .detailButton
//        }
        return cell
    }

    //MARK: - Table view delegate
    //當特定儲存格被點選時
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        print("點選儲存格：\(arrTable[indexPath.row])")
        //紀錄被點選的儲存格位置
        currentRow = indexPath.row
    }
    
    //注意：實現儲存的移動功能，必須實作以下兩個代理方法
    //<代理方法1>設定儲存格可以被移動（此事件可以省略，因為預設值為true）
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }

    //<代理方法2>實際移動儲存格時
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath)
    {
        print("移動前：\(fromIndexPath)，移動後：\(to)")
        print("移動前的陣列：\(arrTable)")
        //<方法一>對調移動的來源儲存格與目的地儲存格
        arrTable.insert(arrTable.remove(at: fromIndexPath.row), at: to.row)
        
        /*
        //<方法二>為<方法一>的分階段執行
        //Step1.先記憶即將被移除的陣列元素（一開始的來源位置的元素），同時移除該元素
        let tmp = arrTable.remove(at: fromIndexPath.row)
        //Step2.再將已經移除的元素，往移動的目的地位置安插
        arrTable.insert(tmp, at: to.row)
        */
        
        print("移動後的陣列：\(arrTable)")
    }

    //注意：實作表格的編輯事件之後，表格可以滑動"刪除"
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
//        if editingStyle == .delete
//        {
            print("刪除前陣列：\(arrTable)")
            //Step1.先刪除表格對應的該筆陣列資料
            arrTable.remove(at: indexPath.row)
            //Step2.再刪除介面上的該筆儲存格
            tableView.deleteRows(at: [indexPath], with: .fade)
            print("刪除後陣列：\(arrTable)")
//        }
    }
    //更換刪除按鈕的文字
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?
    {
        return "不要了"
    }
    

    //設定儲存格向左滑動時，所提供的功能按鈕（注意：此事件會覆蓋以上兩個事件的行為 即以7-9來替代7-5）
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        //準備"更多"按鈕
        let actionMore = UIContextualAction(style: .normal, title: "更多") { (action, view, completionHanlder) in
            print("更多按鈕被按下")
        }
        actionMore.backgroundColor = .blue
        //準備"刪除"按鈕
        let actionDelete = UIContextualAction(style: .normal, title: "刪除") { (action, view, completionHanlder) in
            print("刪除前陣列：\(self.arrTable)")
            //Step1.先刪除表格對應的該筆陣列資料
            self.arrTable.remove(at: indexPath.row)
            //Step2.再刪除介面上的該筆儲存格
            tableView.deleteRows(at: [indexPath], with: .fade)
            print("刪除後陣列：\(self.arrTable)")
        }
        actionDelete.backgroundColor = .red
        //將兩個按鈕組合
        let config = UISwipeActionsConfiguration(actions: [actionDelete,actionMore])
        //允許滑動到底時，預設執行delete（即上述陣列的第一個元素）
        config.performsFirstActionWithFullSwipe = true
        //回傳按鈕組合
        return config
    }
    
    // MARK: - XMLParserDelegate
    // 讀到開始標籤時
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:])
    {
        print("讀到開始標籤：\(elementName)")
        tagName = elementName
    }
    //讀到標籤內容時
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        print("讀到標籤內容：\(string)")
        tagContent = string
    }
    // 讀到結束標籤時
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        print("讀到結束標籤：\(elementName)")
        switch elementName
        {
            case "student": // 當單筆資料結束時
                arrTable.append(structRow)
            case "no":
                structRow.no = tagContent
            case "name":
                structRow.name = tagContent
            case "gender":
                structRow.gender = tagContent
            case "picture":
                structRow.picture = tagContent
            case "phone":
                structRow.phone = tagContent
            case "address":
                structRow.address = tagContent
            case "email":
                structRow.email = tagContent
            case "class":
                structRow.myclass = tagContent
            default: // xmlTable的結束標籤
                break
        }
    }
    // 解析完整份XML文件時
    func parserDidEndDocument(_ parser: XMLParser)
    {
        print("解析完整份XML文件時")
        // 轉回主要執行緒執行表格資料更新
        let mainQueue = DispatchQueue.main
        mainQueue.async {
            self.tableView.reloadData()
        }
        
    }
}
