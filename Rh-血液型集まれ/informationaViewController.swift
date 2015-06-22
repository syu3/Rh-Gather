//
//  informationaViewController.swift
//  Rh-血液型集まれ
//
//  Created by 加藤 周 on 2015/04/24.
//  Copyright (c) 2015年 mycompany. All rights reserved.
//

//viewdidAppearでロード

import UIKit

class informationaViewController: UIViewController {
    @IBOutlet var tableView : UITableView!
    @IBOutlet var addressButton : UIButton!
    @IBOutlet var hospitalNameButton : UIButton!
    var selectValue : Int = 0
    var pictures = [AnyObject]() //後で直そう
    var end : String = ""
    var query:PFQuery = PFQuery()
    var objects = [AnyObject]()
    var refreshControl:UIRefreshControl!
    var number = 0
    var num = -1
    var junban = 0
    var endTheState = ""
    var naiyou = 0
    var number1 = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "引っ張って更新")
        self.refreshControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        
        //        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        self.loadData { (pictures, error) -> () in
            self.pictures = pictures
            self.tableView.reloadData()
        }
    }
    func refresh()
    {
        number = 0
        junban = -1
        num = -1
        number1 = 0
        NSLog("refresh")
        self.loadData { (pictures, error) -> () in
            self.pictures = pictures
            self.tableView.reloadData()
        }
        
        //refreshを終える
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func insertNewObject(sender: AnyObject) {
        objects.insert(NSDate(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
    func loadData(callback:([PFObject]!, NSError!) -> ())  {
        self.refreshControl.endRefreshing()
        NSLog("loadData")
        query = PFQuery(className:"kinkyu")
        query.orderByAscending("createdAt")
        query.findObjectsInBackgroundWithBlock { (objects, error: NSError!) -> Void in
            if (error != nil){
                // エラー処理
            }
            callback(objects as [PFObject], error)
            
            
        }
        
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        num = -1
        number = -1
        junban = -1
        number1 = 0
        NSLog("pictureは%d",pictures.count)
        //numberにpicture.countを入れる
        number = pictures.count
        NSLog("numberは%d",number)
        return pictures.count
    }
    @IBAction func address(){
        NSLog("address")
        addressButton.backgroundColor = UIColor.lightGrayColor()
        hospitalNameButton.backgroundColor = UIColor.whiteColor()
        naiyou = 0
        self.loadData { (pictures, error) -> () in
            self.pictures = pictures
            self.tableView.reloadData()
        }
    }
    @IBAction func hospitalName(){
        NSLog("hospitalName")
        hospitalNameButton.backgroundColor = UIColor.lightGrayColor()
        addressButton.backgroundColor = UIColor.whiteColor()
        naiyou = 1
        self.loadData { (pictures, error) -> () in
            self.pictures = pictures
            self.tableView.reloadData()
        }
    }
    
    //cellの内容を決める
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        num++
        
        NSLog("")
        //picture.countは1からだけど、parseは0からなので、1個減らす
        number1 = number-1
        NSLog("number1は%d",number1)
        
        //picture.countからnumを引く
        //例 : 3(picture.count) - 0 = 3
        junban = number1 - num
        NSLog("junbanは%d",junban)
        
        //picture.countが0だと下が読み込まれない
        var n = number - 1
        if(num > n){
            NSLog("------------------大きい-------------------")
        }else{
        

        
        endTheState = self.pictures[junban].objectForKey("end") as String
        
        if(endTheState == "end"){
            
             cell.backgroundColor = UIColor(red: 0.7, green:0.6 , blue: 0.5, alpha: 1.0)
            
            
        }else{
            cell.backgroundColor = UIColor(red: 1.0, green:0.6 , blue: 0.6, alpha: 1.0)
           
            
        }

        if(junban == 0){
            NSLog("--------------------------------------------------------------------------------")
        }
        
        
        
        if(naiyou == 0){
            cell.textLabel?.text = self.pictures[junban].objectForKey("jusho") as String?
        }else if(naiyou == 1){
            cell.textLabel?.text = self.pictures[junban].objectForKey("byoin") as String?
        }
        
        //とってきた順番をかえる配列の[0]目に入れていく
        
        
        //        NSLog("内容は%@",naiyou!)
        }
        
        return cell
        
    }
    //cellが選ばれた（押された）時
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        NSLog("")
        var index = indexPath.row
        var number1 = number-1
        var junban = number1 - index
        NSLog("junbanは、%d",junban)
        selectValue = junban
        NSLog("Num:%d",selectValue)
        end = self.pictures[junban].objectForKey("end") as String
        
        NSLog("endは%@",end)
        
        NSLog("didselect")
        NSLog("indexPathは%d",indexPath.row)
        
        NSLog("tableViewdeselect")
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.performSegueWithIdentifier("info", sender: nil)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        NSLog("prepare")
        NSLog("selectValueは%d",selectValue)
        if (segue.identifier == "info") {
            // SecondViewControllerクラスをインスタンス化してsegue（画面遷移）で値を渡せるようにバンドルする
            var secondView : johoViewController = segue.destinationViewController as johoViewController
            secondView.endString = end
            secondView.selectValue = selectValue
            NSLog("endは%@、selectValueは%d",end,selectValue)
            
        }
    } 
}
