//
//  AppDelegate.swift
//  TableViewDB
//
//  Created by Trixie Lulamoon on 2020/7/9.
//  Copyright © 2020 Trixie. All rights reserved.
//

import UIKit
import SQLite3

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    //宣告資料庫連線指標
    private var db: OpaquePointer?
    //提供其他頁面取得資料庫連線的方法
    func getDB() -> OpaquePointer
    {
        return db!
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        //取得應用程式所屬的檔案管理員
        let fileManager = FileManager.default
        
        let sourceDB = Bundle.main.path(forResource: "mydatabase", ofType: "db3")!
        
        print("資料庫捆包的路徑：\(sourceDB)")
        
        let destinationDB = NSHomeDirectory() + "/Documents/mydatabase.db3"
        print("資料庫目的地的路徑：\(destinationDB)")
        //如果資料庫不存在於目的地路徑
        if !fileManager.fileExists(atPath: destinationDB)
        {
            //從梱包終將資料庫檔案複製到目的地路徑
           try? fileManager.copyItem(atPath: sourceDB, toPath: destinationDB)
        }
        //開啟資料庫連線，並存入db所在的記憶體位址
        if sqlite3_open(destinationDB, &db) == SQLITE_OK
        {
            print("資料庫連線成功")
        }
        else
        {
            print("資料庫連線失敗！")
        }
        
        return true
    }
    //應用程式終止時
    func applicationWillTerminate(_ application: UIApplication) {
        if db != nil
        {
            //關閉資料庫
            sqlite3_close(db!)
        }
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

