////
////  beifen.swift
////  SHW
////
////  Created by Zhang on 15/9/22.
////  Copyright (c) 2015年 star. All rights reserved.
////
//
//import Foundation
////
////  MainVC.swift
////  生活网/Users/zhang/Desktop/ Learn IOS/生活网/生活网/CollectionViewController.swift
////
////  Created by Zhang on 15/5/17.
////  Copyright (c) 2015年 Zhang. All rights reserved.
////
//
//import UIKit
////import CoreLocation
//
//
//class MainVC: UIViewController , UITableViewDelegate,
//UIScrollViewDelegate,UIAlertViewDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate{
//    
//    //用于定位服务管理类，它能够给我们提供位置信息和高度信息，也可以监控设备进入或离开某个区域，还可以获得设备的运行方向
//    //    var locationManager : CLLocationManager = CLLocationManager()
//    //    var currLocation : CLLocation!
//    var imgLabel:UILabel!
//    var urlSelected:String = ""
//    var titleOfState:String = ""
//    var AdvertiseDatas:[HomeAdvertise]=[]
//    var range:NSArray = []
//    var location:String = "当前城市"
//    
//    var customerid:String =  ""
//    var loginPassword:String = ""
//    
//    //var scrollView:UIScrollView!
//    //IB控件绑定
//    
//    @IBOutlet weak var scrollView: UIScrollView!
//    @IBOutlet weak var ButtonScroll: UIScrollView!
//    @IBOutlet weak var pageCtrl: UIPageControl!
//    
//    @IBOutlet weak var lead: UILabel!
//    
//    // @IBOutlet weak var LocationB: UIButton!
//    
//    
//    //@IBOutlet weak var tianqi: UIButton!
//    @IBOutlet weak var shouye: UILabel!
//    //  @IBOutlet weak var lead: UIView!
//    //详细界面属性
//    var detailView:UIView!
//    var webView:UIWebView!
//    var LocationB = UIButton()
//    var _data:NSData?
//    var imageUrlString:NSString?
//    //   var imgView = UIButton()
//    var img:UIImage?
//    /// 定位服务
//    var locationService: BMKLocationService!
//    /// 当前用户位置
//    var userLocation: BMKUserLocation!
//    /// 地理位置编码
//    //var geocodeSearch: BMKGeoCodeSearch!
//    //初始化
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        //table.dataSource = self
//        //table.delegate = self
//        //        locationManager.delegate = self
//        //        //设备使用电池供电时最高的精度
//        //        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        //        //精确到1000米,距离过滤器，定义了设备移动后获得位置信息的最小距离
//        //        locationManager.distanceFilter = kCLLocationAccuracyKilometer
//        //        if self.locationManager.respondsToSelector("requestAlwaysAuthorization"){
//        //            locationManager.requestAlwaysAuthorization()
//        //            println("requestAlwaysAuthorization")
//        // 设置定位精确度，默认：kCLLocationAccuracyBest
//        BMKLocationService.setLocationDesiredAccuracy(kCLLocationAccuracyBest)
//        //指定最小距离更新(米)，默认：kCLDistanceFilterNone
//        BMKLocationService.setLocationDistanceFilter(10)
//        // 定位功能初始化
//        locationService = BMKLocationService()
//        println("进入定位状态")
//        
//        
//        // 地理编码器初始化
//        //  geocodeSearch = BMKGeoCodeSearch()
//        
//        
//        //        locationManager.startUpdatingLocation()
//        println("定位开始1111")
//        //
//        
//        AdvertiseDatas = refreshAdvertise() as! [HomeAdvertise]
//        
//        
//        //读取用户信息，如果不是第一次登录，则会自动登录
//        readNSUerDefaults()
//        
//        //var bounds:CGRect = self.view.bounds
//        var leadheight = self.view.bounds.height*0.11
//        var scrollviewheight = self.view.bounds.height*0.27
//        var pageCtrly = leadheight + scrollviewheight-self.view.bounds.height*0.03
//        var pageCtrlheight = 37
//        var ButtonScrolly = pageCtrly + CGFloat(pageCtrlheight)-5
//        var ButtonScrollheight = self.view.bounds.height*0.53
//        var lastheight = self.view.bounds.height*0.09
//        
//        
//        var tianqi = UIButton(frame: CGRect(x: 50, y: leadheight-35, width: 30, height:30))
//        self.view.addSubview(tianqi)
//        
//        //self.scrollView = UIScrollView(frame: CGRectMake(0, leadheight, bounds.width, bounds.height*0.245))
//        //1.设置图片UIScrollView
//        // scrollView.contentSize =  CGSize(width: bounds.width * CGFloat(range.count), height: bounds.height*0.27)
//        scrollView.contentSize =  CGSize(width: self.view.bounds.width * CGFloat(AdvertiseDatas.count), height: self.view.bounds.height*0.27)
//        scrollView.pagingEnabled = true  //设true时，会按页滑动
//        scrollView.bounces = false  //取消UIScrollView的弹性属性，这个可以按个人喜好来定
//        scrollView.delegate = self //UIScrollView的delegate函数在本类中定义
//        scrollView.showsHorizontalScrollIndicator = false//因为我们使用UIPageControl表示页面进度，所以取消UIScrollView自己的进度条。
//        println(location)
//        
//        // LocationB.titleLabel?.text = location
//        LocationB = UIButton(frame: CGRect(x: 20, y: leadheight-30, width: 100, height:23))
//        LocationB.titleLabel?.font = UIFont.systemFontOfSize(15)
//        LocationB.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
//        LocationB.setTitle(location, forState: UIControlState.Normal)
//        LocationB.addTarget(self, action: "toLocation:", forControlEvents: UIControlEvents.TouchUpInside)
//        self.view.addSubview(LocationB)
//        
//        
//        
//        //2.设置图片滚动
//        
//        println("图片")
//        for var i = 0; i < AdvertiseDatas.count; i++ {
//            println("数目：\(AdvertiseDatas.count)")
//            
//            var imgView:UIButton = UIButton(frame: CGRect(x: self.view.bounds.width*CGFloat(i), y:0, width: self.view.bounds.width, height: self.view.bounds.width*0.45) )
//            
//            //网络地址获取图片
//            //            //1.定义一个地址字符串常量
//            imageUrlString = HttpData.http+"/FamilyServiceSystem/upload/homepic/\(AdvertiseDatas[i].id)/\(AdvertiseDatas[i].pictureName)"
//            //            //let imageUrlString:String = "http://192.168.1.101:8080/FamilyServiceSystem/upload/ad/\(AdvertiseDatas[i].id)/\(range[0])"
//            //            //2.通过String类型，转换NSUrl对象
//            
//            println("url:\(imageUrlString)")
//            //            let url :NSURL = NSURL(string: imageUrlString! as String)!
//            let url:NSString = imageUrlString!.URLEncodedString()
//            //            let url:NSString = url1.URLEncodedString()
//            ////            var url = imageUrlString?.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
//            //
//            //            println("url:\(url)")
//            //            //3.从网络获取数据流
//            //            if let data:NSData = NSData(contentsOfURL: url){
//            //                //4.通过数据流初始化图片
//            //                img = UIImage(data: data)!
//            //
//            //                println("data是:\(i)")
//            //              imgView.setBackgroundImage(img, forState: UIControlState.Normal)
//            //
//            //            }else {
//            //                 println("data是空")
//            //                img = UIImage(named: HttpData.imgArray[i])!
//            //
//            //                imgView.setBackgroundImage(img, forState: UIControlState.Normal)
//            //            }
//            //img = UIImage(named: "1-1")!
//            //introImg.loadImage(imageUrlString, holder: "reserve2.jpg")
//            //introImg.setZYHWebImage(imageUrlString, defaultImage: "reserve2.jpg", isCache: true)
//            var data = getImageData(url as String)
//            if data == nil{
//                img = UIImage(named: HttpData.imgArray[i])
//                
//            }else{
//                img = UIImage(data: data!)
//            }
//            imgView.setBackgroundImage(img, forState: UIControlState.Normal)
//            
//            //var imgView:UIButton = UIButton(frame: CGRect(x: bounds.width*CGFloat(i), y:0, width: bounds.width, height: bounds.width*0.45) )
//            
//            //3.发出异步请求
//            //             var request = NSURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10)
//            //             //4.连接服务器
//            //             var connection =  NSURLConnection(request:request, delegate:self)
//            //
//            
//            scrollView.addSubview( imgView )
//            imgView.addTarget(self, action:"clickImg:" , forControlEvents: UIControlEvents.TouchUpInside)
//            
//            
//        }
//        
//        //3.添加图片标题
//        imgLabel = UILabel(frame: CGRect(x:0, y: leadheight+self.view.bounds.height*0.27-35, width: self.view.bounds.width, height: 30))
//        imgLabel.backgroundColor = UIColor.whiteColor()
//        imgLabel.alpha = 0.5
//        self.view.addSubview(imgLabel )
//        imgLabel.text = AdvertiseDatas[0].signName
//        //imgLabel.text = "hao"
//        
//        //4.创建UIPageControl
//        //pageCtrl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 400, bounds.size.width, 30)];  //创建UIPageControl，位置在屏幕最下方。
//        pageCtrl.numberOfPages = AdvertiseDatas.count;//总的图片页数
//        pageCtrl.currentPage = 0; //当前页
//        pageCtrl.pageIndicatorTintColor = UIColor.grayColor()
//        pageCtrl.currentPageIndicatorTintColor = UIColor.redColor()
//        pageCtrl.addTarget(self, action:"pageTurn:" ,forControlEvents:UIControlEvents.ValueChanged) //用户点击UIPageControl的响应函数
//        //[self.view addSubview:pageCtrl];  //将UIPageControl添加到主界面上。
//        
//        //5.设置定时器（滑动切换图片）
//        var timer = NSTimer.scheduledTimerWithTimeInterval(3.5, target: self, selector: "timerFireMethod:", userInfo: nil, repeats:true);
//        println( "end viewDidLoad" )
//        
//        //创建buttonScroll
//        ButtonScroll.contentSize = CGSize(width: self.view.bounds.width, height:self.view.bounds.height )
//        ButtonScroll.pagingEnabled = false
//        ButtonScroll.delegate = self
//        ButtonScroll.showsHorizontalScrollIndicator = false
//        ButtonScroll.showsVerticalScrollIndicator = false
//        ButtonScroll.bounces = false
//        //ButtonScroll.contentInset = UIEdgeInsetsMake(0, 0, -, 0)
//        self.automaticallyAdjustsScrollViewInsets = false
//        
//        //创建button
//        var button1C = UIColor  (red: 204/255, green: 255/255, blue: 0/255, alpha: 1.0)
//        var button2C = UIColor(red: 1.0, green: 153/255, blue: 102/255, alpha: 1.0)
//        var button3C = UIColor(red: 204/255, green: 204/255, blue: 255/255, alpha: 1.0)
//        var button4C = UIColor(red: 1.0, green: 153/255, blue: 153/255, alpha: 1.0)
//        var button5C = UIColor(red: 153/255, green: 204/255, blue: 255/255, alpha: 1.0)
//        var button6C = UIColor(red: 255/255, green: 153/255, blue: 204/255, alpha: 1.0)
//        var button7C = UIColor(red: 255/255, green: 204/255, blue: 0/255, alpha: 1.0)
//        var button8C = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0)
//        var button9C = UIColor(red: 102/255, green: 204/255, blue: 255/255, alpha: 1.0)
//        var color = [button1C,button2C,button3C,button4C,button5C,button6C,button7C,button8C,button9C]
//        var terms = HttpData.maintwo.count
//        var width = (self.view.bounds.width-20)/3
//        var a = terms%3
//        // mainatwo的button
//        for var i = 0;i < terms;i++ {
//            let term1 = UIButton(frame: CGRectMake(8+(width+2)*CGFloat(i%3),CGFloat(i/3)*((ButtonScrollheight-4)/3+2), width,(ButtonScrollheight-4)/3))
//            term1 .setTitle(HttpData.maintwo[i] as String, forState:UIControlState.Normal)
//            term1.setTitleShadowColor(UIColor.whiteColor(),forState: UIControlState.Normal)
//            term1.backgroundColor = color[i]
//            term1.titleLabel?.font = UIFont.systemFontOfSize(16)
//            term1.showsTouchWhenHighlighted = true
//            term1.addTarget(self , action: Selector("tapped:"), forControlEvents: UIControlEvents.TouchUpInside)
//            ButtonScroll.addSubview(term1)
//        }
//        
//        if a == 0 {
//            ButtonScroll.contentSize = CGSizeMake(self.view.bounds.width, CGFloat(terms/3)*((ButtonScrollheight-4)/3+2))}
//        else{
//            ButtonScroll.contentSize = CGSizeMake(self.view.bounds.width, CGFloat(terms/3+1)*((ButtonScrollheight-4)/3+2))
//        }
//        
//        var buttontitle = ["我的订单","我的收藏","我的信息"]
//        var buttonimage = ["mydingdan.png","collect.png","centeryuding.png","mydingdan.png","myinfo.png"]
//        var buttonheight = self.view.bounds.height - ButtonScrolly - ButtonScrollheight
//        var buttony = ButtonScrolly + ButtonScrollheight
//        for var i = 0;i < 3;i++ {
//            let term1 = UIButton(frame: CGRectMake(3+((self.view.bounds.width-14)/3+2)*CGFloat(i%3),buttony+2,(self.view.bounds.width-14)/3,buttonheight-4))
//            term1 .setTitle(buttontitle[i] as String, forState:UIControlState.Normal)
//            term1.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
//            //term1.setTitleShadowColor(UIColor.whiteColor(),forState: UIControlState.Normal)
//            var color = UIColor  (red: 255/255, green: 127/255, blue: 27/255, alpha: 1.0)
//            term1.backgroundColor = color
//            term1.layer.cornerRadius = 5.0
//            //term1.setBackgroundImage(UIImage(named:buttonimage[i]), forState:UIControlState.Normal)
//            term1.titleLabel?.font = UIFont.systemFontOfSize(14)
//            term1.showsTouchWhenHighlighted = true
//            term1.addTarget(self , action: Selector("tapped:"), forControlEvents: UIControlEvents.TouchUpInside)
//            self.view.addSubview(term1)
//        }
//        
//    }
//    
//    
//    override func  viewDidLayoutSubviews() {
//        var bounds:CGRect = self.view.frame
//        var leadheight = bounds.height*0.11
//        var scrollviewheight = bounds.height*0.27
//        var pageCtrly = leadheight + scrollviewheight-bounds.height*0.03
//        var pageCtrlheight = 37
//        var ButtonScrolly = pageCtrly + CGFloat(pageCtrlheight)-5
//        var ButtonScrollheight = bounds.height*0.53
//        var lastheight = bounds.height*0.09
//        println(leadheight)
//        
//        lead.frame = CGRect(x: 0, y: 0, width: bounds.width, height: leadheight)
//        shouye.frame = CGRectMake(bounds.width/2-20, leadheight-30, 40, 23)
//        scrollView.frame = CGRectMake(0, leadheight+2, bounds.width, bounds.height*0.27)
//        pageCtrl.frame = CGRectMake(bounds.width*0.25, pageCtrly, bounds.width*0.5, CGFloat(pageCtrlheight) )
//        ButtonScroll.frame = CGRectMake(0, ButtonScrolly, bounds.width, bounds.height*0.53)
//        //        Location(<#sender: AnyObject#>).frame = CGRectMake(10,leadheight-30 , 40, 23)
//        //tianqi.frame = CGRectMake(50, leadheight-50 , 30, 30)
//        // LocationB.frame = CGRectMake(30, leadheight-25, 40, 23)
//        
//        
//        
//    }
//    func toLocation(Location:UIButton){
//        println("怎么样了")
//        // self.performSegueWithIdentifier("toLocation", sender: self)
//        let sb = UIStoryboard(name: "Main", bundle: nil)
//        let vc = sb.instantiateViewControllerWithIdentifier("LocationVC") as! UIViewController
//        self.presentViewController(vc, animated: true, completion: nil)
//    }
//    
//    
//    // tapped函数，跳转
//    func tapped(term1:UIButton){
//        titleOfState = term1.titleForState(.Normal)!
//        //读取用户信息，如果不是第一次登录，则会自动登录
//        readNSUerDefaults()
//        println("标题\(titleOfState)")
//        //        if titleOfState == "我的收藏" || titleOfState == "我的订单"|| titleOfState == "我的预定"||  titleOfState == "我的信息"
//        //        {   if  customerid == "" || loginPassword == ""{
//        //            self.performSegueWithIdentifier("toLogin", sender: self)
//        //
//        //          }else{
//        if titleOfState == "我的收藏" {
//            if  customerid == "" || loginPassword == ""{
//                self.performSegueWithIdentifier("toLogin", sender: self)
//            }else {
//                
//                self.performSegueWithIdentifier("toCollection", sender: self)
//            }
//        }else if titleOfState == "我的订单"{
//            if  customerid == "" || loginPassword == ""{
//                self.performSegueWithIdentifier("toLogin", sender: self)
//            }else {
//                
//                self.performSegueWithIdentifier("tofinish", sender: self)
//                
//            }
//            
//            //         }else if titleOfState == "我的预定"{
//            //            if  customerid == "" || loginPassword == ""{
//            //                self.performSegueWithIdentifier("toLogin", sender: self)
//            //            }else {
//            //
//            //               self.performSegueWithIdentifier("toorder", sender: self)
//            //
//            //            }
//            //
//        }else if titleOfState == "我的信息"{
//            
//            if  customerid == "" || loginPassword == ""{
//                self.performSegueWithIdentifier("toLogin", sender: self)
//                
//                
//            }else {
//                
//                self.performSegueWithIdentifier("toMyInfo", sender: self)
//            }
//            //          }else if titleOfState == "更多"{
//            //
//            //                let alert =  UIAlertView(title: "", message: "尚未开放，敬请期待!", delegate: self, cancelButtonTitle: "确定")
//            //                alert.show()
//            //
//            //
//            //
//        }else {
//            titleOfState = term1.titleForState(.Normal)!
//            var  serviceTypeData = refreshServiceType(titleOfState) as![ServiceType]
//            println("我点击的是:\(titleOfState)")
//            if serviceTypeData != [] {
//                self.performSegueWithIdentifier("toItem", sender: self)
//            }else {
//                let alert =  UIAlertView(title: "", message: "暂无数据，敬请期待!", delegate: self, cancelButtonTitle: "确定")
//                alert.show()
//                
//            }
//        }
//    }
//    
//    
//    //6.定时器函数
//    func timerFireMethod(timer: NSTimer) {
//        
//        //令UIScrollView做出相应的滑动显示
//        self.pageCtrl.currentPage = (self.pageCtrl.currentPage+1)%AdvertiseDatas.count
//        var viewSize:CGSize  = scrollView.frame.size
//        var rect:CGRect = CGRect(x:CGFloat(self.pageCtrl.currentPage)*viewSize.width , y: 0, width: viewSize.width, height: viewSize.height)
//        scrollView.scrollRectToVisible(rect , animated:true);
//        imgLabel.text = AdvertiseDatas[pageCtrl.currentPage].signName
//    }
//    //7.单击滚动图片事件
//    func clickImg( sender:UIButton) {
//        println( "clickImgView\(self.pageCtrl.currentPage)" )
//        urlSelected = AdvertiseDatas[pageCtrl.currentPage].facilitatorID
//        
//        self.performSegueWithIdentifier("AdvertTo", sender: self)
//        //        webView.loadRequest(NSURLRequest(URL: NSURL(string: urlSelected)!))
//        //        self.view.addSubview(detailView)
//        //        toggleDetailView(show: true)
//    }
//    //    func toggleDetailView( #show:Bool ) {
//    //        var direction:CGFloat = 1
//    //        if show {
//    //            direction = -1
//    //        }
//    //        var bounds = self.view.frame
//    //        //self.detailView.transform = CGAffineTransformMakeTranslation(0, 0)//()(1.0f, 1.0f);//将要显示的view按照正常比例显示出来
//    //        UIView.beginAnimations(nil, context:nil)
//    //        UIView.setAnimationCurve(UIViewAnimationCurve.EaseInOut)//:UIViewAnimationCurveEaseInOut]; //InOut 表示进入和出去时都启动动画
//    //        UIView.setAnimationDuration(0.3)//动画时间
//    //        self.detailView.transform=CGAffineTransformMakeTranslation(direction*bounds.width, 0);//先让要显示的view最小直至消失
//    //        //self.detailView.transform=CGAffineTransformMakeScale(0.8, 0.8)//(direction*bounds.width, 0);//先让要显示的view最小直至消失
//    //        //self.scrollView.transform=CGAffineTransformMakeTranslation(direction*bounds.width, 0)
//    //        UIView.commitAnimations() //启动动画
//    //        //相反如果想要从小到大的显示效果，则将比例调换
//    //        //UIGraphicsGetCurrentContext 里面东西很丰富。
//    //
//    //}
//    
//    
//    //-------------------Table view data source-----------------------------
//    // 根据indexPath(section,row)创建每行cell及其内容
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        //创建cell
//        var cellId:String = "cellId"
//        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier( cellId ) as! UITableViewCell?
//        if cell == nil
//        {
//            cell = UITableViewCell(style:UITableViewCellStyle.Default, reuseIdentifier: cellId)
//            cell?.textLabel?.font = UIFont(name: "Times New Roman", size: 13)
//        }
//        
//        return cell!
//    }
//    
//    // Return the number of sections.
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 0;//HttpData.channelTitles.count
//    }
//    
//    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier! == "toItem" {
//            
//            //let controller = segue.destinationViewController.rootViewController as! Maintwo
//            let controller = segue.destinationViewController as! BusinessVC
//            //let controller = segue.destinationNavigationViewController as! Maintwo
//            
//            //println(destinationViewController.rootViewController)
//            var object = titleOfState
//            controller.FirstType = object
//            println(controller.FirstType)
//            println("fffffff")
//            
//        } else if segue.identifier! == "AdvertTo" {
//            
//            let controller = segue.destinationViewController as! BusinessDVC
//            var object = urlSelected
//            controller.facilitatorid = object
//            
//            println("fffffff")
//            
//        }
//        
//    }
//    //从NSUerDefaults 中读取数据
//    func readNSUerDefaults () {
//        
//        var userDefaultes = NSUserDefaults.standardUserDefaults()
//        if  (userDefaultes.stringForKey("customerID")) != nil && (userDefaultes.stringForKey("loginPassword")) != nil{
//            customerid = userDefaultes.stringForKey("customerID")!
//            loginPassword = userDefaultes.stringForKey("loginPassword")!
//            
//        }
//        println("location")
//        if  (userDefaultes.stringForKey("location")) != nil{
//            location = userDefaultes.stringForKey("location")!
//            
//            println(location)
//        }
//        
//    }
//    
//    
//    //        func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
//    //
//    //            println("接收信号")
//    //              _data = getImageData(imageUrlString)
//    //    //        println("_---data:\(_data)")
//    //                img = UIImage(data:_data!)
//    ////          imgView.setBackgroundImage(img, forState: UIControlState.Normal)
//    //
//    //        }
//    //
//    //        func connection(connection: NSURLConnection, didReceiveData data: NSData) {
//    //         img = UIImage(named: "reserve2.jpg")
//    ////        imgView.setBackgroundImage(img, forState: UIControlState.Normal)
//    //
//    //        }
//    //
//    //
//    //        func connectionDidFinishLoading(connection:NSURLConnection)
//    //        {
//    //           img = UIImage(data:_data!)
//    ////        imgView.setBackgroundImage(img, forState: UIControlState.Normal)
//    //        }
//    
//    
//    
//    //    func  locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
//    //
//    //        println("定位进行中1")
//    //        //获取最新坐标
//    //        currLocation = locations.last as! CLLocation
//    //
//    //        if (currLocation.horizontalAccuracy > 0) {
//    //            locationManager.stopUpdatingLocation()
//    //            println("定位结束")
//    ////            var longitude = currLocation.coordinate.longitude
//    ////            var latitude = currLocation.coordinate.latitude
//    //            var longitude = 39.90364
//    //            var latitude = 116.4121
//    //
//    //            var url = NSURL(string:"http://gc.ditu.aliyun.com/regeocoding?l=\(longitude),\(latitude)&type=111")
//    //            println(url)
//    //
//    //            var data = NSData(contentsOfURL: url!, options: NSDataReadingOptions.DataReadingUncached, error: nil)
//    //            var   str = NSString(data: data! ,encoding: NSUTF8StringEncoding)
//    //
//    //
//    //            var json: AnyObject? = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: nil)
//    //               println("json\(json)")
//    //            var test2: AnyObject?=json!.objectForKey("addrList")
//    //
//    //            let jsonArray = test2 as? NSArray
//    //             println("test2\(test2)")
//    //
//    //            var count = jsonArray?.count
//    //            var pictureName:String = ""
//    //            for value in jsonArray!{
//    //
//    //                pictureName  =  value.objectForKey("admName") as! String
//    //
//    //
//    //                println("pictureName\(pictureName)")
//    //                var city :String
//    //
//    //                //将字符串切割成数组
//    //                if pictureName != "" {
//    //
//    //                    range = pictureName.componentsSeparatedByString(",")
//    //                    println("图片字符串长度\(range.count)")
//    //
//    //                    if range[0] as! String == "上海市"||range[0] as! String == "北京市"||range[0] as! String == "重庆市"||range[0] as! String == "天津市"||range[0] as! String == "香港特别行政区"||range[0] as! String == "澳门特别行政区" {
//    //                        city = self.range[0] as! String
//    //
//    //                        let index = advance(city.endIndex, -1);
//    //
//    //
//    //                        self.location = city.substringToIndex(index)
//    //                        println("location:\(location)")
//    //
//    //                        //            self.location = self.range[0] as! String
//    //                    }else {
//    //                        city = self.range[1] as! String
//    //
//    //                        let index = advance(city.endIndex, -1);
//    //
//    //
//    //                        self.location = city.substringToIndex(index)
//    //                        println("location:\(location)")
//    //                        //                    self.location = self.range[1] as! String
//    //                    }
//    //                }else {
//    //                    println("我是空的")
//    //                    self.location = "沈阳"
//    //                }
//    //                saveNSUerDefaults()
//    //                LocationB.setTitle(location, forState: UIControlState.Normal)
//    //
//    //
//    //            }
//    //        }
//    //    }
//    //
//    // 用户位置更新后，会调用此函数
//    func didUpdateBMKUserLocation(userLocation: BMKUserLocation!) {
//        
//        self.userLocation = userLocation
//        println("目前位置：\(userLocation.location.coordinate.longitude), \(userLocation.location.coordinate.latitude)")
//        //        var point = CLLocationCoordinate2DMake(0, 0)
//        //
//        //            point = CLLocationCoordinate2DMake(CLLocationDegrees((txf_Longtitude.text as NSString).floatValue), CLLocationDegrees((txf_Latitude.text as NSString).floatValue))
//        //
//        //        var unGeocodeSearchOption = BMKReverseGeoCodeOption()
//        //          unGeocodeSearchOption.reverseGeoPoint = point
//        //        var flag = geocodeSearch.reverseGeoCode(unGeocodeSearchOption)
//        //        if flag {
//        //            println("反 geo 检索发送成功")
//        //        }else {
//        //            println("反 geo 检索发送失败")
//        //        }
//        //
//        
//        
//    }
//    
//    //    func onGetReverseGeoCodeResult(searcher: BMKGeoCodeSearch!, result: BMKReverseGeoCodeResult!, errorCode error: BMKSearchErrorCode) {
//    //
//    //        if error.value == 0 {
//    //            var item = BMKPointAnnotation()
//    //            item.coordinate = result.location
//    //            //            item.title = result.address
//    //            item.title = result.addressDetail.city
//    //            
//    //           
//    //            
//    //           // var alertView = UIAlertController(title: title, message: showMessage, preferredStyle: .Alert)
//    //           
//    //            self.presentViewController(alertView, animated: true, completion: nil)
//    //        }
//    //    }
//    
//    // 定位失败的话，会调用此函数
//    func didFailToLocateUserWithError(error: NSError!) {
//        println("定位失败！")
//        
//    }
//    
//    
//    
//    //保存数据到NSUerDefaults
//    func saveNSUerDefaults () {
//        //将数据全部存储到NSUerDefaults中
//        var userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
//        //存储时，除了NSNumber类型使用对应的类型外，其他的都使用setObject:forKey:
//        userDefaults.setObject( location, forKey: "location")
//        //建议同步到磁盘，但不是必须得
//        userDefaults.synchronize()
//    }
//    
//    override func viewWillAppear(animated: Bool) {
//        //读取用户信息，如果不是第一次登录，则会自动登录
//        readNSUerDefaults()
//        //geocodeSearch.delegate = self
//    }
//    override func viewWillDisappear(animated: Bool) {
//        //locationManager.stopUpdatingLocation()
//        locationService.delegate = nil
//        println("定位结束")
//        // geocodeSearch.delegate = nil
//    }
//    
//}
