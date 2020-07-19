//
//  ViewController.swift
//  firebase_storage
//
//  Created by Trixie Lulamoon on 2020/7/17.
//  Copyright © 2020 Trixie. All rights reserved.
//

import UIKit
import FirebaseStorage
import AVFoundation

class ViewController: UIViewController
{
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var ad_sound: UIImageView!
    
    var Player:AVAudioPlayer!
    
    var signal2:Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("\(NSHomeDirectory())/Documents")
    }

    @IBAction func action(_ sender: Any)
    {
        if (sender as! UIButton).tag == 100
        {
            let storage = Storage.storage()
//            let pathReference = storage.reference(withPath: "三年一班/pic3.jpeg")
            let pathReference = storage.reference(forURL: "gs://bussiness-acaca.appspot.com/三年一班/pic4.jpeg")
            
            let download_task = pathReference.getData(maxSize: 50 * 1024) { (bytes, error)
                in
                if let err = error {
                   // Uh-oh, an error occurred!
                    print("下載出錯：\(err)")
                 } else {
                   // Data for "images/island.jpg" is returned
                   let pic = UIImage(data: bytes!)
                    let d = Date()
                    print(d.hashValue)
                    let path = "\(NSHomeDirectory())/Documents/picture_\(d.hashValue).jpg"
                    /*
                    if !FileManager.default.fileExists(atPath: path)
                    {
                        // save
                        
                    }
                    */
                    guard !FileManager.default.fileExists(atPath: path) else {
                        return
                    }
                    do {
                        try bytes?.write(to: URL(fileURLWithPath: path))
                    }
                    catch {
                        print("儲存失敗\(error)")
                    }
                    
                    
                    DispatchQueue.main.async {
                        self.picture.image = pic
                    }
                 }
            }
            download_task.observe(.progress) { (ss) in
                print(ss.progress!.completedUnitCount)
            }
        }
        else if (sender as! UIButton).tag == 200
        {
            let storage = Storage.storage()
            let pathReference = storage.reference(forURL: "gs://bussiness-acaca.appspot.com/meme_song1.mp3")
            
            pathReference.getData(maxSize: 3052075) { (bytes, error)
                in
                if let err = error {
                   // Uh-oh, an error occurred!
                    print("下載出錯：\(err)")
                 } else {
                    let d = Data()
                    print(d.hashValue)
                    let path = "\(NSHomeDirectory())/Documents/sound\(d.hashValue).m4a"
                    /*
                    if !FileManager.default.fileExists(atPath: path)
                    {
                        // save
                        
                    }
                    */
                    guard !FileManager.default.fileExists(atPath: path) else {
                        return
                    }
                    do {
                        try bytes?.write(to: URL(fileURLWithPath: path))
                        self.Player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                        self.Player.play()
                        self.Player.isMeteringEnabled = true
                        self.signal2 = true
                        Thread {
                            while(self.signal2) {
                                    self.Player.updateMeters()
                                    let power:Float = self.Player.averagePower(forChannel: 0)
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
                    }
                    catch {
                        print("儲存失敗\(error)")
                    }
                 }
            }
        }
        
    }
    
}

