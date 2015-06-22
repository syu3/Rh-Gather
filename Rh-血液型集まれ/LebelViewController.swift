//
//  LebelViewController.swift
//  Rh-血液型集まれ
//
//  Created by 加藤 周 on 2015/03/29.
//  Copyright (c) 2015年 mycompany. All rights reserved.
//

import UIKit

class LebelViewController: UIViewController {
    
    @IBOutlet var kaisu : UILabel!
    @IBOutlet var level : UILabel!
    
    let JohoViewController = johoViewController()
    var lebelTrueNum : Int!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        var ud = NSUserDefaults.standardUserDefaults()
        NSLog("lebelTrueNum == %d",ud.integerForKey("level"))
        lebelTrueNum = ud.integerForKey("level")
        kaisu.text = String(lebelTrueNum)
        
        
        if lebelTrueNum < 3 && lebelTrueNum >= 0 {
            level.text = "ブロンズステージ"
        }else if lebelTrueNum < 6&&lebelTrueNum >= 3 {
            level.text = "ジルバーステージ"
        }else if lebelTrueNum < 9&&lebelTrueNum >= 6{
            level.text = "ゴールドステージ"
        }else if lebelTrueNum >= 10 {
            level.text = "プラチナステージ"
        }
        NSUserDefaults.standardUserDefaults().setObject(lebelTrueNum,forKey:"uid")
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//


}
