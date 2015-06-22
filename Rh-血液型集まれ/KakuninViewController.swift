//
//  KakuninViewController.swift
//  Rh-血液型集まれ
//
//  Created by 加藤 周 on 2015/04/04.
//  Copyright (c) 2015年 mycompany. All rights reserved.
//

import UIKit

class KakuninViewController: UIViewController {
    var picture : UIImage!
    var hospitalNameString = ""
    var currentPlaceString = ""
    var addressString = ""
    var commentString = ""
    var bloodTypeString = ""
    var nameString = ""
    var isSending : Bool!
    var timer : NSTimer!
    var transmission : Int = 0
    var facialRecognition : Int = 0
    var pinCode = ""
    @IBOutlet var hospitalNameLabel : UILabel!//病院名
    @IBOutlet var currentPlaceLabel : UILabel!//現在地
    @IBOutlet var addressLabel : UILabel!//住所
    @IBOutlet var bloodTypeLabel : UILabel!//血液型
    @IBOutlet var commentLabel : UILabel!//コメント
    @IBOutlet var nameLabel : UILabel!//名前
    @IBOutlet var pictureImageView : UIImageView!
    @IBOutlet var indispensableLabel1 : UILabel!//血液型必須(何何indispensableLabelとした方が見やすい)
    @IBOutlet var indispensableLabel2 : UILabel!//病院名必須
    @IBOutlet var indispensableLabel3 : UILabel!//集合場所必須
    @IBOutlet var indispensableLabel4 : UILabel!//住所必須
    @IBOutlet var indispensableLabel5 : UILabel!//名前必須
    @IBOutlet var indispensableLabel6 : UILabel!//コメント必須
    @IBOutlet var indispensableLabel7 : UILabel!//顔写真必須
    var numberInt = 0
    @IBOutlet var pinLabel1 : UILabel!
    @IBOutlet var pinLabel2 : UILabel!
    @IBOutlet var pinLabel3 : UILabel!
    @IBOutlet var pinLabel4 : UILabel!
    var info = [PFObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        picture = UIImage(named: "IMG_2027.jpg")
        
        
        self.loadData { (objects, error) -> () in
            for object in objects {
                self.info.append(object as PFObject)
                
            }
            self.numberInt = self.info.first!.objectForKey("number") as Int
            
            //            //permissionの設定.
            //            let settings = UIUserNotificationSettings(forTypes: UIUserNotificationType.Badge, categories: nil)
            //            UIApplication.sharedApplication().registerUserNotificationSettings(settings)
            //
            //            //バッジの数の設定.
            //            UIApplication.sharedApplication().applicationIconBadgeNumber = self.number
        }
        
        
        
        
        
        
        //
        //        picture = self.info.last?.objectForKey("faceImage") as? UIImage
        
        NSLog("kakunin")
        //        // リサイズ
        let size = CGSize(width: 60, height: 80)
        UIGraphicsBeginImageContext(size)
        picture.drawInRect(CGRectMake(0, 0, size.width, size.height))
        var resizeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let view2: UIImageView = UIImageView(frame: CGRectMake(0,0,150,150))
        picture = resizeImage
        
        
        
        
        
        
        
        // NSDictionary型のoptionを生成。顔認識の精度を追加する.
        var options : NSDictionary = NSDictionary(object: CIDetectorAccuracyHigh, forKey: CIDetectorAccuracy)
        
        // CIDetectorを生成。顔認識をするのでTypeはCIDetectorTypeFace.
        var detector : CIDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: options)
        
        // detectorで認識した顔のデータを入れておくNSArray.
        var faces : NSArray = detector.featuresInImage(CIImage(image: picture))
        
        //         UIKitは画面左上に原点があるが、CoreImageは画面左下に原点があるのでそれを揃えなくてはならない.
        //         CoreImageとUIKitの原点を画面左上に統一する処理.
        var transform : CGAffineTransform = CGAffineTransformMakeScale(1, -1)
        transform = CGAffineTransformTranslate(transform, 0, -pictureImageView.bounds.size.height)
        
        // 検出された顔のデータをCIFaceFeatureで処理.
        var feature : CIFaceFeature = CIFaceFeature()
        facialRecognition = 1
        for feature in faces {
            facialRecognition = 2
            // 座標変換.
            let faceRect : CGRect = CGRectApplyAffineTransform(feature.bounds, transform)
            
            // 画像の顔の周りを線で囲うUIViewを生成.
            //            var faceOutline = UIView(frame: faceRect)
            //            faceOutline.layer.borderWidth = 1
            //            faceOutline.layer.borderColor = UIColor.redColor().CGColor
            //            pictureImageView.addSubview(faceOutline)
            
            NSLog("顔認識")
        }
        
        
        
        
        
        isSending = false
        
        indispensableLabel1.hidden = true
        indispensableLabel2.hidden = true
        indispensableLabel3.hidden = true
        indispensableLabel4.hidden = true
        indispensableLabel5.hidden = true
        indispensableLabel6.hidden = true
        indispensableLabel7.hidden = true
        
        var pinNumber1 = arc4random_uniform(9)
        var pinNumber2 = arc4random_uniform(9)
        var pinNumber3 = arc4random_uniform(9)
        var pinNumber4 = arc4random_uniform(9)
        var pin1 = String(pinNumber1)
        var pin2 = String(pinNumber2)
        var pin3 = String(pinNumber3)
        var pin4 = String(pinNumber4)
        //パスワードを再発行します！
        var string1 = "4"
        
        
        pinCode = pin1 + pin2 + pin3 + pin4
        NSLog("pinCode%@",pinCode)
        
        pinLabel1.text = String(pinNumber1)
        pinLabel2.text = String(pinNumber2)
        pinLabel3.text = String(pinNumber3)
        pinLabel4.text = String(pinNumber4)
        
        currentPlaceLabel.text = currentPlaceString
        addressLabel.text = addressString
        nameLabel.text = nameString
        bloodTypeLabel.text = bloodTypeString
        commentLabel.text = commentString
        pictureImageView.image = picture
        hospitalNameLabel.text = hospitalNameString
        
        // Do any additional setup after loading the view.
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
    
    @IBAction func sousin() {
        
        
        if isSending == false{//送信中ではない時
            isSending = true//isSendingが1になる
            if hospitalNameString == ""{
                NSLog("hello")
                indispensableLabel2.hidden = false
            }else{
                indispensableLabel2.hidden = true
            }
            if currentPlaceString == ""{
                NSLog("hello")
                indispensableLabel3.hidden = false
            }else{
                indispensableLabel3.hidden = true
            }
            if addressString == ""{
                NSLog("hello")
                indispensableLabel4.hidden = false
            }else{
                indispensableLabel4.hidden = true
            }
            if nameString == ""{
                NSLog("hello")
                indispensableLabel5.hidden = false
            }else{
                indispensableLabel5.hidden = true
            }
            if commentString == ""{
                NSLog("hello")
                indispensableLabel6.hidden = false
            }else{
                indispensableLabel6.hidden = true
            }
            if facialRecognition == 1{
                indispensableLabel7.hidden = false
            }else{
                indispensableLabel7.hidden = true
            }
            
            if addressString == ""||hospitalNameString == ""||currentPlaceLabel == ""||nameString == ""||commentString == ""||facialRecognition == 1{
                NSLog("空")
                let myAlert = UIAlertController(title: "警告", message: "詳細情報をすべて入力してください。", preferredStyle: .Alert)
                // UIAlertを発動する.
                let myOkAction = UIAlertAction(title: "OK", style: .Default) { action in
                    println("Action OK!!")
                }
                // OKのActionを追加する.
                myAlert.addAction(myOkAction)
                presentViewController(myAlert, animated: true, completion: nil)
                self.isSending = false
                
                
            }else{
                //for文でparseのkinkyuClassのpinCode(String)カラムの情報をとってきた配列でとってくる
                //pinCode(parse側)とpinCode(今発行されている)が同じだったら再発行
                
                //ここに書くよー
                var number = numberInt++
                
                SVProgressHUD.show()
                NSLog("hello")
                //わざとあける(上と下では違う事を書いているから)
                var object:PFObject = PFObject(className:"kinkyu")
                object["jusho"] = addressString
                object["byoin"] = hospitalNameString
                object["basho"] = currentPlaceString
                object["koment"] = commentString
                object["name"] = nameString
                object["ketueki"] = bloodTypeString
                object["pinCode"] = pinCode
                object["zikoku"] = self.getDate()
                object["end"] = "noEnd"
                object["number"] = number
                //        object["jusho"] = _juusho
                //処理している裏側で、パースにデータを保存
                object.saveInBackgroundWithBlock { (succeeded, error) -> Void in
                    if (error != nil){
                        
                        //エラーがあったら...
                        NSLog("エラーです!%@の理由でエラーです",error)
                        self.isSending = false
                    }else{
                        self.transmission = 0
                        //エラーがないと!
                        NSLog("エラーないよ!")
                        SVProgressHUD.dismiss()
                        NSLog("オーイ")
                        
                        
                        self.performSegueWithIdentifier("kinkyuback", sender: nil)
                        self.isSending = false
                        
                    }
                }
            }
        }
    }
    
    func getDate()->NSString {
        let now = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US") // ロケールの設定
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss" // 日付フォーマットの設定
        var thisDate = dateFormatter.stringFromDate(now)
        return thisDate
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "backkinkyusegue") {
            // SecondViewControllerクラスをインスタンス化してsegue（画面遷移）で値を渡せるようにバンドルする
            var secondView : kinkyuViewController = segue.destinationViewController as kinkyuViewController
            // secondView（バンドルされた変数）に受け取り用の変数を引数とし_paramを渡す（_paramには渡したい値）
            // この時SecondViewControllerにて受け取る同型の変数を用意しておかないとエラーになる
            secondView.transmissionNumber = transmission
        }
    }
    
    @IBAction func back () {
        NSLog("backbackback")
        self.transmission = 1
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
}


