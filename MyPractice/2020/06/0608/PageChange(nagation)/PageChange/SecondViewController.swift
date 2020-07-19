
import UIKit


class SecondViewController: UIViewController
{
    // 預設一個儲存傳遞資料的屬性(由第一頁存入)
    var stringMessage:String? //= nil
    //預設一個儲存「第一頁執行實體」的弱引用（方便回寫資料）
    weak var firstVC:FirstViewController?
    
    
    @IBOutlet weak var labelMessage2: UILabel!
    
    @IBAction func buttonBack(_ sender: UIButton!)
    {
        // 此方法可以退掉由Present Modally顯示的VC
//        self.dismiss(animated: true, completion: nil)
        
        self.firstVC?.labelMessage.text = "我剛剛到過第二頁"
        
        // 此方法可以退掉由navigation流程管理顯示的VC(show方法)
        self.navigationController?.popViewController(animated: true)
    }
    // 向右滑動回到上一頁
    @IBAction func swipeBack(_ sender: UISwipeGestureRecognizer)
    {
        self.buttonBack(nil)
    }
    // 向左滑動到下一頁
    @IBAction func swipeToNext(_ sender: UISwipeGestureRecognizer)
    {
        // 執行換頁線
        self.performSegue(withIdentifier: "ToVC3", sender: nil)
    }
    
    @IBAction func buttonInfo(_ sender: UIButton)
    {
        // 從Storyboard上取得ID為InfoViewController類別，並且初始化！
       let infoVC = self.storyboard!.instantiateViewController(identifier: "InfoViewController") as! InfoViewController
       // 傳遞資訊
       infoVC.stringMessageInfo = "我是第二頁"
       // 顯示資訊頁
       self.show(infoVC, sender: nil)
    }
    

    
    
    
    
    override func viewDidLoad() {
        // 先執行父類別相同函式（已取得跟父類別相同的功能）
        super.viewDidLoad()
        // 才執行自己覆寫的功能
        print("view2載入完成")
        
        if let str = stringMessage
        {
            print("由第一頁傳遞過來：\(str)")
            labelMessage2.text = str
        }
        else
        {
            print("第一頁沒有傳遞資料")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("view2即將出現")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("view2已經出現")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        print("view2已經完成介面佈置")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 注意：進入背景畫面即將消失時，不會呼叫此事件!(除非是頁面轉換時)
        print("view2即將消失")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // 注意：進入背景畫面，並不會呼叫此事件！
        print("view2已經消失")
    }
    // 即將換頁時(目前是由第二頁換到第三頁時)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)
        
        // 確認由特定的連接線執行換頁
        if segue.identifier == "ToVC3"
        {
            // 從換頁線取得第三頁
            let thirdVC = segue.destination as! ThirdViewController
            // 通知第三頁自己這第二頁的實體
            thirdVC.secondVC = self
            // 通知第三頁主頁的執行實體
            thirdVC.firstVC = self.firstVC
        }
        
    }
   
    deinit
    {
        print("view2即將被釋放")
    }
}
