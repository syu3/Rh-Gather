//
//  kinkyuViewController.swift
//  Rh-血液型集まれ
//
//  Created by 加藤 周 on 2015/03/29.
//  Copyright (c) 2015年 mycompany. All rights reserved.
//

import UIKit
import CoreLocation
class kinkyuViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate,CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet var jushoField : UITextField!
    @IBOutlet var name : UITextField!
    @IBOutlet var koment : UITextView!
    @IBOutlet var segmentedControl : UISegmentedControl!
    @IBOutlet var byoin : UITextField!
    @IBOutlet var ka : UITextField!
    //    let myLat: CLLocationDegrees = 41.8319594068842
    //    let myLon: CLLocationDegrees = 140.75289384475
    var picker:UIImagePickerController!
    var myLocationManager:CLLocationManager!
    var picture : UIImage!
    var facepicture : UIImage!
    var util1: DataUtility!
    var util2: DataUtility!
    var selected : Int!
    var ketueki : String!
    var numberOfStarts : Int = 0
    var latitude : CLLocationDegrees = 35.710033
    var longitude : CLLocationDegrees = 139.810716
    var hospitalNameString : String!
    var currentPlaceString : String!
    var addressString : String!
    var commentString : String!
    var bloodTypeString : String!
    var nameString : String!
    var transmissionNumber : Int = 0
    var selectValue : Int = 0
    var info = [PFObject]()
    
    
    var timer : NSTimer!
    override func viewDidLoad() {
        super.viewDidLoad()
        var myUserDafault:NSUserDefaults = NSUserDefaults()
        
        //登録されているUserDefaultから訪問数を呼び出す.
        var count:Int = myUserDafault.integerForKey("VisitCount")
        
        
        NSLog(String(count))
        if(count == 0){
        //タイマーを作る.
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "onUpdate:", userInfo: nil, repeats: true)
    
    
        }
    
        
        
        
        
        
        picker = UIImagePickerController()
        picker!.delegate = self
        picker!.allowsEditing = false

        

        
        
        jushoField.text = ""
        name.text = ""
        koment.text = ""
        byoin.text = ""
        ka.text = ""


            byoin.text = ""
            jushoField.text = ""
            NSLog("transmissionNumberは%d",transmissionNumber)
            
            if transmissionNumber == 1{
 
            }else{
                
            }
            
            ketueki = "A"
            segmentedControl.addTarget(self, action: "segconChanged:", forControlEvents: UIControlEvents.ValueChanged)
            jushoField.delegate = self
            name.delegate = self
            ka.delegate = self
            byoin.delegate = self
            segmentedControl.selectedSegmentIndex = 0
            koment.returnKeyType = .Done
            koment.delegate = self
            util1 = DataUtility()
            util2 = DataUtility()
            
            
            // 現在地の取得.
            myLocationManager = CLLocationManager()

        
        
        
            
            myLocationManager.delegate = self
            
            // セキュリティ認証のステータスを取得.
            let status = CLLocationManager.authorizationStatus()
            
            // まだ認証が得られていない場合は、認証ダイアログを表示.
            if(status == CLAuthorizationStatus.NotDetermined) {
                println("didChangeAuthorizationStatus:\(status)");
                // まだ承認が得られていない場合は、認証ダイアログを表示.
                self.myLocationManager.requestAlwaysAuthorization()
            }
            
            // 取得精度の設定.
            myLocationManager.desiredAccuracy = kCLLocationAccuracyBest
            // 取得頻度の設定.
            myLocationManager.distanceFilter = 100
            myLocationManager.startUpdatingLocation()
            
            
        }

    
    
    //NSTimerIntervalで指定された秒数毎に呼び出されるメソッド.
    func onUpdate(timer : NSTimer){
        
        //UserDefaultの生成.
        var myUserDafault:NSUserDefaults = NSUserDefaults()
        
        //登録されているUserDefaultから訪問数を呼び出す.
        var count:Int = myUserDafault.integerForKey("VisitCount")
        
        
        NSLog(String(count))
        if(count == 0){
            // UIAlertControllerを作成する.
            let myAlert: UIAlertController = UIAlertController(title: "お願い", message: "Rh-をご利用いただきありがとうございます。\nまずアプリを始める前に利用規約をお読みください。", preferredStyle: .Alert)
            
            // OKのアクションを作成する.
            let myOkAction = UIAlertAction(title: "利用契約を読む", style: .Default) { action in
                println("Action OK!!")
                
                self.performSegueWithIdentifier("a", sender: nil)
            }
            
            // OKのActionを追加する.
            myAlert.addAction(myOkAction)
            
            // UIAlertを発動する.
            presentViewController(myAlert, animated: true, completion: nil)
            
            timer.invalidate()
        }else{
            
        }

        
    }
    
    
    
        func textView(textView: UITextView, shouldChangeTextInRange range: NSRange,
            replacementText text: String) -> Bool {
                if text == "\n" {
                    koment.resignFirstResponder() //キーボードを閉じる
                    return false
                }
                return true
        }
        func segconChanged(segcon: UISegmentedControl){
            
            switch(segcon.selectedSegmentIndex){
            case 0:
                selected = 0
                ketueki = "A"
                NSLog("hello")
            case 1:
                
                selected = 1
                ketueki = "B"
            case 2:
                selected = 2
                ketueki = "O"
            case 3:
                selected = 3
                ketueki = "AB"
            default:
                println("Error")
                
            }
        }
        func textFieldShouldReturn(textField: UITextField!) -> Bool {
            
            self.view.endEditing(true)
            return false
        }


        func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!){
            NSLog("locationManagerよばれた")
            
            
            latitude = (manager.location.coordinate.latitude)
            longitude = (manager.location.coordinate.longitude)
            
//            jushoField.text = "\(manager.location.coordinate.latitude)"
//            koment.text = "\(manager.location.coordinate.longitude)"
            
        }
        
        
        @IBAction func currentPlace(){
            let myAlert: UIAlertController = UIAlertController(title: "注意", message: "現在地から取得した場合、住所が少しずれる場合がありますので手で修正してください", preferredStyle: .Alert)
            
            // OKのアクションを作成する.
            let myOkAction = UIAlertAction(title: "OK", style: .Default) { action in
                println("Action OK!!")
            }
            myAlert.addAction(myOkAction)
            
            // UIAlertを発動する.
            presentViewController(myAlert, animated: true, completion: nil)

            
            myLocationManager = CLLocationManager()
            myLocationManager.desiredAccuracy = kCLLocationAccuracyBest
//            let status = CLLocationManager.authorizationStatus()
            
            // 現在位置の取得を開始.
            NSLog("currentPlaceよばれた")
            let myGeocorder = CLGeocoder()
            
            // locationを作成.
            var myLocation = CLLocation(latitude:latitude , longitude:longitude)
            
            myLocationManager.desiredAccuracy = kCLLocationAccuracyBest
            
            // 逆ジオコーディング開始.
            myGeocorder.reverseGeocodeLocation(myLocation,completionHandler: { (placemarks, error) -> Void in
                
                
                var placemark : CLPlacemark!
                
                for placemark in  placemarks {
                    
                    var address: String = ""
                    
                    
                    address = placemark.administrativeArea != nil ? placemark.administrativeArea : ""
                    address += placemark.locality != nil ? placemark.locality : ""
                    address += placemark.thoroughfare != nil ? placemark.thoroughfare : ""
                    address += placemark.subThoroughfare != nil ? placemark.subThoroughfare : ""
                    
                    
                    //                    address += ","
                    //                    address += placemark.country != nil ? placemark.country : ""
                    self.jushoField.text = address
                    
                    
                    //                    self.myLatitudeLabel.text = "\(placemark.name)"
                }
            })
            
        }
    @IBAction func check(){
        
        
//        
//        imageView.image = facepicture
//        facepicture = UIImage(named:"")
        
        
//        let size = CGSize(width: 60, height: 80)
//        UIGraphicsBeginImageContext(size)
//        picture.drawInRect(CGRectMake(0, 0, size.width, size.height))
//        var resizeImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        let view2: UIImageView = UIImageView(frame: CGRectMake(0,0,150,150))
//        picture = resizeImage
        
        // uidを端末に記録
        NSLog("病院は%@",byoin.text)
        NSUserDefaults.standardUserDefaults().setObject(byoin.text,forKey:"hospital")
        NSUserDefaults.standardUserDefaults().setObject(ka.text,forKey:"currentPlace")
        NSUserDefaults.standardUserDefaults().setObject(jushoField.text,forKey:"address")
        NSUserDefaults.standardUserDefaults().setObject(koment.text,forKey:"comment")
        NSUserDefaults.standardUserDefaults().setObject(name.text,forKey:"name")
        NSLog("最後")
        
    self.performSegueWithIdentifier("check", sender: nil)
    }
    
    @IBAction func take(sender:AnyObject)
    {
        var alert = UIAlertView()
        alert.title = "注意"
        alert.message = "撮影するときは、iPhoneを縦にして撮影してください。\n顔が認識されないときは、いたずらと 認識されます。"
        alert.addButtonWithTitle("OK")
        alert.show()
        //写真を撮影
        println( "onTapButton - take photo" )
        
        if picker==nil {
            return
        }
        //カメラ画をの端末で使えるか？使えるなら以下を実行
        //pickerをカメラにする
        //今のViewControllerをpickerにする
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            picker!.sourceType = UIImagePickerControllerSourceType.Camera
            self.presentViewController(picker!, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        println( "imagePickerController" )
        self.dismissViewControllerAnimated(true, completion: nil)
        picture = image
        
//        if picker!.sourceType == UIImagePickerControllerSourceType.Camera {
//            println( "save photo" )
//            UIImageWriteToSavedPhotosAlbum(image, self, "onSaveImageWithUIImage:error:contextInfo:", nil)
//        }
        }
    
    
    func onSaveImageWithUIImage(image: UIImage!, error: NSErrorPointer, contextInfo: UnsafePointer<()>){
        if (error != nil) {
            println( "error" )
            return
        }
        println( "success" )
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController!){
        
        println( "imagePickerControllerDidCancel" )
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "check") {
                        // SecondViewControllerクラスをインスタンス化してsegue（画面遷移）で値を渡せるようにバンドルする
            var kakuninViewController : KakuninViewController = segue.destinationViewController as KakuninViewController
            kakuninViewController.hospitalNameString = byoin.text
            kakuninViewController.currentPlaceString = ka.text
            kakuninViewController.addressString = jushoField.text
            kakuninViewController.commentString = koment.text
            kakuninViewController.bloodTypeString = ketueki
            kakuninViewController.nameString = name.text
            kakuninViewController.picture = picture
            
        }
    }



//ボタンイベント.

    
    func textFieldDidBeginEditing(textField: UITextField) {

        UIView.animateWithDuration(0.2, delay: 0.0, options: nil, animations: {
            self.view.center = CGPointMake(self.view.center.x, self.view.center.y - 50)
            }, completion: nil)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {

        UIView.animateWithDuration(0.2, delay: 0.0, options: nil, animations: {
            self.view.center = CGPointMake(self.view.center.x, self.view.center.y + 50)
            }, completion: nil)
    }

}