   //
//  BusinessVC.swift
//  SHW
//
//  Created by Zhang on 15/6/4.
//  Copyright (c) 2015年 star. All rights reserved.
//

import UIKit

class BusinessVC:  UIViewController,UITableViewDataSource,UITableViewDelegate,JSDropDownMenuDelegate,JSDropDownMenuDataSource{
 
    
    
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
    //声明一个去一口价的BUtton
    var writing = UIButton()
    //change by LZF
     var data12:[String] = []
    var data1:[String] = ["区域不限"]
    var data11:[String] = [""]
     var data21:[String] = []//存类型
    var data3 = []
    var data31 = []
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
    @IBOutlet weak var businessTable: UITableView!
    //声明一个数组businesss来保存获取的信息
     var ServantData:[ServantInfo] = []
    var selectbusiness:[facilitatorInfo] = []
    // var ServantData = []
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            var width = self.view.frame.width
            var height = self.view.frame.height
            businessTable.dataSource = self
            businessTable.delegate = self
             //实例化导航条
            navigationBar = UINavigationBar(frame: CGRectMake(0, 0, width, 64))
            self.view.addSubview(navigationBar!)
            println("创建导航条详情B")
            onMakeNavitem()
    
        
            //读取本地存储的地址
            readNSUerDefaults()
            serviceTypeData = refreshServiceType(FirstType!) as![ServiceType]
        
            for var i = 0;i < serviceTypeData.count;i++ {
            data2 += [serviceTypeData[i].typeName] // 小类名称
            Person +=  [serviceTypeData[i].isPerson]
            }
        
            SecondType  = data2[row1]
        
           if  Person[0] == "1" {
            ServantData = refreshServant(SecondType,attributeName,upDown,facilitatorCounty) as! [ServantInfo]
            isPerson =  1
            data3 = ["默认排序","人员星级"]
            data31 = ["","servantScore"]
            writing.enabled = false
            writing.hidden = true
            
         }else
//            if serviceTypeData[0].isPerson == "0"
            {
            
            selectbusiness = refreshFacilitator(SecondType,attributeName,upDown,facilitatorCounty) as! [facilitatorInfo]
            isPerson =  0
            data3 = ["默认排序","点击次数由高到低","信用评分由高到低"]
            data31 = ["","clientClick","creditScore"]
            writing.enabled = true
            writing.hidden = true
            }
        //change by LZF
        //data1 = ["区域不限","和平区","大东区","沈河区","皇姑区","铁西区","浑南区","于洪区","沈北新区","苏家屯区","新民市","辽中县","康平县","法库县"]
        
          println("location\(location)")
          data12 = queryCounty(location) as! [String]
          data1 += data12
          println(data1)
        //data11 = ["","和平区","大东区","沈河区","皇姑区","铁西区","浑南区","于洪区","沈北新区","苏家屯区","新民市","辽中县","康平县","法库县"]
          data11 += data12
//          data21 =  data2
        
        var menu = JSDropDownMenu(origin: label.frame.origin, andHeight: label.frame.size.height)
        menu.indicatorColor = UIColor(red: 175.0/255.0, green: 175.0/255.0, blue: 175.0/255.0, alpha: 1.0)
        menu.separatorColor = UIColor(red: 210.0/255.0, green: 210.0/255.0, blue: 210.0/255.0, alpha: 1.0)
        menu.textColor = UIColor(red: 83.0/255.0, green: 83.0/255.0, blue: 83.0/255.0, alpha: 1.0)
        menu.dataSource = self;
        menu.delegate = self;
        label.removeFromSuperview()
        self.view.addSubview(menu)
        
        writing = UIButton(frame: CGRect(x: width-100, y: height-70, width: 100, height:50))
        var background  = UIImage(named: "u4")
        writing.setBackgroundImage(background, forState: UIControlState.Normal)
        writing.setTitle("去一口价", forState: UIControlState.Normal)
        writing.titleLabel?.font = UIFont.systemFontOfSize(16)
        //writing.titleLabel!.textAlignment =  NSTextAlignment.Left
        //设置按钮中Title的位置
        writing.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        writing.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 10, 10);
        writing.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        writing.showsTouchWhenHighlighted = true
        writing.addTarget(self , action: Selector("package"), forControlEvents: UIControlEvents.TouchUpInside)
        println("点击一口价")
        if  Person[row1] == "1" {
            writing.enabled = false
            writing.hidden = true
            
        }else{
            writing.enabled = true
            writing.hidden = false
        }

        self.view.addSubview(writing)
        
        }
    
    override func viewDidLayoutSubviews() {
        var width = self.view.frame.width
        businessTable.frame =  CGRectMake(0, 100, width, self.view.frame.height-100)
    }
    
    
        //-------------------Table view data source-----------------------------
        // 根据indexPath(section,row)创建每行cell及其内容
 
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //            //创建cell
                    println("创建cell")
                    var cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCell
                    if isPerson == 0 {
        
                        let business = selectbusiness[indexPath.row] as facilitatorInfo
                        cell.name.text = business.facilitatorName//名称
                        cell.address.text = "\(business.creditScore)分 " //信用评分

                        
                        //cell.rank.image = imageForRank(business.facilitatorLevel)
                        //网络地址获取图片
                        //1.定义一个地址字符串常量
                        let imageUrlString:String = HttpData.http+"/FamilyServiceSystem\(business.facilitatorLogo)"
                        println("imageUrlString\(imageUrlString)")
//                        //2.通过String类型，转换NSUrl对象
//                        let url :NSURL = NSURL(string: imageUrlString)!
//                        println("url:\(url)")
//                        //3.从网络获取数据流
//                        if let data:NSData = NSData(contentsOfURL: url){
//                            //4.通过数据流初始化图片
//                            cell.picture!.image = UIImage(data: data)
//                        }else {
//                            
//                            cell.picture!.image = UIImage(named: "reserve2.jpg")!
//                        }
////                         var image = HYBLoadingImageView()
//
                       // cell.picture?.loadImage(imageUrlString, holder: "reserve2.jpg")
//                        cell.picture?.setZYHWebImage(imageUrlString, defaultImage: "", isCache: false)
                       
//                        var data = getImageData(imageUrlString)
//                        if data == nil{
//                            cell.picture.image = UIImage(named: "reserve2.jpg")
//                        }else{
//                            cell.picture.image = UIImage(data: data!)
//
//                            
//                        }
                      cell.picture.setZYHWebImage(imageUrlString, defaultImage: "reserve2.jpg")
                        cell.officePhone.text =   business.contactAddress//地址               
                        cell.businessArea.text = business.contactPhone
                        cell.dizhi.text = "信用评分:"
                      
                        cell.dianhua.text =  "联系地址:"
                        cell.quyu.text = "办公电话:"
                    }else if isPerson == 1 {
        
                        let business = ServantData[indexPath.row] as ServantInfo
                        cell.name.text = business.servantName //名称
                        cell.address.text = business.facilitatorName//所属公司
                        
                        //cell.rank.image = imageForRank(business.facilitatorLevel)
                        //网络地址获取图片
                        //1.定义一个地址字符串常量
                        let imageUrlString:String = HttpData.http+"/FamilyServiceSystem/upload/servant/\(business.id)/\(business.headPicture)"
                        //2.通过String类型，转换NSUrl对象
//                        let url :NSURL = NSURL(string: imageUrlString)!
//                        println("url:\(url)")
//                        //3.从网络获取数据流
//                        if let data:NSData = NSData(contentsOfURL: url){
//                            //4.通过数据流初始化图片
////
//                            cell.picture!.image = UIImage(data: data)
//                        }else {
//                            
//                             cell.picture!.image = UIImage(named: "122.jpg")!
//                        }
                    
//                        var data = getImageData(imageUrlString)
//                        
//                        if data == nil{
//                            println(data)
//                            cell.picture.image = UIImage(named: "122.jpg")
////                            cell.picture.image = UIImage(data: data!)
//                        }else{
////                            cell.picture.image = UIImage(named: "122.jpg")
//                            cell.picture.image = UIImage(data: data!)
//
//                        }
                        cell.picture.setZYHWebImage(imageUrlString, defaultImage: "122.jpg")

                        cell.officePhone.text = "\(business.servantScore)分"
                        cell.businessArea.text = "\(business.workYears)年"
                        cell.dizhi.text = "所属店铺:"
                        cell.dianhua.text = "人员评分:"
                        cell.quyu.text = "从业年限:"
        }
                    return cell
    }
    
    
    //导航条详情
    func reply (){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func package (){
      println("package")
     self.performSegueWithIdentifier("toPackage", sender: self)
        
    }
    
    
    func onMakeNavitem() -> UINavigationItem{
        println("创建导航条step1b")
        //创建一个导航项
        var navigationItem = UINavigationItem()
        //创建左边.右边按钮
        var leftButton =  UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Reply, target: self, action: "reply")
        //rightButton =  UIBarButtonItem(title: "筛选", style: UIBarButtonItemStyle.Bordered, target: self, action: "selection")
        //导航栏的标题
        navigationItem.title = "服务列表"
        //设置导航栏左边按钮
        navigationItem.setLeftBarButtonItem(leftButton, animated: true)
        //navigationItem.setRightBarButtonItem(rightButton, animated: true)
        navigationBar?.pushNavigationItem(navigationItem, animated: true)
        return navigationItem
    }
    func selection() {
        
    }
 
        // Return the number of sections.
        func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            return 1;//HttpData.channelTitles.count
        }
        
        // Return the number of rows in the section.
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         var  count = 0
        if isPerson == 0 {
        //返回商家数量作为表格的行数
         count = selectbusiness.count;
                            
        }else if isPerson == 1 {
            //返回人员数量作为表格的行数
          count =   ServantData.count;

           }
        return count
        
    }
    
  
    

        
        //-------------------Table view delegate-----------------------------
        //cell响应事件
        func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            if isPerson == 0 {
                   println("去商家详情2")
                self.performSegueWithIdentifier("toBDetail", sender: self)
                println("去商家详情")
            }else if isPerson == 1 {
                   println("去人员详情1")
                 self.performSegueWithIdentifier("toServantDetail", sender: self)
               println("去人员详情")
            }

            
        }

 
    
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
            return data2[0] as String
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
            if  serviceTypeData[row1].isPerson == "1"{
                data3 = ["默认排序","人员星级"]
                data31 = ["","servantScore"]

                rightButton.title = ""
                writing.enabled = false
                writing.hidden = true
                
            }else  {
                data3 = ["默认排序","点击次数由高到低","信用评分由高到低"]
                data31 = ["","clientClick","creditScore"]

                writing.enabled = true
                writing.hidden = false
                
            }
        } else{
            currentData3Index = indexPath.row;
            row2   =  indexPath.row
        }
 
        facilitatorCounty = data11[row0] as String
        SecondType  = data2[row1]
        attributeName = data31[row2] as! String
//        if  serviceTypeData[row1].isPerson == "1"{ 
        if  Person[row1]  == "1"{
             isPerson =  1
            println("人")
          ServantData = refreshServant(SecondType,attributeName,upDown,facilitatorCounty) as! [ServantInfo]
            
            businessTable .reloadData()
            writing.enabled = false
            writing.hidden = true
        }else {
             isPerson =  0
            println("商家")
            selectbusiness = refreshFacilitator(SecondType,attributeName,upDown,facilitatorCounty) as! [facilitatorInfo]
              println("获取数据")
            println(selectbusiness)
            businessTable .reloadData()
            writing.enabled = true
            writing.hidden = false
              println("开始刷新")
          
        }
 
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
        if segue.identifier=="toBDetail"{
            if let indexPath = self.businessTable.indexPathForSelectedRow(){
                var  object = selectbusiness[indexPath.row].facilitatorID
                (segue.destinationViewController as! BusinessDVC).facilitatorid = object
                println("商家列表结束了")
            }
        }else if segue.identifier=="toServantDetail"{
            if let indexPath = self.businessTable.indexPathForSelectedRow(){
                var  object = ServantData[indexPath.row]
                println("人员详情")
                (segue.destinationViewController as! workerViewController).workerdetail = object
                println("人员详情")
            }
        }else if segue.identifier=="toPackage"{
                var  object = FirstType
                  println("package")
                   (segue.destinationViewController as! PackageVC).FirstType = object
    
        }
   }
    
}
