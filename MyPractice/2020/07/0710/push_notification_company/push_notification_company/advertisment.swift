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

class advertisment: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    @IBOutlet weak var ad_title: UITextField!
    
    @IBOutlet weak var ad_description: UITextView!
    
    @IBOutlet weak var ad_picture: UIImageView!
    
    @IBOutlet weak var ad_sound: UIImageView!
    //連結資料庫root元素的Reference(此處用Firebase)
    var root:DatabaseReference!
    // 拍照的Controller
    // 需要 UIImagePickerControllerDelegate, UINavigationControllerDelegate
    var vc:UIImagePickerController!
    // 錄音的要素要有兩個，Session和Recorder
    // 需要 import AVFoundation
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    //MARK:- Swift Life Cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        root =  Database.database().reference()
        
        recordingSession = AVAudioSession.sharedInstance()
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
    @IBAction func record_sound(_ sender: Any)
    {
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed
                    {
                        
                        let audioFilename = URL(fileURLWithPath: "\(NSHomeDirectory())/Document/recording.m4a")

                           let settings = [
                               AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                               AVSampleRateKey: 12000,
                               AVNumberOfChannelsKey: 1,
                               AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
                           ]
                        //TODO
                            /*
                           do {
                            self.audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
                            self.audioRecorder.delegate = self
                            self.audioRecorder.record()

                              // recordButton.setTitle("Tap to Stop", for: .normal)
                           } catch {
                              // finishRecording(success: false)
                           }
                          */
                    }
                    else
                    {
                        // failed to record!
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
        audioRecorder = nil
    }
    //試聽
    @IBAction func listen_sound(_ sender: Any)
    {
        
    }
    //放棄錄音／推送
    @IBAction func give_up(_ sender: Any)
    {
        
    }
    //推送廣告
    @IBAction func push_ad(_ sender: Any)
    {
        var some_description:String = ""
        if self.ad_description.text == "" {
            some_description = "促銷計畫中"
        }
        else {
            some_description = self.ad_description.text
        }
        var some_title:String = ""
        if self.ad_title.text == "" {
            some_title = "絕密好康！"
        }
        else {
            some_title = self.ad_title.text!
        }
        
        
        
        let son_json:[String:String] = [
            "message" : some_description,
            "picture" : "melon.jpg",
            "sound" : "ggyy.mp3",
            "title" : some_title
        ]
        // 將資料推上去就只需要推內容(son_json)，不需要連根一起推進去
        let broadcast = root.child("broadcast")
        broadcast.setValue(son_json)
    }
    
    //MARK: - UIImagePickerControllerDelegate處理函數群
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
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
}
