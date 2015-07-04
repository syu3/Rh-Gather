//
//  requestEndViewController.swift
//  Rh-血液型集まれ
//
//  Created by 加藤 周 on 2015/05/09.
//  Copyright (c) 2015年 mycompany. All rights reserved.
//

import UIKit
import QuartzCore

class requestEndViewController: UIViewController {
    @IBOutlet weak var upDateBackGround: UILabel!
    @IBOutlet weak var upDateButtonImage: UIImageView!
    @IBOutlet weak var upDateLabel: UILabel!
    @IBOutlet weak var upDateImage: UIImageView!
    @IBOutlet weak var upDateButton: UIButton!
    
    
    @IBOutlet var backLabel : UILabel!
    @IBOutlet var backLabel1 : UILabel!
    @IBOutlet var cancelButton : UIButton!
    @IBOutlet var okButton : UIButton!
    var info = [PFObject]()
    @IBOutlet var hospitalNameLabel : UILabel!//病院名
    @IBOutlet var currentPlaceLabel : UILabel!//現在地
    @IBOutlet var addressLabel : UILabel!//住所
    @IBOutlet var bloodTypeLabel : UILabel!//血液型
    @IBOutlet var commentLabel : UILabel!//コメント
    @IBOutlet var nameLabel : UILabel!//名前
    @IBOutlet var currentTimeLabel : UILabel!//現在時刻
    
    
    var pinTextField : UITextField!//暗証番号を入力するためのTextField
    var pinCodeString : NSString!
    var bashoString : String!
    var byoinString : String!
    var jushoString : String!
    var ketuekiString : String!
    var komentString : String!
    var nameString : String!
    var zikokuString : String!
    var timer : NSTimer!
    var numer = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.upDateBackGround.hidden = true
        self.upDateButton.hidden = true
        self.upDateButtonImage.hidden = true
        self.upDateImage.hidden = true
        self.upDateLabel.hidden = true
        
        self.loadData { (objects, error) -> () in
            for object in objects {
                self.info.append(object as PFObject)
                
            }
            //            var ojId = self.info.last?.objectId
            //            NSLog("objectIDは%@",ojId!)
        }
    }
    
    @IBAction func ok(){
        
        backLabel.hidden = true
        backLabel1.hidden = true
        okButton.hidden = true
        cancelButton.hidden = true
        let myAlert: UIAlertController = UIAlertController(title: "お願い", message: "暗証番号を入力してください。", preferredStyle: .Alert)
        
        // OKのアクションを作成する.
        // TODO:PFQuery
        let myOkAction = UIAlertAction(title: "削除する", style: .Default) { action in
            println("Action OK!!")
            //ここに書く
            
            
            var query: PFQuery = PFQuery(className: "kinkyu")
            
            
            
            // バックグラウンドでデータを取得
            query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in//objectもってくる
                NSLog("for文の前です")
                for object in (objects as [PFObject]) {
                    NSLog("for文の後です")
                    if(error == nil){
                        
                        
                        
                        if(self.pinTextField.text == object["pinCode"] as String){
                            
                            println(object)
                            SVProgressHUD.showWithStatus("依頼終了中")
                            //一致しているものをendにする
                            
                            object["end"] = "end"
                            object.saveInBackgroundWithBlock { (succeeded, error) -> Void in
                                NSLog("succeededは%@",succeeded)
                                var alert = UIAlertView()
                                alert.title = "依頼を終了しました！"
                                alert.message = "依頼を終了しました"
                                alert.addButtonWithTitle("OK")
                                alert.show()
                                
                                self.upDateBackGround.hidden = false
                                self.upDateButton.hidden = false
                                self.upDateButtonImage.hidden = false
                                self.upDateImage.hidden = false
                                self.upDateLabel.hidden = false

                                
                                
                                self.backLabel.hidden = false
                                self.backLabel1.hidden = false
                                self.okButton.hidden = false
                                self.cancelButton.hidden = false
                                SVProgressHUD.dismiss()
                                
                                
                                
                                
                                

                            }
                            
                        }else{
                            self.numer = self.numer + 1
                            if(self.numer == 1){
                            var alert = UIAlertView()
                            alert.title = "注意"
                            alert.message = "暗証番号が一致しません。"
                            alert.addButtonWithTitle("OK")
                            alert.show()
                            self.backLabel.hidden = false
                            self.backLabel1.hidden = false
                            self.okButton.hidden = false
                            self.cancelButton.hidden = false
                            SVProgressHUD.dismiss()
                            }else{
                                
                            }
                        }
                    }else{
                        NSLog("errorあるよ")
                    }
                }
            }
        }
        myAlert.addAction(myOkAction)
        myAlert.addTextFieldWithConfigurationHandler { textField -> Void in
            self.pinTextField = textField
            textField.placeholder = "暗証番号入力"
            
        }
        presentViewController(myAlert, animated: true, completion: nil)
        
    }
    @IBAction func upDateOK(sender: AnyObject) {
        self.upDateBackGround.hidden = true
        self.upDateButton.hidden = true
        self.upDateButtonImage.hidden = true
        self.upDateImage.hidden = true
        self.upDateLabel.hidden = true

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
    
    
}
