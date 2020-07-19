
import UIKit
//import MediaPlayer// 匯入媒體播放框架
import AVFoundation // 匯入不含UI的聲音影像播放框架

class ViewController: UIViewController
{
    // 宣告音樂播放器
    var audioPlayer:AVAudioPlayer!
    
    
    // 由通知中心呼叫的事件
    @objc func audioInterrupted(_ notification: Notification)
    {
        //TODO:
    }
    
    
    // 「播放與暫停按鈕」
    @IBAction func buttonPlayAndPause(_ sender: UIButton)
    {
        //TODO:預備搬入按鈕
        if audioPlayer != nil && !audioPlayer.isPlaying
        {
            
            sender.setBackgroundImage(UIImage(named: "pause.png"), for: .normal)
            // 開始播放
            audioPlayer.play()
        }
        else
        {
            sender.setBackgroundImage(UIImage(named: "play.png"), for: .normal)
            // 暫停播放
            audioPlayer.pause()
        }
    }
    // 「停止」按鈕
    @IBAction func buttonStop(_ sender: UIButton)
    {
        if audioPlayer != nil
        {
            audioPlayer.stop()
        }
    }

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
        
        // 準備播放音樂（忽略回傳值）
        audioPlayer.prepareToPlay()
        
    }


}

