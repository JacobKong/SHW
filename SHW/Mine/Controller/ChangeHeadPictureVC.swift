//
//  ChangeHeadPictureVC.swift
//  SHW
//
//  Created by Zhang on 15/7/29.
//  Copyright (c) 2015年 star. All rights reserved.
//

import UIKit

class ChangeHeadPictureVC: UIViewController {

    @IBOutlet weak var HeadPicture: UIImageView!
    var Picturename:String?
    var customerID :String?
    //声明导航条
    var navigationBar : UINavigationBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.view.backgroundColor = UIColor.whiteColor()
        //宽高
        var pageWidth = self.view.frame.width
        var pageHeight = self.view.frame.height
//        //实例化导航条
//        navigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.width, 64))
//        self.view.addSubview(navigationBar!)
//        println("创建导航条详情")
//        onMakeNavitem()
        

                //        //网络地址获取图片
                //        //1.定义一个地址字符串常量
//                let imageUrlString:String = "http://192.168.0.6:8080/FamilyServiceSystem/customer/facilitator/\(customerID)/\(Picturename)"
//                //2.通过String类型，转换NSUrl对象
//                let url :NSURL = NSURL(string: imageUrlString)!
//                println("url:\(url)")
//                //3.从网络获取数据流
//                if let data:NSData = NSData(contentsOfURL: url){
//                    //4.通过数据流初始化图片
//                    HeadPicture!.image = UIImage(data: data)
//                }else {
        
        HeadPicture!.image = UIImage(named: "touxiang")!
        
        var button = UIButton(frame: CGRectMake(pageWidth/2-125, pageHeight-60, 250, 30))
        button.setTitle("修改并保存", forState: UIControlState.Normal)
        button.backgroundColor = UIColor.orangeColor()
        button.titleLabel?.font = UIFont.systemFontOfSize(14)
        button.showsTouchWhenHighlighted = true
        button.addTarget(self , action: Selector("tapped:"), forControlEvents: UIControlEvents.TouchUpInside)
        button.layer.cornerRadius = 5.0
        self.view.addSubview(button)

         }

        // Do any additional setup after loading the view.
    //}
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
