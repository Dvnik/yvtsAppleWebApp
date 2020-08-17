//
//  AppDelegate.swift
//  push_notification_client
//
//  Created by Trixie Lulamoon on 2020/7/10.
//  Copyright © 2020 Trixie. All rights reserved.
//

import UIKit
import Firebase

import FirebaseDatabase
import FirebaseStorage
import UserNotifications


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
       var db:Database!
       var storage:Storage!
       var storage_ref:StorageReference!
       
       var message:String!
       var title_text:String!
       var picture:UIImage!
       var sound:String!
       
       //多個工作
       //工作1訊號
       var work_text = true
       var work_picture = true
       var work_sound = true



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        print("\(NSHomeDirectory())")
        let center:UNUserNotificationCenter
        center = UNUserNotificationCenter.current()
        let setting:UNAuthorizationOptions = [.alert, .sound, .badge]
        center.requestAuthorization(options: setting){
            ok, err
            in
            if let error = err{
                print("請求失敗！！請重新安裝 \(error)")
            }else{
                print("3Q")
            }
        }
        /*
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { granted, error in
            if granted {
                print("使用者同意了，每天都能收到來自米花兒的幸福訊息")
            }
            else {
                print("使用者不同意，不喜歡米花兒，哭哭!")
            }
            
        })
        */
        
        /////////////////////
        
        db = Database.database()
               storage = Storage.storage()
               
               let db_ref = db.reference()
               storage_ref = storage.reference()
               
              db_ref.child("broadcast").observe(DataEventType.value){
                   ss
                   in
                   print("XXXXX")
                   
                   let broadcast:[String:String] = ss.value! as! [String : String]
                   
                   self.message = broadcast["message"]!
                   print(self.message!)
                   self.title_text = broadcast["title"]!
                   print(self.title_text!)
                   
                   
                  
                   
                   
                   //多個工作
                   //工作1訊號
                   self.work_text = false
                   
                   let picture_name = "\(broadcast["picture"]!)"
                   let storage_pic_ref = self.storage_ref.child("/advertisement/picture/\(picture_name)")
                   storage_pic_ref.getData(maxSize: 15 * 1024){
                       dd, ee
                       in
                       if let error = ee{
                           print("ERROR HAPPEN :\(error)")
                       }else{
                           self.picture = UIImage(data: dd!)!
                           //多個工作
                           //工作2訊號
                           self.work_picture = false
                       }
                   }
                   
                   let sound_name = "\(broadcast["sound"]!)"
                   let storage_sou_ref = self.storage_ref.child("/advertisement/sound/\(sound_name)")
                  
                   storage_sou_ref.getData(maxSize: 50 * 1024){
                       dd, ee
                       in
                       if let error = ee{
                           print("ERROR HAPPEN :\(error)")
                       }else{
                           do{
                               let path = "/\(NSHomeDirectory())/Documents/\(sound_name)"
                               print(path)
                               try dd?.write(to: URL(fileURLWithPath: path))
                               //多個工作
                               //工作3訊號
                               self.work_sound = false
                               
                           }catch{
                               print("SAVE SOUND error :\(error)")
                           }
                           
                       }
                   }
                   /////同步準備
                   ///用一個執行續(不擋人)
                  
                   Thread(){
                       //續中有一無窮回圈(等待訊號)
                       while(self.work_text || self.work_sound || self.work_picture){  //多個訊號必須符合
                           ///卡住在此不作展現
                           if self.work_text {
                               //print("文字仍在處理")
                           }
                           if self.work_picture {
                               //print("圖片仍在處理")
                           }
                           if self.work_sound {
                               //print("圖片仍在處理")
                           }
                       }
                       print("通通到齊")
                       ///能夠離開卡住的迴圈,表示資料全齊,可以展現
                       
                       let content = UNMutableNotificationContent()
                       content.title = self.title_text
                       content.subtitle = "XXYY公司促銷廣告"
                       content.body = self.message
                       content.badge = 1
                       //content.sound = UNNotificationSound.default
                    
                       content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "product.m4a"))
                        
                    let imageURL = Bundle.main.url(forResource: "", withExtension: "")
                    do {
                        let attchment:
                    }
                    catch{
                        print("error:\(error)")
                    }
                    
                       let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 20, repeats: false)
                       
               
                       let request = UNNotificationRequest(identifier: "notification1", content: content, trigger: trigger)
                       UNUserNotificationCenter.current().add(request){
                           err
                           in
                           if let error = err{
                               print("UN ERROR \(error)");
                           }else{
                                print("hahaha")
                           }
                          
                       }
                       
                       
                       
                       self.work_picture = true
                       self.work_sound = true
                       self.work_text = true
                       
                   }.start()
        }
        
        //
        var b:Bundle
        b = Bundle.main
        print("=====>" + b.bundlePath)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
// 為了減輕AppDelegate扮演探多角色程式碼的複雜！ UNUserNotificationCenterDelegate
extension AppDelegate: UNUserNotificationCenterDelegate {

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        
        print("GGYY")
        completionHandler([.badge, .sound, .alert])
    }
}
