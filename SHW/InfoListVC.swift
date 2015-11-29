//
//  InfoListVC.swift
//  SHW
//
//  Created by Zhang on 15/7/29.
//  Copyright (c) 2015年 star. All rights reserved.
//

import UIKit

class InfoListVC: UIViewController {

     //声明headPicture
    var headPicture:UIImageView?
    //声明六个button
    var button1 :UIButton?
    var button2 :UIButton?
    var button3 :UIButton?
    var button4 :UIButton?
    var button5 :UIButton?
    var quit :UIButton?
    //读取本地数据
    var customerid:String = ""
    var loginPassword:String = ""
    //存储获取的用户信息
    var info:MyInfo!
    override func viewDidLoad() {
        super.viewDidLoad()
        //读取用户信息，如果不是第一次登录，则会自动登录
        readNSUerDefaults()
        info = QueryInfo(customerid) as MyInfo
        let  width = self.view.frame.width
        let  height = self.view.frame.height
         var headY = CGFloat(80)
         headPicture = UIImageView(frame: CGRectMake(width/2-90, headY, CGFloat(180),CGFloat(150)))
         headPicture!.image = UIImage(named: "touxiang.jpg")!
         self.view.addSubview(headPicture!)
        
        var buttonW = width
       var buttonY = CGFloat(headY+160)
       var buttonH = CGFloat((height-320)/5)
        button1 = UIButton(frame:CGRectMake(0,buttonY,buttonW,buttonH))
        button1!.setTitle("修改头像", forState: UIControlState.Normal)
        button1!.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        button1!.setBackgroundImage(UIImage(named: "listBackground"), forState: UIControlState.Normal)
        //button1!.backgroundColor = UIColor.orangeColor()
        button1!.titleLabel!.font = UIFont.systemFontOfSize(16)
        button1!.addTarget(self , action: Selector("JumpTo1"), forControlEvents: UIControlEvents.TouchUpInside)
        button1?.hidden = true
        self.view.addSubview(button1!)
        button2 = UIButton(frame:CGRectMake(0,buttonY+buttonH,buttonW,buttonH))
        button2!.setTitle("基本资料", forState: UIControlState.Normal)
        button2!.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        button2!.setBackgroundImage(UIImage(named: "listBackground"), forState: UIControlState.Normal)
        //button1!.backgroundColor = UIColor.orangeColor()
        button2!.titleLabel!.font = UIFont.systemFontOfSize(16)
        button2!.addTarget(self , action: Selector("JumpTo2"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button2!)
        button3 = UIButton(frame:CGRectMake(0,buttonY+2*buttonH,buttonW,buttonH))
        button3!.setTitle("修改密码", forState: UIControlState.Normal)
        button3!.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        button3!.setBackgroundImage(UIImage(named: "listBackground"), forState: UIControlState.Normal)
        //button1!.backgroundColor = UIColor.orangeColor()
        button3!.titleLabel!.font = UIFont.systemFontOfSize(16)
        button3!.addTarget(self , action: Selector("JumpTo3"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button3!)
//        button4 = UIButton(frame:CGRectMake(0,buttonY+3*buttonH,buttonW,buttonH))
//        button4!.setTitle("通用设置", forState: UIControlState.Normal)
//        button4!.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
//        button4!.setBackgroundImage(UIImage(named: "listBackground"), forState: UIControlState.Normal)
//        //button1!.backgroundColor = UIColor.orangeColor()
//        button4!.titleLabel!.font = UIFont.systemFontOfSize(16)
//        button4!.addTarget(self , action: Selector("JumpTo4"), forControlEvents: UIControlEvents.TouchUpInside)
//        self.view.addSubview(button4!)
//        button5 = UIButton(frame:CGRectMake(0,buttonY+4*buttonH,buttonW,buttonH))
//        button5!.setTitle("关于软件", forState: UIControlState.Normal)
//        button5!.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
//        button5!.setBackgroundImage(UIImage(named: "listBackground"), forState: UIControlState.Normal)
//        //button1!.backgroundColor = UIColor.orangeColor()
//        button5!.titleLabel!.font = UIFont.systemFontOfSize(16)
//        button5!.addTarget(self , action: Selector("JumpTo5"), forControlEvents: UIControlEvents.TouchUpInside)
//        self.view.addSubview(button5!)
        var quitX = CGFloat((width-250)/2)
        quit = UIButton(frame:CGRectMake(quitX,height-60,250,30))
        quit!.setTitle("退出当前登录", forState: UIControlState.Normal)
        quit!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        quit!.backgroundColor = UIColor.orangeColor()
        quit!.layer.cornerRadius = 5
        quit!.titleLabel!.font = UIFont.systemFontOfSize(17)
        quit!.addTarget(self , action: Selector("JumpTo6"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(quit!)
    }
    //跳转函数
    func JumpTo1(){
            self.performSegueWithIdentifier("toHeadPicture", sender: self)
    }
    func JumpTo2(){
        self.performSegueWithIdentifier("toBaseInfo", sender: self)
    }
    func JumpTo3(){
        self.performSegueWithIdentifier("toChangePassword", sender: self)
    }
    func JumpTo4(){
        //self.performSegueWithIdentifier("toBaseInfo", sender: self)
    }
    func JumpTo5(){
        //self.performSegueWithIdentifier("toBaseInfo", sender: self)
    }
    func JumpTo6(){
        removeNSUerDefaults()
         self.performSegueWithIdentifier("toQuit", sender: self)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     //从NSUerDefaults 中读取数据
    func readNSUerDefaults () {
        
        var userDefaultes = NSUserDefaults.standardUserDefaults()
        if  (userDefaultes.stringForKey("customerID")) != nil && (userDefaultes.stringForKey("loginPassword")) != nil{
            customerid = userDefaultes.stringForKey("customerID")!
            loginPassword = userDefaultes.stringForKey("loginPassword")!
            
        }
        
    }
//    //清除NSUerDefaults中数据
    func removeNSUerDefaults () {
        
        //将数据全部存储到NSUerDefaults中
        var userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        //存储时，除了NSNumber类型使用对应的类型外，其他的都使用setObject:forKey:
        userDefaults.setObject("" , forKey: "customerID")
        userDefaults.setObject("", forKey: "loginPassword")
         
        //建议同步到磁盘，但不是必须得
        userDefaults.synchronize()
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier! == "toHeadPicture" {
            let controller = segue.destinationViewController as! ChangeHeadPictureVC
            var  object = info.headPicture
            var   customerid = info.customerID
            controller.Picturename = object
            controller.customerID = customerid
            
        }else if segue.identifier! == "toChangePassword" {
            let controller = segue.destinationViewController as! ChangePasswordVC
            var  object = info.loginPassword
            var  Id = info.id
            controller.Password = object
            controller.id = Id
            
        }

    }
            
}















