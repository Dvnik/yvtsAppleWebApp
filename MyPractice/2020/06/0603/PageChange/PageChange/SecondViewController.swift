
import UIKit

class SecondViewController: UIViewController
{
    
    @IBAction func buttonBack(_ sender: UIButton)
    {
        self.dismiss(animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        // 先執行父類別相同函式（已取得跟父類別相同的功能）
        super.viewDidLoad()
        // 才執行自己覆寫的功能
        print("view2載入完成")
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
   
    deinit
    {
        print("view2即將被釋放")
    }
}
