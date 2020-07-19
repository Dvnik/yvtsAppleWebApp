//
//  AppDelegate.swift
//  PageChange
//
//  Created by Trixie Lulamoon on 2020/6/3.
//  Copyright © 2020 Trixie Lulamoon. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        print("載入APP")
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication)
    {
        // 注意：此方法在iOS13之後不會呼叫
        print("啟動APP")
    }
    
    func applicationWillResignActive(_ application: UIApplication)
    {
        // 注意：此方法在iOS13之後不會呼叫
        print("App即將進入背景")
    }
    
    func applicationDidEnterBackground(_ application: UIApplication)
    {
        // 注意：此方法在iOS13之後不會呼叫
        print("App已經進入背景")
    }
    
    func applicationWillEnterForeground(_ application: UIApplication)
    {
        // 注意：此方法在iOS13之後不會呼叫
        print("App即將從背景回到前景")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        print("App終止")
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

