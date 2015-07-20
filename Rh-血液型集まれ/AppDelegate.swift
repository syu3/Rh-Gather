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
    var navigationController: UINavigationController?
    var viewController : UIViewController?
    
    var iphone4 : CGRect = CGRectMake(0.0, 0.0, 320.0, 480.0)
    var iphone5 : CGRect = CGRectMake(0.0, 0.0, 320.0, 568.0)
    var iphone6 : CGRect = CGRectMake(0.0, 0.0, 375.0, 667.0)
    
    var window: UIWindow?
    var myUserDafault:NSUserDefaults = NSUserDefaults()
    var pictures : UIImage?
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //登録されているUserDefaultに+1する
        var count:Int = myUserDafault.integerForKey("VisitCount")
        
        //値を登録する
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

        
        
        
        
        let screenWidth = Int( UIScreen.mainScreen().bounds.size.width);
        
        //スクリーンの高さ
        let screenHeight = Int(UIScreen.mainScreen().bounds.size.height);
        
        //CGRectで取得
        var rect : CGRect = UIScreen.mainScreen().bounds;
        println(rect)
        
        if(rect == iphone4){
            NSLog("iphone4")
            var storyboard: UIStoryboard = UIStoryboard(name: "3.5inchStoryboard", bundle: NSBundle.mainBundle())
            var mainViewController: UIViewController = storyboard.instantiateInitialViewController() as UIViewController
            self.window?.rootViewController = mainViewController

            
            
        }else if(rect == iphone5){
            var storyboard: UIStoryboard = UIStoryboard(name: "4inchStoryboard", bundle: NSBundle.mainBundle())
            var mainViewController: UIViewController = storyboard.instantiateInitialViewController() as UIViewController
            self.window?.rootViewController = mainViewController
            NSLog("iphone5")
           
            
            
        }else if(rect == iphone6){
            var storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            var mainViewController: UIViewController = storyboard.instantiateInitialViewController() as UIViewController
            self.window?.rootViewController = mainViewController
            
            
            NSLog("iphone6")
        }
        
        
        
        
        
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

