//
//  johoViewController.swift
//  Rh-血液型集まれ
//
//  Created by 加藤 周 on 2015/03/29.
//  Copyright (c) 2015年 mycompany. All rights reserved.
//
import UIKit

class johoViewController: UIViewController , UITextFieldDelegate {
    
    
    @IBOutlet var bloodTypeLabel : UILabel!//血液型
    @IBOutlet var hospitalNameLabel : UILabel!//病院名
    @IBOutlet var currentPlaceLabel : UILabel!//現在地
    @IBOutlet var addressLabel : UILabel!//住所
    @IBOutlet var clientNameLabel : UILabel!//依頼者名
    @IBOutlet var commentLabel : UILabel!//コメント
    @IBOutlet var nameLabel : UILabel!//名前
    @IBOutlet var currentTimeLabel : UILabel!//現在時刻
    @IBOutlet var endLabel1 : UILabel!//募集終了した場合のLabel1
    @IBOutlet var endLabel2 : UILabel!//募集終了した場合のLabel2
    var info = [PFObject]()
    var closedString : String = ""
    var endString : String = ""
    var selectValue : Int!//!はnilではない
    var bashoString : String = ""
    var byoinString : String = ""
    var jushoString : String = ""
    var ketuekiString : String = ""
    var komentString : String = ""
    var nameString : String = ""
    var zikokuString : String = ""
    var number = -1
    var timer : NSTimer!
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("indexpathは%d",selectValue)
        endLabel1.hidden = true
        endLabel2.hidden = true
        NSLog("endStringは%@",endString)
        if (endString == "end"){
            endLabel1.hidden = false
            endLabel2.hidden = false
        }else{
            endLabel1.hidden = true
            endLabel2.hidden = true
        }
        SVProgressHUD.showWithStatus("読み込み中")

        self.loadData { (objects, error) -> () in
            for object in objects {
                self.info.append(object as PFObject)
                
            }
            SVProgressHUD.show()
            NSLog("infoは、%@", self.info)
            self.ketuekiString = self.info[self.selectValue].objectForKey("ketueki") as String
            NSLog("ketuekistringは%@", self.ketuekiString)
            self.bloodTypeLabel.text = self.ketuekiString
            self.bashoString = self.info[self.selectValue].objectForKey("basho") as String
            self.currentPlaceLabel.text = self.bashoString
            
            self.byoinString = self.info[self.selectValue].objectForKey("byoin") as String
            self.hospitalNameLabel.text = self.byoinString
            
            self.jushoString = self.info[self.selectValue].objectForKey("jusho") as String
            self.addressLabel.text = self.jushoString
            
            self.komentString = self.info[self.selectValue].objectForKey("koment") as String
            self.commentLabel.text = self.komentString
            
            self.nameString = self.info[self.selectValue].objectForKey("name") as String
            self.nameLabel.text = self.nameString
            
            self.zikokuString = self.info[self.selectValue].objectForKey("zikoku") as String
            self.currentTimeLabel.text = self.zikokuString
            SVProgressHUD.dismiss()
  
        }
    }
    
    func loadData(callback:([PFObject]!, NSError!) -> ())  {
        var query: PFQuery = PFQuery(className: "kinkyu")
        
        query.orderByAscending("createdAt")
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
            if (error != nil){
                // エラー処理
                //alertを出す。
                
            }
            callback(objects as [PFObject], error)
        }
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        
        self.view.endEditing(true)
        return false
    }
    
    
    
    @IBAction func back() {
        //        self.performSegueWithIdentifier("tableviewjoho", sender: nil)
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
}