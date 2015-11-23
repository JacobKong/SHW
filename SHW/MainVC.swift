//
//  MainVC.swift
//  生活网/Users/zhang/Desktop/ Learn IOS/生活网/生活网/CollectionViewController.swift
//
//  Created by Zhang on 15/5/17.
//  Copyright (c) 2015年 Zhang. All rights reserved.
//

import UIKit
//import CoreLocation


class MainVC: UIViewController , UITableViewDelegate,
    UIScrollViewDelegate,UIAlertViewDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate{
    
    //用于定位服务管理类，它能够给我们提供位置信息和高度信息，也可以监控设备进入或离开某个区域，还可以获得设备的运行方向
 
    var imgLabel:UILabel!
    var urlSelected:String = ""
    var titleOfState:String = ""
    var AdvertiseDatas:[HomeAdvertise]=[]
     var range:NSArray = []
    var location:String = "当前城市"
 
 
     var customerid:String =  ""
    var loginPassword:String = ""
    
 
    //IB控件绑定
   
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var ButtonScroll: UIScrollView!
    @IBOutlet weak var pageCtrl: UIPageControl!
 
    @IBOutlet weak var lead: UILabel!
    @IBOutlet weak var shouye: UILabel!
 
    //详细界面属性
    var detailView:UIView!
    var webView:UIWebView!
    var LocationB = UIButton()
    var _data:NSData?
    var imageUrlString:NSString?
 
    var img:UIImage?
    var termImg:UIImage?
    /// 定位服务
    var locationService: BMKLocationService!
    /// 当前用户位置
    var userLocation: BMKUserLocation!
    /// 地理位置编码
    var geocodeSearch: BMKGeoCodeSearch!
    //初始化
    var  FirstTypeData:[ServiceType] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 定位功能初始化
         locationService = BMKLocationService()
        // 设置定位精确度，默认：kCLLocationAccuracyBest
        BMKLocationService.setLocationDesiredAccuracy(kCLLocationAccuracyBest)
         println("进入定位状态")
        //指定最小距离更新(米)，默认：kCLDistanceFilterNone
        BMKLocationService.setLocationDistanceFilter(10)
        println("进入定位状态1111")
        locationService.startUserLocationService()
        // 地理编码器初始化
        geocodeSearch = BMKGeoCodeSearch()
    

        AdvertiseDatas = refreshAdvertise() as! [HomeAdvertise]
        FirstTypeData  = refreshParentType("") as! [ServiceType]
     
        
 
        //读取用户信息，如果不是第一次登录，则会自动登录
          readNSUerDefaults()
      
        //var bounds:CGRect = self.view.bounds
        var leadheight = self.view.bounds.height*0.11
        var scrollviewheight = self.view.bounds.height*0.27
        var pageCtrly = leadheight + scrollviewheight-self.view.bounds.height*0.03
        var pageCtrlheight = 37
        var ButtonScrolly = pageCtrly + CGFloat(pageCtrlheight)-5
        var ButtonScrollheight = self.view.bounds.height*0.53
        var lastheight = self.view.bounds.height*0.09
    
        
        var tianqi = UIButton(frame: CGRect(x: 50, y: leadheight-35, width: 30, height:30))
        self.view.addSubview(tianqi)
       
        //self.scrollView = UIScrollView(frame: CGRectMake(0, leadheight, bounds.width, bounds.height*0.245))
        //1.设置图片UIScrollView
       // scrollView.contentSize =  CGSize(width: bounds.width * CGFloat(range.count), height: bounds.height*0.27)
        scrollView.contentSize =  CGSize(width: self.view.bounds.width * CGFloat(AdvertiseDatas.count), height: self.view.bounds.height*0.27)
        scrollView.pagingEnabled = true  //设true时，会按页滑动
        scrollView.bounces = false  //取消UIScrollView的弹性属性，这个可以按个人喜好来定
        scrollView.delegate = self //UIScrollView的delegate函数在本类中定义
        scrollView.showsHorizontalScrollIndicator = false//因为我们使用UIPageControl表示页面进度，所以取消UIScrollView自己的进度条。
        println(location)
        
       // LocationB.titleLabel?.text = location
        LocationB = UIButton(frame: CGRect(x: 20, y: leadheight-30, width: 100, height:23))
        LocationB.titleLabel?.font = UIFont.systemFontOfSize(15)
        LocationB.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        LocationB.setTitle(location, forState: UIControlState.Normal)
        LocationB.addTarget(self, action: "toLocation:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(LocationB)
        
        
        
       //2.设置图片滚动
        
        println("图片")
        for var i = 0; i < AdvertiseDatas.count; i++ {
            println("数目：\(AdvertiseDatas.count)")
        
            var imgView:UIButton = UIButton(frame: CGRect(x: self.view.bounds.width*CGFloat(i), y:0, width: self.view.bounds.width, height: self.view.bounds.width*0.45) )

            //网络地址获取图片
//            //1.定义一个地址字符串常量
             imageUrlString = HttpData.http+"/FamilyServiceSystem/upload/ad/\(AdvertiseDatas[i].id)/\(AdvertiseDatas[i].advertisePicture)"
//            //let imageUrlString:String = "http://192.168.1.101:8080/FamilyServiceSystem/upload/ad/\(AdvertiseDatas[i].id)/\(range[0])"
//            //2.通过String类型，转换NSUrl对象
           
             println("url:\(imageUrlString)")
//            let url :NSURL = NSURL(string: imageUrlString! as String)!
             let url:NSString = imageUrlString!.URLEncodedString()
 
            var data = getImageData(url as String)
            if data == nil{
                img = UIImage(named: HttpData.imgArray[i])
           
            }else{
                img = UIImage(data: data!)
            }
           imgView.setBackgroundImage(img, forState: UIControlState.Normal)

 
          
            scrollView.addSubview( imgView )
              urlSelected = AdvertiseDatas[pageCtrl.currentPage].facilitatorID
            if urlSelected != ""{
            imgView.addTarget(self, action:"clickImg:" , forControlEvents: UIControlEvents.TouchUpInside)
            }
            
         
        }

        //3.添加图片标题
//        imgLabel = UILabel(frame: CGRect(x:0, y: leadheight+self.view.bounds.height*0.27-35, width: self.view.bounds.width, height: 30))
//        imgLabel.backgroundColor = UIColor.whiteColor()
//        imgLabel.alpha = 0.5
//        self.view.addSubview(imgLabel )
//        imgLabel.text = AdvertiseDatas[0].signName
//        //imgLabel.text = "hao"
        
            //4.创建UIPageControl
            //pageCtrl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 400, bounds.size.width, 30)];  //创建UIPageControl，位置在屏幕最下方。
            pageCtrl.numberOfPages = AdvertiseDatas.count;//总的图片页数
            pageCtrl.currentPage = 0; //当前页
            pageCtrl.pageIndicatorTintColor = UIColor.grayColor()
            pageCtrl.currentPageIndicatorTintColor = UIColor.redColor()
            pageCtrl.addTarget(self, action:"pageTurn:" ,forControlEvents:UIControlEvents.ValueChanged) //用户点击UIPageControl的响应函数
            //[self.view addSubview:pageCtrl];  //将UIPageControl添加到主界面上。
        
        //5.设置定时器（滑动切换图片）
        var timer = NSTimer.scheduledTimerWithTimeInterval(3.5, target: self, selector: "timerFireMethod:", userInfo: nil, repeats:true);
        println( "end viewDidLoad" )
        
             //创建buttonScroll
        //创建buttonScroll
        let terms =  FirstTypeData.count
        let a = terms%3
        if a == 0 {
            ButtonScroll.contentSize = CGSizeMake(self.view.bounds.width, CGFloat(terms/3)*((ButtonScrollheight-4)/3+2))}
        else{
            ButtonScroll.contentSize = CGSizeMake(self.view.bounds.width, CGFloat(terms/3+1)*((ButtonScrollheight-4)/3+2))
        }
 
            ButtonScroll.pagingEnabled = false
            ButtonScroll.delegate = self
            ButtonScroll.showsHorizontalScrollIndicator = false
            ButtonScroll.showsVerticalScrollIndicator = false
            ButtonScroll.bounces = false
            self.automaticallyAdjustsScrollViewInsets = false
        
        //创建button
        var button1C = UIColor  (red: 204/255, green: 255/255, blue: 0/255, alpha: 1.0)
        var button2C = UIColor(red: 1.0, green: 153/255, blue: 102/255, alpha: 1.0)
        var button3C = UIColor(red: 204/255, green: 204/255, blue: 255/255, alpha: 1.0)
        var button4C = UIColor(red: 1.0, green: 153/255, blue: 153/255, alpha: 1.0)
        var button5C = UIColor(red: 153/255, green: 204/255, blue: 255/255, alpha: 1.0)
        var button6C = UIColor(red: 255/255, green: 153/255, blue: 204/255, alpha: 1.0)
        var button7C = UIColor(red: 255/255, green: 204/255, blue: 0/255, alpha: 1.0)
        var button8C = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0)
        var button9C = UIColor(red: 102/255, green: 204/255, blue: 255/255, alpha: 1.0)
        var color = [button1C,button2C,button3C,button4C,button5C,button6C,button7C,button8C,button9C]
     
        
        var width = (self.view.bounds.width-20)/3
      
        // mainatwo的button
        var i:Int = 0 ;
        for i = 0;i < terms;i++ {
            let term1 = UIButton(frame: CGRectMake(8+(width+2)*CGFloat(i%3),CGFloat(i/3)*((ButtonScrollheight-4)/3+2), width,(ButtonScrollheight-4)/3))
            term1.titleColorForState(UIControlState.Normal)
            term1.tag = i
            let buttonImageUS = HttpData.http+"/FamilyServiceSystem/\(FirstTypeData[i].typeLogo)"
           
            let url:NSString = buttonImageUS.URLEncodedString()
            let data = getImageData(url as String)
            if data == nil{
                termImg = UIImage(named: HttpData.imgArray[i%3])
                
            }else{
                termImg = UIImage(data: data!)
            }
            
            term1.setBackgroundImage(termImg, forState: UIControlState.Normal)
            //term1.backgroundColor = color[i%9]
            //term1.titleLabel?.font = UIFont.systemFontOfSize(16)
            term1.showsTouchWhenHighlighted = true
            term1.addTarget(self , action: Selector("tapped:"), forControlEvents: UIControlEvents.TouchUpInside)
            ButtonScroll.addSubview(term1)
        }
 
        if a == 0 {
            ButtonScroll.contentSize = CGSizeMake(self.view.bounds.width, CGFloat(terms/3)*((ButtonScrollheight-4)/3+2))}
        else{
            ButtonScroll.contentSize = CGSizeMake(self.view.bounds.width, CGFloat(terms/3+1)*((ButtonScrollheight-4)/3+2))
        }
        
        var buttontitle = ["我的订单","我的收藏","我的信息"]
        var buttonimage = ["mydingdan.png","collect.png","centeryuding.png","mydingdan.png","myinfo.png"]
        var buttonheight = self.view.bounds.height - ButtonScrolly - ButtonScrollheight
        var buttony = ButtonScrolly + ButtonScrollheight
        for var i = 0;i < 3;i++ {
            let term1 = UIButton(frame: CGRectMake(3+((self.view.bounds.width-14)/3+2)*CGFloat(i%3),buttony+2,(self.view.bounds.width-14)/3,buttonheight-4))
            term1 .setTitle(buttontitle[i] as String, forState:UIControlState.Normal)
            term1.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            //term1.setTitleShadowColor(UIColor.whiteColor(),forState: UIControlState.Normal)
            var color = UIColor  (red: 255/255, green: 127/255, blue: 27/255, alpha: 1.0)
            term1.backgroundColor = color
            term1.layer.cornerRadius = 5.0
            //term1.setBackgroundImage(UIImage(named:buttonimage[i]), forState:UIControlState.Normal)
            term1.titleLabel?.font = UIFont.systemFontOfSize(14)
            term1.showsTouchWhenHighlighted = true
            term1.addTarget(self , action: Selector("tapped2:"), forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addSubview(term1)
        }
     
    }
    
    
    override func  viewDidLayoutSubviews() {
        var bounds:CGRect = self.view.frame
        var leadheight = bounds.height*0.11
        var scrollviewheight = bounds.height*0.27
        var pageCtrly = leadheight + scrollviewheight-bounds.height*0.03
        var pageCtrlheight = 37
        var ButtonScrolly = pageCtrly + CGFloat(pageCtrlheight)-5
        var ButtonScrollheight = bounds.height*0.53
        var lastheight = bounds.height*0.09
        println(leadheight)
        
        lead.frame = CGRect(x: 0, y: 0, width: bounds.width, height: leadheight)
        shouye.frame = CGRectMake(bounds.width/2-20, leadheight-30, 40, 23)
        scrollView.frame = CGRectMake(0, leadheight+2, bounds.width, bounds.height*0.27)
        pageCtrl.frame = CGRectMake(bounds.width*0.25, pageCtrly, bounds.width*0.5, CGFloat(pageCtrlheight) )
        ButtonScroll.frame = CGRectMake(0, ButtonScrolly, bounds.width, bounds.height*0.53)
 
    }
    func toLocation(Location:UIButton){
        println("怎么样了")
        // self.performSegueWithIdentifier("toLocation", sender: self)
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("LocationVC") as! UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func ToLocation(){
        println("怎么样了")
        // self.performSegueWithIdentifier("toLocation", sender: self)
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("LocationVC") as! UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    

 // tapped函数，跳转
    func tapped(term1:UIButton){
 
            titleOfState = FirstTypeData[term1.tag].typeName
            //titleOfState = term1.titleForState(.Normal)!
            
            var  serviceTypeData = refreshServiceType(titleOfState) as![ServiceType]
            println("我点击的是:\(titleOfState)")
            if serviceTypeData != [] {
            self.performSegueWithIdentifier("toItem", sender: self)
            }else {
                let alert =  UIAlertView(title: "", message: "暂无数据，敬请期待!", delegate: self, cancelButtonTitle: "确定")
                alert.show()

            }
        }
 
    func tapped2(term1:UIButton){
        titleOfState  = term1.titleForState(.Normal)!
        
        //读取用户信息，如果不是第一次登录，则会自动登录
        readNSUerDefaults()
        if titleOfState == "我的收藏" {
            if  customerid == "" || loginPassword == ""{
                self.performSegueWithIdentifier("toLogin", sender: self)
            }else {
                
                self.performSegueWithIdentifier("toCollection", sender: self)
            }
        }else if titleOfState == "我的订单"{
            if  customerid == "" || loginPassword == ""{
                self.performSegueWithIdentifier("toLogin", sender: self)
            }else {
                
                self.performSegueWithIdentifier("tofinish", sender: self)
                
            }
        }else if titleOfState == "我的发布"{
            if  customerid == "" || loginPassword == ""{
                self.performSegueWithIdentifier("toLogin", sender: self)
            }else {
                
                self.performSegueWithIdentifier("toorder", sender: self)
                
            }
            
        }else if titleOfState == "我的信息"{
            
            if  customerid == "" || loginPassword == ""{
                self.performSegueWithIdentifier("toLogin", sender: self)
                
                
            }else {
                
                self.performSegueWithIdentifier("toMyInfo", sender: self)
            }
        }
        
    }

 
     //6.定时器函数
    func timerFireMethod(timer: NSTimer) {
        
        //令UIScrollView做出相应的滑动显示
        self.pageCtrl.currentPage = (self.pageCtrl.currentPage+1)%AdvertiseDatas.count
        var viewSize:CGSize  = scrollView.frame.size
        var rect:CGRect = CGRect(x:CGFloat(self.pageCtrl.currentPage)*viewSize.width , y: 0, width: viewSize.width, height: viewSize.height)
        scrollView.scrollRectToVisible(rect , animated:true);
        //imgLabel.text = AdvertiseDatas[pageCtrl.currentPage].signName
    }
    //7.单击滚动图片事件
    func clickImg( sender:UIButton) {
        println( "clickImgView\(self.pageCtrl.currentPage)" )
        urlSelected = AdvertiseDatas[pageCtrl.currentPage].facilitatorID

        self.performSegueWithIdentifier("AdvertTo", sender: self)
 
    }
 
    

    //-------------------Table view data source-----------------------------
    // 根据indexPath(section,row)创建每行cell及其内容
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //创建cell
        var cellId:String = "cellId"
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier( cellId ) as! UITableViewCell?
        if cell == nil
        {
            cell = UITableViewCell(style:UITableViewCellStyle.Default, reuseIdentifier: cellId)
            cell?.textLabel?.font = UIFont(name: "Times New Roman", size: 13)
        }
 
        return cell!
    }
    
    // Return the number of sections.
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 0;//HttpData.channelTitles.count
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier! == "toItem" {
            
     
            let controller = segue.destinationViewController as! BusinessVC
       
            var object = titleOfState
            controller.FirstType = object
            println(controller.FirstType)
            println("fffffff")
            
        } else if segue.identifier! == "AdvertTo" {
            
            let controller = segue.destinationViewController as! BusinessDVC
            var object = urlSelected
            controller.facilitatorid = object
        
            println("fffffff")
            
        }

    }
    //从NSUerDefaults 中读取数据
    func readNSUerDefaults () {
        
        var userDefaultes = NSUserDefaults.standardUserDefaults()
        if  (userDefaultes.stringForKey("customerID")) != nil && (userDefaultes.stringForKey("loginPassword")) != nil{
            customerid = userDefaultes.stringForKey("customerID")!
            loginPassword = userDefaultes.stringForKey("loginPassword")!
            
        }
        
        if  (userDefaultes.stringForKey("location")) != nil && (userDefaultes.stringForKey("location")) != "" {
         location = userDefaultes.stringForKey("location")!
      
        println(location)
        }else{
            ToLocation()
        }
        
    }
 
      // 1.在地图将要启动定位时，会调用此函数
    func willStartLocatingUser() {
        println("启动定位……")
    }
    // 2.用户位置更新后，会调用此函数
    func didUpdateBMKUserLocation(userLocation: BMKUserLocation!) {
      
        self.userLocation = userLocation
        println("目前位置：\(userLocation.location.coordinate.longitude), \(userLocation.location.coordinate.latitude)")
        var  Longtitude = userLocation.location.coordinate.longitude
        var  Latitude = userLocation.location.coordinate.latitude
        var point = CLLocationCoordinate2DMake(0, 0)
       
            point = CLLocationCoordinate2DMake(Latitude, Longtitude)
      
        var unGeocodeSearchOption = BMKReverseGeoCodeOption()
          unGeocodeSearchOption.reverseGeoPoint = point
        var flag = geocodeSearch.reverseGeoCode(unGeocodeSearchOption)
        if flag {
            println("反 geo 检索发送成功")
        }else {
            println("反 geo 检索发送失败")
        }

       locationService.stopUserLocationService()
        
    }
    // 用户方向更新后，会调用此函数
    func didUpdateUserHeading(userLocation: BMKUserLocation!) {
        
    }
    
    // 在地图将要停止定位时，会调用此函数
    func didStopLocatingUser() {
        println("关闭定位")

    }
    
    // 定位失败的话，会调用此函数
    func didFailToLocateUserWithError(error: NSError!) {
        println("定位失败！")
      
    }
    
    
    func onGetReverseGeoCodeResult(searcher: BMKGeoCodeSearch!, result: BMKReverseGeoCodeResult!, errorCode error: BMKSearchErrorCode) {
            println("进入编码状态2")
        
         if error.value == 0 {
 
            var city = result.addressDetail.city
//            println("city\(result.addressDetail.city)")
//            var index = advance(city.endIndex, -1);
//            let location = city.substringToIndex(index)
        
            location = city
            println("location\(location)")
            saveNSUerDefaults ()
            readNSUerDefaults()
           
            LocationB.setTitle(location, forState: UIControlState.Normal)
//            
//                        let alert =  UIAlertView(title:location, message:city, delegate: self, cancelButtonTitle: "确定")
//                        alert.show()
        
        }
    }
 

    
    
    //保存数据到NSUerDefaults
    func saveNSUerDefaults () {
        //将数据全部存储到NSUerDefaults中
        var userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        //存储时，除了NSNumber类型使用对应的类型外，其他的都使用setObject:forKey:
        userDefaults.setObject( location, forKey: "location")
        
        //建议同步到磁盘，但不是必须得
        userDefaults.synchronize()
    }

    override func viewWillAppear(animated: Bool) {
        //读取用户信息，如果不是第一次登录，则会自动登录
        readNSUerDefaults()
        if location == "当前城市"{
            locationService.startUserLocationService()
        }
         locationService.delegate = self
          geocodeSearch.delegate = self
        
    }
    override func viewWillDisappear(animated: Bool) {
        
    locationService.delegate = nil
        
         geocodeSearch.delegate = nil
            }
 
}
