//
//  AppDelegate.swift
//  Rh-血液型集まれ
//
//  Created by 加藤 周 on 2015/03/29.
//  Copyright (c) 2015年 mycompany. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var myUserDafault:NSUserDefaults = NSUserDefaults()
    var pictures : UIImage?
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //登録されているUserDefaultに+1する
        var count:Int = myUserDafault.integerForKey("VisitCount") + 1
        
        //+1した値を登録する
        myUserDafault.setObject(count, forKey: "VisitCount")
        

        // Override point for customization after application launch.
        var ID : String = "OJPrlNLhqPEqTOdEELXjn8s4sYDaIrywMbylrrIt"
        var Key : String = "IDJhl7xEz5KMVFbXbdj6LcleVhVaioiehFL7O69A"
        // MARK: - Parse
        Parse.setApplicationId(ID, clientKey:Key)
        PFUser.enableAutomaticUser()
        //ACL設定
        var defaultACL = PFACL()
        defaultACL.setPublicReadAccess(true)
        defaultACL.setPublicWriteAccess(true)
        PFACL.setDefaultACL(defaultACL, withAccessForCurrentUser: true)
        
        
        
        //画面の大きさを取得して、Storyboardを変える
        //if switch文

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

