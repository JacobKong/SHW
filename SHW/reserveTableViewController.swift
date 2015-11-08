////
////  reserveTableViewController.swift
////  我的预定
////
////  Created by appl on 15/6/16.
////  Copyright (c) 2015年 appl. All rights reserved.
////
//
//import UIKit
//
//class reserveTViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
//    
//    @IBOutlet var reserve: UITableView!
//    
////    @IBAction func reply(sender: AnyObject) {
////        self.dismissViewControllerAnimated(true, completion: nil )
////    }
//    
////    //读取本地数据
//    var customerid:String = ""
//    var loginPassword:String = ""
// 
//    //获取网络数据
//    var Infor:[reserveInfo]=[]
//    var ReserveData:[reserveInfo] = []
//    //声明导航条
//    var navigationBar=UINavigationBar()
//    //刷新
//    var refreshControl = UIRefreshControl()
//    override func viewDidLoad() {
//        super.viewDidLoad()
////        //读取用户信息，如果不是第一次登录，则会自动登录
//        readNSUerDefaults()
//        //实例化导航条
//        navigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.width, 64))
//        self.view.addSubview(navigationBar)
//        println("创建导航条详情")
//        onMakeNavitem()
//        Infor = refreshReserve(customerid) as! [reserveInfo]
//        reserve.dataSource = self
//        reserve.delegate = self
//        println("111111111111")
//        ReserveData = Infor
////        for var i = 0;i < Infor.count;i++ {
////            if Infor[i].orderStatus == "预定" {
////                println("22222222222")
////                ReserveData += [Infor[i]]
////                println(ReserveData[i].orderStatus)
////            }
////        }
//        
//        
//        //初始下拉刷新控件
//        //        self.refreshControl = UIRefreshControl()
//        refreshControl.attributedTitle = NSAttributedString(string: "松开后自动刷新")
//        refreshControl.tintColor = UIColor.grayColor()
//        refreshControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
//        reserve.addSubview(refreshControl)
//
//    }
//    override func viewDidLayoutSubviews() {
//        reserve.frame = CGRectMake(0, 64, self.view.frame.width, self.view.frame.height)
//    }
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    // MARK: - Table view data source
//
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Potentially incomplete method implementation.
//        // Return the number of sections.
//        return 1;
//    }
//
//     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete method implementation.
//        // Return the number of rows in the section.
//        return ReserveData.count;
//    }
//
//    
//     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("reservecell", forIndexPath: indexPath) as! reserveTableViewCell
//
//        // Configure the cell...
////      let reservecell = ReserveData[indexPath.row] as Finishinfo
//        let reservecell = ReserveData[indexPath.row] as reserveInfo
//
//        cell.orderNo.text = "订单编号:\(reservecell.orderNo)"
//        cell.orderTime.text = "订单时间:\(reservecell.orderTime)"
//        cell.serviceType.text = "订单状态:\(reservecell.orderStatus)"
//        cell.servantName.text = "服务人员:\(reservecell.servantName)"
//        if reservecell.servicePrice != 0{
//        cell.startTime.text = "服务费用:\(reservecell.servicePrice)元"
//        }else {
//            cell.startTime.text = "服务费用:待确定"
//        }
////        cell.pic.image = UIImage(named: reservecell.pic)
//        
//
//        return cell
//    }
//    
//    //导航条详情
//    func reply (){
//        self.dismissViewControllerAnimated(true, completion: nil)
//    }
//    
//    func onMakeNavitem() -> UINavigationItem{
//        println("创建导航条step1")
//        //创建一个导航项
//        var navigationItem = UINavigationItem()
//        //创建左边按钮
//        var leftButton =  UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Reply, target: self, action: "reply")
//        //var leftButton =  UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Bordered, target: self, action: "reply")
//        //导航栏的标题
//        navigationItem.title = "订单列表"
//        //设置导航栏左边按钮
//        navigationItem.setLeftBarButtonItem(leftButton, animated: true)
//        navigationBar.pushNavigationItem(navigationItem, animated: true)
//        
//        
//        return navigationItem
//    }
//    
//    
//    // 下拉刷新方法
//    func refresh() {
//        //if self.refreshControl.refreshing == true {
//        
//        self.refreshControl.attributedTitle = NSAttributedString(string: "Loading...")
//       Infor = refreshReserve(customerid) as! [reserveInfo]
//        self.reserve.reloadData()
//        self.refreshControl.endRefreshing()
//        println("刷新好了")
//        //}
//        //self.automaticallyAdjustsScrollViewInsets = false
//    }
//
//    
//    //从NSUerDefaults 中读取数据
//    func readNSUerDefaults () {
//        
//        var userDefaultes = NSUserDefaults.standardUserDefaults()
//        if  (userDefaultes.stringForKey("customerID")) != nil && (userDefaultes.stringForKey("loginPassword")) != nil{
//            customerid = userDefaultes.stringForKey("customerID")!
//            loginPassword = userDefaultes.stringForKey("loginPassword")!
//            
//        }
//        
//    }
//
//    
//
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        
//        if segue.identifier=="reservedetail"{
//            if let indexPath = self.reserve.indexPathForSelectedRow(){
//                
//               let object = ReserveData[indexPath.row] as reserveInfo
//                println(object)
//                (segue.destinationViewController as! reserveViewController).detailItem = object
//            }
//        }
//
//    }
//    
//
//}
