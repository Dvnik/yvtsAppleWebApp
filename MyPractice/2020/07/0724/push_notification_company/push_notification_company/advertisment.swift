//
//  advertisment.swift
//  push_notification_company
//
//  Created by Trixie Lulamoon on 2020/7/10.
//  Copyright © 2020 Trixie. All rights reserved.
//

import UIKit
import FirebaseDatabase
import AVFoundation
import FirebaseStorage

class advertisment: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, AVAudioPlayerDelegate /*, AVAudioRecorderDelegate */{
 
    
    @IBOutlet weak var ad_title: UITextField!
    
    @IBOutlet weak var ad_description: UITextView!
    
    @IBOutlet weak var ad_picture: UIImageView!
    
    @IBOutlet weak var ad_sound: UIImageView!
    //連結資料庫root元素的Reference(此處用Firebase)
    var root:DatabaseReference!
    var storage:Storage!
    let sound_file_path = "\(NSHomeDirectory())/Documents/recording.m4a"
    
    // 拍照的Controller
    // 需要 UIImagePickerControllerDelegate, UINavigationControllerDelegate
    var vc:UIImagePickerController!
    // 錄音的要素要有兩個，Session和Recorder
    // 需要 import AVFoundation
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var audioFilename: URL!
    
    var signal:Bool = true
    var signal2:Bool = true
    
    //MARK:- Swift Life Cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        root =  Database.database().reference()
        storage = Storage.storage()
        
        recordingSession = AVAudioSession.sharedInstance()
        print(NSHomeDirectory())
    }
    //MARK: - user Function
    // 拍照
    @IBAction func take_picture(_ sender: Any) {
        // 做一個空的ImagePicker慢慢調整
        vc = UIImagePickerController()
        //在模擬器上無法使用camera，因此替代的方案用photoLibrary等其他功能
//        vc.sourceType = .camera
        vc.sourceType = .photoLibrary
        vc.allowsEditing = true
        vc.cameraDevice = .rear
        vc.delegate = self // 需要 UIImagePickerControllerDelegate, UINavigationControllerDelegate
        self.present(vc, animated: true, completion: nil)
    }
    //開始錄音
    @IBAction func record_sound(_ sender: Any) {
        self.signal = true
        do {
            
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            
            recordingSession.requestRecordPermission() { allowed in
                DispatchQueue.main.async {
                    if allowed
                    {
                        // 需要權限NSMicrophoneUsageDescription
                        self.audioFilename = URL(fileURLWithPath: self.sound_file_path)

                        let settings = [
                            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                            AVSampleRateKey: 12000,
                            AVNumberOfChannelsKey: 1,
                            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
                        ]

                        do {
                            
                            self.audioRecorder = try AVAudioRecorder(url: self.audioFilename, settings: settings)
                            //self.audioRecorder.delegate = self
                            self.audioRecorder.record()
                            self.audioRecorder.isMeteringEnabled = true
                            print(self.audioRecorder.isMeteringEnabled)
                            Thread(){
                                
                                while(self.signal){
                                    self.audioRecorder.updateMeters()
                                    let power:Float = self.audioRecorder.averagePower(forChannel: 0)
                                    //let db = 10 * log10 (power);
                                   
                                    let normalizedValue = pow(10, power / 20)
                                    print("正規化聲音大小===> \(normalizedValue)")
                                    DispatchQueue.main.async {
                                        var original_frame:CGRect = self.ad_sound.frame
                                        original_frame.size.width = CGFloat(normalizedValue * 80.0)
                                        self.ad_sound.frame.size = original_frame.size
                                    }
                                    usleep(1000)
                                }
                               
                                
                            }.start()
                            
                            
                            
                        } catch {
                            
                        }
                    } else {
                        // failed to record!
                        print("this app need to recording sound! you have to give permission")
                    }
                }
            }
        } catch {
            // failed to record!
        }
        
        
    }
    //停止錄音
    @IBAction func stop_recording(_ sender: Any)
    {
        audioRecorder.stop()
        //audioRecorder = nil
        self.signal = false
    }
    //試聽
    @IBAction func listen_sound(_ sender: Any)
    {
        self.signal2 = true
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: audioFilename)
            audioPlayer.play()
            audioPlayer.isMeteringEnabled = true
            audioPlayer.delegate = self
            Thread(){
                
                
                while(self.signal2){
                    self.audioPlayer.updateMeters()
                    let power:Float = self.audioPlayer.averagePower(forChannel: 0)
                     //let db = 10 * log10 (power);
                    
                     let normalizedValue = pow(10, power / 20)
                     print("正規劃聲音大小===> \(normalizedValue)")
                     DispatchQueue.main.async {
                         var original_frame:CGRect = self.ad_sound.frame
                         original_frame.size.width = CGFloat(normalizedValue * 80.0)
                         self.ad_sound.frame.size = original_frame.size
                     }
                     usleep(1000)
                    
                }
                
                
                
                
            }.start()
            
        }catch{
            print("ERROR \(error)")
        }
        
    }
    //放棄錄音／推送
    @IBAction func give_up(_ sender: Any)
    {
        
    }
    //推送廣告
    @IBAction func push_ad(_ sender: Any)
    {
        //var product_data:[String:[String:String]] = [String:[String:String]]()
        
        var some_description:String = ""
        if self.ad_description.text == ""{
            some_description = "促銷計畫中"
        }else{
            some_description = self.ad_description.text
        }
        var some_title:String = ""
        if self.ad_title.text == ""{
            some_title = "絕密好康！請等待..."
        }else{
            some_title = self.ad_title.text!
        }
        
        
        
        let son_json:[String:String] = [
         "message" : some_description,
         "picture" : "product.jpg",
         "sound" : "product.m4a",
         "title" : some_title
        ]
        // 將資料推上去就只需要推內容(son_json)，不需要連根一起推進去
        //product_data["broadcast"] = 子json
        
        let broadcast = root.child("broadcast")
        broadcast.setValue(son_json)
        
        /// upload picture and sound file
        
        let pic_ref = storage.reference().child("/advertisement/picture/product.jpg")
        
        
        pic_ref.putData(
            (self.ad_picture.image?.jpegData(compressionQuality: 0.5))!
        )
        
        let sou_ref = storage.reference().child("/advertisement/sound/product.m4a")
        
        do{
            
            sou_ref.putData(
                try Data(contentsOf:URL(fileURLWithPath: sound_file_path) )
            )
        }catch{
            print("upload sound error :\(error)")
        }
        
        
        
    }
    
    //MARK:- UIImagePickerControllerDelegate處理函數群
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("CANCEL")
        // 將UIImagePicker隱藏
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("OK LA")
        
        let pic:UIImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.ad_picture.image = pic
        // 將UIImagePicker隱藏
        picker.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- AVAudioRecorderDelegate函數群
    //MARK:- AVAudioPlayererDelegate函數群
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.signal2 = false
    }
}
