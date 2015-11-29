//
//  PackaVC.swift
//  SHW
//
//  Created by Zhang on 15/8/13.
//  Copyright (c) 2015年 star. All rights reserved.
//

import UIKit

class PackageVC: UIViewController,UITableViewDataSource,UITableViewDelegate,JSDropDownMenuDelegate,JSDropDownMenuDataSource{
    
    
    
    var FirstType:String?//选择的大类
    //var SecondType:String?//会有的小类
    var status = true
    //声明导航条
    var navigationBar : UINavigationBar?
    //声明右边按钮
    var rightButton =  UIBarButtonItem()
    //声明label
    //var label :UILabel?
    //声明地址
    var location:String = ""

    //change by LZF
    var data12:[String] = []
    var data1:[String] = ["区域不限"]
    var data11:[String] = [""]
    var data21:[String] = []//存类型
    var data3 = []
    var data31 = []
     var data4 = []
    var currentData1Index : Int = 0
    var currentData2Index : Int = 0
    var currentData3Index : Int = 0
    var isPerson =  1 //声明点击店家还是人员
    var facilitatorCounty = ""//区域筛选
    var SecondType = ""//会有的小类
    var attributeName = "" //排序
    var upDown = "asc"
    //存储类型数据
    var serviceTypeData:[ServiceType]=[]
    var PackageItemInfo:[serviceItemInfo]=[]
    var data2:[String] = []//存类型
    
    var Person:[String] = []
    //筛选和排序
    var column0 = 0
    var  row0   =  0
    var column1 = 1
    var  row1  = 0
    var column2 = 2
    var  row2  = 0
    var  n = 0
    @IBOutlet weak var Table: UITableView!
    @IBOutlet weak var label: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        println(FirstType)
        var width = self.view.frame.width
        
//        
//        //实例化导航条
//        navigationBar = UINavigationBar(frame: CGRectMake(0, 0, width, 64))
//        self.view.addSubview(navigationBar!)
//        println("创建导航条详情B")
//        onMakeNavitem()
        
        Table.dataSource = self
        Table.delegate = self
        
        //读取本地存储的地址
        readNSUerDefaults()
        serviceTypeData = refreshServiceType(FirstType!) as![ServiceType]
        
        for var i = 0;i < serviceTypeData.count;i++ {
            
//            data5 += [serviceTypeData[i].typeName] // 小类名称
            Person +=  [serviceTypeData[i].isPerson]
            
        }
        
        for var i = 0;i < Person.count;i++ {
            if Person[i] == "0" {
            data2 += [serviceTypeData[i].typeName] // 小类名称
            }
          
            
        }

        
        SecondType  = data2[row1]
        
        PackageItemInfo =  getPackage(SecondType,attributeName,upDown,facilitatorCounty) as! [serviceItemInfo]
   
        
  
        
        //change by LZF
        data12 = queryCounty(location) as! [String]
        data1 += data12
        data11 += data12
        
        data3 = ["默认排序","价格由低到高","价格由高到低"]
        data31 = ["","priceDescription","priceDescription"]
        data4 = ["","asc","desc"]
        
        var menu = JSDropDownMenu(origin: label.frame.origin, andHeight: label.frame.size.height)
        menu.indicatorColor = UIColor(red: 175.0/255.0, green: 175.0/255.0, blue: 175.0/255.0, alpha: 1.0)
        menu.separatorColor = UIColor(red: 210.0/255.0, green: 210.0/255.0, blue: 210.0/255.0, alpha: 1.0)
        menu.textColor = UIColor(red: 83.0/255.0, green: 83.0/255.0, blue: 83.0/255.0, alpha: 1.0)
        menu.dataSource = self;
        menu.delegate = self;
        
        label.removeFromSuperview()
        self.view.addSubview(menu)
        
    }
    
    override func viewDidLayoutSubviews() {
        var width = self.view.frame.width
         Table.frame =  CGRectMake(0, 100, width, self.view.frame.height)
    }
    
    
    //-------------------Table view data source-----------------------------
    // 根据indexPath(section,row)创建每行cell及其内容
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //            //创建cell
        println("创建cell")
        var cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCell
        
            let business = PackageItemInfo[indexPath.row] as serviceItemInfo
            cell.name.text = business.itemName//名称
            cell.address.text = business.facilitatorName//商户
            //cell.rank.image = imageForRank(business.facilitatorLevel)
            //        //网络地址获取图片
            //        //1.定义一个地址字符串常量
          let imageUrlString:String = HttpData.http+"/FamilyServiceSystem/upload/service/\(business.id)/\(business.servicePicture)"
            //2.通过String类型，转换NSUrl对象
//            let url :NSURL = NSURL(string: imageUrlString)!
//            println("url:\(url)")
//            //3.从网络获取数据流
//            if let data:NSData = NSData(contentsOfURL: url){
//                //4.通过数据流初始化图片
//                cell.picture!.image = UIImage(data: data)
//            }else {
//                
//                cell.picture!.image = UIImage(named: "1211.jpg")!
//            }
//        var data = getImageData(imageUrlString)
//        
//        if data == nil{
//            println(data)
//            cell.picture.image = UIImage(named: "1211.jpg")
//            //                            cell.picture.image = UIImage(data: data!)
//        }else{
//            //                            cell.picture.image = UIImage(named: "122.jpg")
//            cell.picture.image = UIImage(data: data!)
//            
//        }
        cell.picture.setZYHWebImage(imageUrlString, defaultImage: "1211.jpg")

//            cell.officePhone.text = business.serviceType
//            cell.businessArea.text = "\(business.priceDescription)元" //价格
//            cell.dizhi.text = "所属店铺:"
//            cell.dianhua.text = "服务类别:"
//            cell.quyu.text = "价格:"
    
        return cell
    }
    
    
    //导航条详情
    func reply (){
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
 
    
    
    func onMakeNavitem() -> UINavigationItem{
        println("创建导航条step1b")
        //创建一个导航项
        var navigationItem = UINavigationItem()
        //创建左边.右边按钮
        var leftButton =  UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Reply, target: self, action: "reply")
        //var rightButton =  UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Undo, target: self, action: "reply")
        //rightButton.title = "返回商家"
     
        //导航栏的标题
        navigationItem.title = "一口价列表"
        
        //设置导航栏左边按钮
        navigationItem.setLeftBarButtonItem(leftButton, animated: true)
        // navigationItem.setRightBarButtonItem(rightButton, animated: true)
        navigationBar?.pushNavigationItem(navigationItem, animated: true)
        
        
        return navigationItem
    }
    
    //        func imageForRank(rank:Int) -> UIImage? {
    //        switch rank {
    //        case 1:
    //            return UIImage(named: "1")
    //        case 2:
    //            return UIImage(named: "2")
    //        case 3:
    //            return UIImage(named: "3")
    //        case 4:
    //            return UIImage(named: "4")
    //        case 5:
    //            return UIImage(named: "5")
    //        default:
    //            return nil
    //        }
    //    }
    // Return the number of sections.
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;//HttpData.channelTitles.count
    }
    
    // Return the number of rows in the section.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
         return PackageItemInfo.count
        
    }
    
    
    
    
    //-------------------Table view delegate-----------------------------
    //cell响应事件
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        if isPerson == 0 {
//            println("去商家详情2")
//            self.performSegueWithIdentifier("toBDetail", sender: self)
//            println("去商家详情")
//        }else if isPerson == 1 {
//            println("去人员详情1")
//            self.performSegueWithIdentifier("toServantDetail", sender: self)
//            println("去人员详情")
//        }
//        
//        
//    }
    
    
    
    //change by LZF
    func numberOfColumnsInMenu(menu: JSDropDownMenu!) -> Int
    {
        return 3
    }
    
    func displayByCollectionViewInColumn(column: Int) -> Bool
    {
        return false;
    }
    
    func haveRightTableViewInColumn(column: Int) -> Bool
    {
        return false;
    }
    
    func widthRatioOfLeftColumn(column: Int) -> CGFloat
    {
        return 1;
    }
    
    func currentLeftSelectedRow(column: Int) -> Int
    {
        if (column==0) {
            
            return currentData1Index;
            
        }
        if (column==1) {
            
            return currentData2Index;
        }
        
        return 0;
    }
    
    func menu(menu: JSDropDownMenu!, numberOfRowsInColumn column: Int, leftOrRight: Int, leftRow: Int) -> Int {
        
        if (column==0) {
            return data1.count;
        } else if (column==1){
            
            return data2.count;
            
        } else if (column==2){
            
            return data3.count;
        }
        
        return 0;
    }
    
    func menu(menu: JSDropDownMenu!, titleForColumn column: Int) -> String! {
        
        switch (column) {
        case 0:
            return data1[0] as String
            break
        case 1:
            return data2[0]as String
            break
        case 2:
            return data3[0] as! String
            break
        default:
            return nil
            break
        }
    }
    
    func menu(menu: JSDropDownMenu!, titleForRowAtIndexPath indexPath: JSIndexPath!) -> String! {
        
        if (indexPath.column==0) {
            return data1[indexPath.row] as String
        } else if (indexPath.column==1) {
            
            return data2[indexPath.row] as String
            
        } else {
            
            return data3[indexPath.row] as! String
        }
    }
    //点击触发
    
    func menu(menu: JSDropDownMenu!, didSelectRowAtIndexPath indexPath: JSIndexPath!) {
        
        println("\(indexPath.column),\(indexPath.row)")
        
        if (indexPath.column == 0) {
            currentData1Index = indexPath.row
            column0 = 0
            row0   =  indexPath.row
            println()
            
            
        } else if(indexPath.column == 1){
            
            currentData2Index = indexPath.row;
            row1   =  indexPath.row
            println("点击完了")
            
        } else{
            currentData3Index = indexPath.row;
            row2   =  indexPath.row
        }
        
        facilitatorCounty = data11[row0] as String
        SecondType  = data2[row1]
        attributeName = data31[row2] as! String
        upDown = data4[row2] as! String
        
        PackageItemInfo =  getPackage(SecondType,attributeName,upDown,facilitatorCounty) as! [serviceItemInfo]
        Table .reloadData()
        println("开始刷新")
            
        }
        

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    //从NSUerDefaults 中读取数据
    func readNSUerDefaults () {
        
        var userDefaultes = NSUserDefaults.standardUserDefaults()
        
        if  (userDefaultes.stringForKey("location")) != nil{
            location = userDefaultes.stringForKey("location")!
            println(location)
        }
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        println("跳转传递数据")
        
            if let indexPath = self.Table.indexPathForSelectedRow(){
                var  object = PackageItemInfo[indexPath.row] as serviceItemInfo
                (segue.destinationViewController as! PackageItemVC).CommonItem = object
                println("商家列表结束了")
            
        }
        
        
    }
    
}
