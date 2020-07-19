import UIKit
//定義單筆學生資料的結構
struct Student
{
    var no = ""
    var name = ""
    var gender = 0
    var picture:Data?
    var phone = ""
    var address = ""
    var email = ""
    var myclass = ""
}
/*
 自訂儲存格處理：
 Step1.設定Label標題的限制條件（固定在儲存格左側）
 1.以stack view裝載『學號：』、『姓名：』、『性別：』
 2.stack view 屬性設定～Aligment:Fill，Distribution:Full Equallly，Spacing:10pt
 3.設定stack view的上下左邊的限制條件為10pt
 
 Step2.設定Label資料內容的限制條件（固定在Label標題之右側）
 1.以stack view裝載『學號：』資料、『姓名：』資料、『性別：』資料的標籤
 2.stack view 屬性設定～Aligment:Fill，Distribution:Full Equallly，Spacing:10pt
 3.設定stack view的上下左邊的限制條件為10pt
 
 Step3.設定大頭照的限制條件（固定在儲存格右側）
 1.寬與高為100pt
 2.上邊右邊的限制條件為10pt
 */

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

class MyTableViewController: UITableViewController
{
//    var list = ["爬山","滑雪","打球"]
    //紀錄單一資料行
    var structRow = Student()
    //查詢到的資料表所存放的陣列（用於離線資料集）
    var arrTable = [Student]()
    //目前被點選的資料行
    var currentRow = 0
    
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
        let addVC = self.storyboard!.instantiateViewController(identifier: "AddViewController") as! AddViewController
        self.show(addVC, sender: nil)
    }
    
    //MARK: - View Life Cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
        // 測試用假資料
        arrTable = [
            Student(no: "S101", name: "王大富", gender: 1, picture: UIImage(named: "DefaultPhoto.jpg")!.jpegData(compressionQuality: 0.8), phone: "0988123456", address: "台北市大安區新生北路一段121號", email: "abc@xyz.com", myclass: "手機程式設計"),
            Student(no: "S102", name: "李小英", gender: 0, picture: UIImage(named: "DefaultPhoto.jpg")!.jpegData(compressionQuality: 0.8), phone: "0988123456", address: "台北市大安區新生北路一段121號", email: "abc@xyz.com", myclass: "網頁程式設計"),
            Student(no: "S103", name: "吳天勝", gender: 1, picture: UIImage(named: "DefaultPhoto.jpg")!.jpegData(compressionQuality: 0.8), phone: "0988123456", address: "台北市大安區新生北路一段121號", email: "abc@xyz.com", myclass: "智能裝置開發"),
            Student(no: "S104", name: "邱大同", gender: 1, picture: UIImage(named: "DefaultPhoto.jpg")!.jpegData(compressionQuality: 0.8), phone: "0988123456", address: "台北市大安區新生北路一段121號", email: "abc@xyz.com", myclass: "手機程式設計"),
            Student(no: "S105", name: "田勝雄", gender: 1, picture: UIImage(named: "DefaultPhoto.jpg")!.jpegData(compressionQuality: 0.8), phone: "0988123456", address: "台北市大安區新生北路一段121號", email: "abc@xyz.com", myclass: "智能裝置開發"),
        ]
        
        //設定導覽列標題
        self.navigationItem.title = "我的資料庫"
        //設定導覽列左側按鈕
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "編輯", style: .plain, target: self, action: #selector(buttonEditAction))
        //設定導覽列右側按鈕
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "新增", style: .plain, target: self, action: #selector(buttonAddAction))
        //設定導覽列底圖
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "title.jpg"), for: .default)
        
    }
    // 即將由換頁線換頁時
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)
        //由換頁線取得下一頁
        let detailVC = segue.destination as! DetailViewController
        // 將本頁的執行實體通知下一頁
        detailVC.myTableViewController = self
        print("即將由換頁線換頁")
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        print("畫面重現：\(arrTable[currentRow])")
        // 重整表格（重新執行Table view data source代理事件）
        self.tableView.reloadData()
    }

    // MARK: - Table view data source
    //表格有幾段(表格外迴圈的數量) 即indexPath的section數量
    override func numberOfSections(in tableView: UITableView) -> Int
    {
//        super.numberOfSections(in: tableView)
        return 1        //表格不分段，只有一段
    }
    //表格的每一段要有幾個儲存格（表格內迴圈的數量）
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //如果表格有分段時
//        if section == 0
//        {
//            return 2
//        }
//        else if section == 1
//        {
//            return 3
//        }
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
        if structRow.gender == 0
        {
            cell.lblGender.text = "女"
        }
        else
        {
            cell.lblGender.text = "男"
        }
        //確認有圖片時，才呈現圖片
        if let aPicture = structRow.picture
        {
            cell.imgPicture.image = UIImage(data: aPicture)
//            //<方法一>取大頭照圓角
//            cell.imgPicture.clipsToBounds = true
//            cell.imgPicture.contentMode = .scaleAspectFill
//            cell.imgPicture.layer.cornerRadius = cell.imgPicture.bounds.size.width / 2
        }
        
        
        
        
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
        print(arrTable[indexPath.row])
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
    
    
        //不允許使用者操作表格資料的刪除功能
    //    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle
    //    {
    //        return .none
    //    }
        
        // Override to support conditional editing of the table view.
    //    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    //    {
    //        // Return false if you do not want the specified item to be editable.
    //        return true
    //    }
    

}
