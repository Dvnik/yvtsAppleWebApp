//
//  ViewController.swift
//  firebase_storage2
//
//  Created by Trixie Lulamoon on 2020/7/17.
//  Copyright © 2020 Trixie. All rights reserved.
//

import UIKit
import FirebaseStorage

class ViewController: UIViewController
{
    
    @IBOutlet weak var ben: UIImageView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("\(NSHomeDirectory())/Documents")
    }

    @IBAction func upload(_ sender: Any)
    {
        let storage = Storage.storage()
        // Create a root reference
        let storageRef = storage.reference(withPath: "pic\(Date().hashValue).jpeg")
        let data = self.ben.image!.jpegData(compressionQuality: 0.5)
        print("經過處理出來的圖檔Byte\(data!.count)")
        let upload_task = storageRef.putData(data!)
        upload_task.observe(.progress) {
            (progress_ss)
            in
            let ppp = progress_ss.progress
            print(ppp!.completedUnitCount)
        }

        /*
        storageRef.putData(data!, metadata: nil) {
            (metadata, error)
            in
            if let err = error {
                print("上傳失敗，理由是：\(err)")
            }
            else {
                print("上傳成功")
            }
        }
         */
        
    }
    
    
    
    @IBAction func upload2(_ sender: Any)
    {
        let storage = Storage.storage()
        // Create a root reference
        let storageRef = storage.reference(withPath: "三年一班/sound/\(Date().hashValue).m4a")
        let path = "\(NSHomeDirectory())/Documents/aaa.m4a"
        storageRef.putFile(from: URL(fileURLWithPath: path), metadata: nil) {
            (metadata, error)
            in
            if let err = error {
                print("上傳失敗，理由是：\(err)")
            }
            else {
                print("上傳成功")
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

