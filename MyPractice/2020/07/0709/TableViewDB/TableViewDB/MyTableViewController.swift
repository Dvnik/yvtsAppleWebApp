import UIKit
//定義單筆學生資料結構
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

class MyTableViewController: UITableViewController
{
    var list = ["爬山", "滑雪", "打球"]
    // 紀錄單一資料行
    var structRow = Student()
    // 查詢到的資料表所存放的陣列(用於離線資料集)
    var arrTable = [Student]()
    //目前被點選的資料行
    var currentRow = 0
    
    
    // 導覽列的編輯按鈕
    @objc func buttonEditAction()
    {
        print("編輯按鈕被按下！")
        if !self.tableView.isEditing
        {
            self.tableView.isEditing = true
            self.navigationItem.leftBarButtonItem?.title = "完成"
        }
        else
        {
            self.tableView.isEditing = false
            self.navigationItem.leftBarButtonItem?.title = "編輯"
        }
    }
    
    @objc func buttonAddAction()
    {
        print("新增按鈕被按下")
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
        //
        arrTable = [
            Student(no: "S101", name: "王大富", gender: 1, picture: UIImage(named: "DefaultPhoto.jpg")!.jpegData(compressionQuality: 0.8), phone: "0988123456", address: "台北市大安區新生北路一段121號", email: "abc@xyz.com", myclass: "手機程式設計"),
            Student(no: "S102", name: "李小英", gender: 0, picture: UIImage(named: "DefaultPhoto.jpg")!.jpegData(compressionQuality: 0.8), phone: "0988123456", address: "台北市大安區新生北路一段121號", email: "abc@xyz.com", myclass: "網頁程式設計"),
            Student(no: "S103", name: "吳天勝", gender: 1, picture: UIImage(named: "DefaultPhoto.jpg")!.jpegData(compressionQuality: 0.8), phone: "0988123456", address: "台北市大安區新生北路一段121號", email: "abc@xyz.com", myclass: "智能裝置開發"),
            Student(no: "S104", name: "邱大同", gender: 1, picture: UIImage(named: "DefaultPhoto.jpg")!.jpegData(compressionQuality: 0.8), phone: "0988123456", address: "台北市大安區新生北路一段121號", email: "abc@xyz.com", myclass: "手機程式設計"),
            Student(no: "S105", name: "田勝雄", gender: 1, picture: UIImage(named: "DefaultPhoto.jpg")!.jpegData(compressionQuality: 0.8), phone: "0988123456", address: "台北市大安區新生北路一段121號", email: "abc@xyz.com", myclass: "智能裝置開發"),
        ]
        //設定導覽列標題
        self.navigationItem.title = "我的資料庫"
        // 設定導覽列左側按鈕
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "編輯", style: .plain, target: self, action: #selector(buttonEditAction))
        // 設定導覽列右側按鈕
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "新增", style: .plain, target: self, action: #selector(buttonAddAction))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 讓表格進入編輯狀態
//        self.tableView.isEditing = true
    }

    // MARK: - Table view data source
    // 表格有幾段(表格外迴圈的數量)
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        // super.numberOfSections(in: tableView)// 注意：引入協定方法不能做super，有可能是空方法
        return 1// 表格不分，只有一段
    }
    // 表格的每一段要有幾個儲存格(表格內迴圈的數量)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // 如果表格有分段時
//        if section == 0
//        {
//            return 2
//        }
//        else if section == 1
//        {
//            return 3
//        }
        return list.count
    }

    // 準備每一個儲存格的顯示內容
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        print("現在準備Section:\(indexPath.section), Row:\(indexPath.row)")
        // 注意：以下兩個屬性必須配合儲存格Style的設定才能正常顯示！
        cell.textLabel?.text = list[indexPath.row]
        cell.detailTextLabel?.text = "資料：\(indexPath.row)"
        // 指定特定儲存格右側裝飾圖示
        if indexPath.row == 1
        {
            cell.accessoryType = .detailButton
        }
        
        return cell
    }
    
    
    //MARK: - Table view delegate
    //當儲存格被點選
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    {
        print(list[indexPath.row])
        // 紀錄被點選的儲存格位置
        currentRow = indexPath.row
    }
    // 注意：實現儲存的移動功能，必須實作以下兩個代理方法
    // <代理方法1>設定儲存格可以被移動（此事件可以省略，因為預設值就是True）
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool
    {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    
    // <代理方法2>實際移動儲存格時
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath)
    {
        
        print("移動前：\(fromIndexPath)，移動後：\(to)")
        print("移動前的陣列：\(list)")
        // <方法一>對調移動的來源儲存格與目的地儲存格
        list.insert(list.remove(at: fromIndexPath.row), at: to.row)
        /*
        // <方法二>為<方法一>的分階段執行
        // Step1.先記憶即將被移除的陣列元素（一開始的來源位置的元素），同時移除該元素
        let tmp = list.remove(at: fromIndexPath.row)
        // Step2.再將已經移除的元素，往移動的目的地位置安插
        list.insert(tmp, at: to.row)
        */
        print("移動後的陣列：\(list)")
    }
    
    
    // 注意：實作表格的編輯事件之後，表格可以滑動"刪除"
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            print("刪除前陣列：\(list)")
            // Step1.先刪除表格對應的該筆陣列資料
            list.remove(at: indexPath.row)
            // Step2.刪除介面上的該筆儲存格
            tableView.deleteRows(at: [indexPath], with: .fade)
            print("刪除後陣列：\(list)")
        }
    }
    // 更換刪除按鈕的文字
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?
    {
        
        return "不要了"
    }
    
    // 設定儲存格向左滑動時，提供的按鈕(注意：此事件會覆蓋以上兩個事件的行為 即7-9來替代7-5)
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        // 準備"更多"按鈕
        let actionMore = UIContextualAction(style: .normal, title: "更多") {
            (action, view, completionHandler)
            in
//            completionHandler(true)
            print("更多按鈕被按下")
        }
        actionMore.backgroundColor = .blue
        // 準備"刪除"按鈕
        let actionDelete = UIContextualAction(style: .normal, title: "刪除") {
            (action, view, completionHandler)
            in
//            completionHandler(true)
            print("刪除前陣列：\(self.list)")
            // Step1.先刪除表格對應的該筆陣列資料
            self.list.remove(at: indexPath.row)
            // Step2.刪除介面上的該筆儲存格
            tableView.deleteRows(at: [indexPath], with: .fade)
            print("刪除後陣列：\(self.list)")
        }
        actionDelete.backgroundColor = .red
        // 將兩個按鈕組合
        let config = UISwipeActionsConfiguration(actions: [actionDelete, actionMore])
        // 允許滑動到底時，執行delete(即上述陣列的第一個元素)
        config.performsFirstActionWithFullSwipe = true
        return config
    }


    // 不允許使用者操作表格資料的刪除功能
//    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle
//    {
//        return .none
//    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
