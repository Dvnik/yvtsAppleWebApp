
import UIKit
//import MediaPlayer// 匯入媒體播放框架
import AVFoundation // 匯入不含UI的聲音影像播放框架

class ViewController: UIViewController, AVAudioPlayerDelegate
{
    // 「播放與暫停」按鈕
    @IBOutlet weak var buttonPlayAndPause: UIButton!
    // 音樂播放進度的滑桿
    @IBOutlet weak var slider: UISlider!
    // 標示已播放時間
    @IBOutlet weak var labelPlayedTime: UILabel!
    // 標示剩餘時間
    @IBOutlet weak var labelLeftTime: UILabel!
    // 宣告計時器
    weak var timer:Timer!
    
    // 宣告音樂播放器
    var audioPlayer:AVAudioPlayer!
    // MARK: - 自訂函式
    // 標示已播放和剩餘時間
    func countPlayTime()
    {
        // 標示已播放時間
        labelPlayedTime.text = String(format: "%02d:%02d", Int(audioPlayer.currentTime) / 60,Int(audioPlayer.currentTime) % 60)
        // 標示剩餘時間
        
        labelLeftTime.text = String(format: "%02d:%02d", (Int(audioPlayer.duration) - Int(audioPlayer.currentTime)) / 60,(Int(audioPlayer.duration) - Int(audioPlayer.currentTime)) % 60)
    }
    
    // 由通知中心呼叫的事件
    @objc func audioInterrupted(_ notification: Notification)
    {
        guard audioPlayer != nil, let userInfo = notification.userInfo
        else
        {
            return
        }
        
        print("由通知中心過來的字典：\(userInfo)")
        
        guard let userMessage = userInfo[AVAudioSessionInterruptionTypeKey]
        else
        {
            return
        }
        // <方法一>使用數字直接攔截中斷情況
        let type_tmp = userMessage as! UInt
//        print("中斷狀態:\(type_tmp)")
//
//        switch type_tmp
//        {
//        case 0:
//            print("音樂播放中斷情況解除！")
//            audioPlayer.play()
//        case 1:
//            print("音樂播放中斷！")
//            audioPlayer.pause()
//        default:
//            print("狀況未知")
//        }
        // <方法二>使用數字初始化列舉型別的實體，再攔截中斷情況
        let type = AVAudioSession.InterruptionType(rawValue: type_tmp)
        
        switch type
        {
            case .ended: // 原始值為0
                print("音樂播放中斷情況解除！")
                audioPlayer.play()
            case .began: // 原始值為1
                print("音樂播放中斷！")
                audioPlayer.pause()
            default:
                print("狀況未知")
        }
        
    }
    
    // MARK:- Target Action
    // 「播放與暫停」按鈕
    @IBAction func buttonPlayAndPause(_ sender: UIButton)
    {
        if audioPlayer != nil && !audioPlayer.isPlaying
        {
            
            sender.setBackgroundImage(UIImage(named: "pause.png"), for: .normal)
            // 開始播放
            audioPlayer.play()
            // 如果第一次進行播放，則初始化計時器
            if timer == nil
            {
                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {
                    (timer)
                    in
                    // 將目前播放進度設定在滑桿的目前位置
                    self.slider.value = Float(self.audioPlayer.currentTime)
                    // 標示已播放時間&剩餘時間
                    self.countPlayTime()
                    
                    print("timer 執行中......")
                })
                
                print("Timer的引用計數\(CFGetRetainCount(timer)-1)")
            }
//            else  // 注意：fire方法無法讓invalidate的timer重新啟動
//            {
//                timer.fire()
//            }
            
            
        }
        else
        {
            sender.setBackgroundImage(UIImage(named: "play.png"), for: .normal)
            // 暫停播放
            audioPlayer.pause()
        }
    }
    // 「停止」按鈕
    @IBAction func buttonStop(_ sender: UIButton!)
    {
        if audioPlayer != nil
        {
            // 更換成播放圖示
            buttonPlayAndPause.setBackgroundImage(UIImage(named: "play.png"), for: .normal)
            // 停止播放
            audioPlayer.stop()
            // 將播放秒數調回最前面
            audioPlayer.currentTime = 0
            // 如果計時器存在
            if timer != nil
            {
                print("Timer的引用計數\(CFGetRetainCount(timer)-1)")
                //停止計時器(注意：此時釋放由Timer本身所使用的強引用，timer所指向的記憶體配置空間會立即被釋放)
                timer.invalidate()
//                print("Timer的引用計數\(CFGetRetainCount(timer)-1)")
                // 將目前播放進度設定在滑桿的目前位置
                slider.value = 0
                // 標示已播放時間&剩餘時間
                countPlayTime()
                
            }
        }
    }
    
    
    // 拖曳滑桿事件
    @IBAction func sliderValueChanged(_ sender: UISlider)
    {
        print("滑桿值：\(sender.value)")
        if audioPlayer != nil
        {
            // 模擬器有些問題，currentTime的值被改變以後，無法繼續播放音樂
            // （注意：實機不需此行）變更目前播放時間前，先暫停！
            audioPlayer.pause()
            // 依照目前的滑桿值，變更聲音的目前播放時間
            audioPlayer.currentTime = TimeInterval(sender.value)
            // （注意：實機不需此行）變更目前播放時間後，繼續播放！
            audioPlayer.play()
            // 標示已播放時間&剩餘時間
            countPlayTime()
        }
    }
    
    
    
    
    
    // MARK: - View Lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // NSNotification.Name.AVAudioSessionInterruption無法使用，改成AVAudioSession.interruptionNotification
        // 向系統的通知中心註冊音訊播放中斷通知
        NotificationCenter.default.addObserver(self, selector: #selector(audioInterrupted(_:)), name: AVAudioSession.interruptionNotification, object: nil)
        do
        {
            // 設定音樂串流的形式為播放(注意：此段必須配合音樂背景播放的設定運作 參考25-1 以實機測試為準！)
            try AVAudioSession.sharedInstance().setCategory(.playback)
        }
        catch
        {
            print("音樂串流形式設定錯誤：\(error)")
        }
        // 取得應用程式捆包中的mp3檔案路徑
        let urlFile = Bundle.main.url(forResource: "music", withExtension: "mp3")!
        do
        {
            // 取得音樂播放器的實體
            audioPlayer = try AVAudioPlayer(contentsOf: urlFile)
        }
        catch
        {
            print("音樂載入錯誤：\(error)")
        }
        // 指派audioPlayer的代理人為本頁的類別實體
        audioPlayer.delegate = self
        
        // 準備播放音樂（忽略回傳值）
        audioPlayer.prepareToPlay()
        // 在滑桿上標示聲音的最大時間
//        slider.minimumValue = 0
        slider.maximumValue = Float(audioPlayer.duration)
        // 將目前播放進度設定在滑桿的目前位置
        slider.value = Float(audioPlayer.currentTime)
        // 標示已播放和剩餘時間
        countPlayTime()
    }
    // MARK: - AVAudioPlayerDelegate
    // 音樂播放完畢的代理事件
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool)
    {
        print("音樂播完了！！！！")
        // <方法一>按一下停止按鈕
//        buttonStop(nil)
        // <方法二>繼續播放（循環播放）
        audioPlayer.play()
    }

}

