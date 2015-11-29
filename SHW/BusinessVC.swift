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
    
    //下拉刷新
    var refreshControl = UIRefreshControl()
    var timer: NSTimer!
    //上拉加载更多
    var page = 1//下拉加载后的页数
    var allpage:Int?
    var loadMoreText = UILabel()
    //列表的底部，用于显示“上拉查看更多”的提示，当上拉后显示类容为“松开加载更多”。
    let tableFooterView = UIView()
    
    @IBOutlet weak var businessTable: UITableView!
    //声明一个数组businesss来保存获取的信息
    var ServantData:[ServantInfo] = []
    var selectbusiness:[facilitatorInfo] = []
  
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var width = self.view.frame.width
        var height = self.view.frame.height
        businessTable.dataSource = self
        businessTable.delegate = self
        //读取本地存储的地址
        readNSUerDefaults()
        
        //类型
        serviceTypeData = refreshServiceType(FirstType!) as![ServiceType]
        for var i = 0;i < serviceTypeData.count;i++ {
            data2 += [serviceTypeData[i].typeName] // 小类名称
            Person +=  [serviceTypeData[i].isPerson]
        }
        SecondType  = data2[row1]
        //区域
        data12 = queryCounty(location) as! [String]
        data1 += data12
        data11 += data12
        
        if  Person[0] == "1" {
            isPerson = 1
        }else{
            isPerson = 0
        }
        
        loadData()
        
        var menu = JSDropDownMenu(origin: CGPoint(x: 0.0,y: 0.0), andHeight: 36)
        menu.indicatorColor = UIColor(red: 175.0/255.0, green: 175.0/255.0, blue: 175.0/255.0, alpha: 1.0)
        menu.separatorColor = UIColor(red: 210.0/255.0, green: 210.0/255.0, blue: 210.0/255.0, alpha: 1.0)
        menu.textColor = UIColor(red: 83.0/255.0, green: 83.0/255.0, blue: 83.0/255.0, alpha: 1.0)
        menu.dataSource = self;
        menu.delegate = self
        label.removeFromSuperview()
        self.view.addSubview(menu)
       
//        //初始下拉刷新控件
//        refreshControl.attributedTitle = NSAttributedString(string: "松开后自动刷新")
//        //背景色和tint颜色都要清除,保证自定义下拉视图高度自适应
//        //refreshControl.tintColor = UIColor.clearColor()
//        refreshControl.backgroundColor = UIColor.clearColor()
//        refreshControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
//        businessTable.addSubview(refreshControl)
//        //上拉加载更多
//        self.createTableFooter()

        writing = UIButton(frame: CGRect(x: width-100, y: height-200, width: 100, height:50))
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
        
       refresh()
        
        self.view.addSubview(writing)
        
        
    }
    
    //默认的下拉刷新模式
    func refresh(){
        
       businessTable.headerView = XWRefreshNormalHeader(target: self, action: "upPullLoadData")
       businessTable.headerView!.beginRefreshing()
       businessTable.headerView!.endRefreshing()
       businessTable.footerView = XWRefreshAutoNormalFooter(target: self, action: "downPlullLoadData")
     }
    //MARK: 下拉刷新数据
    func upPullLoadData(){
            page = 1
            loadData()
            businessTable.reloadData()
            businessTable.headerView?.endRefreshing()
            businessTable.footerView?.endRefreshing()

     
    }
    //上拉加载
    func downPlullLoadData(){
        page++
        println("pagennn\(page)")
        if  page <= allpage {
            loadData()
            businessTable.reloadData()
            businessTable.footerView?.endRefreshing()

        }else {
             businessTable.footerView?.allRefreshing()
        }
        
    }

    
//    // 下拉刷新方法
//    func refresh() {
//        self.refreshControl.attributedTitle = NSAttributedString(string: "数据加载中...")
//        //模拟加载数据
//        page = 1
//        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self,
//            selector: "loadData", userInfo: nil, repeats: true)
//    }
    
    
    //计时器时间到,加载数据
    func loadData() {
        
        if isPerson == 1 {
            var data = refreshServant(SecondType,attributeName,upDown,facilitatorCounty,page) as! [ServantInfo]
            ServantData += data
            data3 = ["默认排序","人员星级"]
            data31 = ["","servantScore"]
            writing.enabled = false
            writing.hidden = true
            allpage = GetSPage(SecondType,attributeName,upDown,facilitatorCounty,page)
        }else if isPerson == 0 {
            var data = refreshFacilitator(SecondType,attributeName,upDown,facilitatorCounty,page) as! [facilitatorInfo]
            selectbusiness += data
            data3 = ["默认排序","点击次数由高到低","信用评分由高到低"]
            data31 = ["","clientClick","creditScore"]
            writing.enabled = true
            writing.hidden = false
            allpage = GetFPage(SecondType,attributeName,upDown,facilitatorCounty,page)
        }
        self.businessTable.reloadData()
//        self.refreshControl.endRefreshing()
//        timer?.invalidate()
//        timer = nil
    }
    
    
 
//    func createTableFooter(){//初始化tv的footerView
//        
//        self.businessTable.tableFooterView = nil
//        
//        tableFooterView.frame = CGRectMake(0, 0, self.businessTable.bounds.size.width, 30)
//        
//        loadMoreText.frame =  CGRectMake(0, 0, self.businessTable.bounds.size.width, 30)
//        
//        loadMoreText.text = "上拉查看更多"
//        loadMoreText.textColor = UIColor.grayColor()
//        loadMoreText.font = UIFont.boldSystemFontOfSize(12)
//        loadMoreText.textAlignment = NSTextAlignment.Center
//        
//        tableFooterView.addSubview(loadMoreText)
//        
//        self.businessTable.tableFooterView = tableFooterView
//        
//    }
//    
//    func scrollViewDidScroll(scrollView: UIScrollView){//开始上拉到特定位置后改变列表底部的提示
//        
//        if scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height + 30){
//            
//            loadMoreText.text = "松开载入更多"
//            
//        }else{
//            
//            loadMoreText.text = "上拉查看更多"
//            
//        }
//        
//    }
//    
//    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool){
//        
//        loadMoreText.text = "上拉查看更多"
//        
//        /*上拉到一定程度松开后开始加载更多*/
//        
//        if scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height + 30){
//            
//            page++
//            if page <= allpage {
//               loadData()
//            }else {
//                loadMoreText.text = "全部加载完成"
//                
//            }
//            self.businessTable.reloadData()
//            
//        }
//        
//    }
    
    
    override func viewDidLayoutSubviews() {
        var width = self.view.frame.width
        businessTable.frame =  CGRectMake(0, 36, width, self.view.frame.height-36)
    }
    
    
    //-------------------Table view data source-----------------------------
    // 根据indexPath(section,row)创建每行cell及其内容
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
          //创建cell
        var cell = UITableViewCell()
        
        
        if isPerson == 0 {
            
           let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCell
            
            let business = selectbusiness[indexPath.row] as facilitatorInfo
            cell.name.text = business.facilitatorName//名称
            cell.address.text = "\(business.creditScore)分 " //信用评分
          
            //网络地址获取图片
            //1.定义一个地址字符串常量
            let imageUrlString:String = HttpData.http+"/FamilyServiceSystem\(business.facilitatorLogo)"
            
            
            cell.picture.setZYHWebImage(imageUrlString, defaultImage: "reserve2.jpg")
            cell.officePhone.text =   business.contactAddress//地址
            cell.dizhi.text = "信用评分:"
            cell.dianhua.text =  "联系地址:"
            return cell
            
          }else if isPerson == 1 {
            
            println("ddddddddd")
            let cell = tableView.dequeueReusableCellWithIdentifier("ServantCell", forIndexPath: indexPath) as! ServantCell

            let Data = ServantData[indexPath.row] as ServantInfo
            
            cell.servantname.text = Data.servantName //名称
            cell.facilitator.text = Data.facilitatorName//所属公司
            
            
            //1.定义一个地址字符串常量
            let imageUrlString:String = HttpData.http+"/FamilyServiceSystem/upload/servant/\(Data.id)/\(Data.headPicture)"
            
            cell.picture.setZYHWebImage(imageUrlString, defaultImage: "122.jpg")
            
            cell.salaryTitle.text = "期望薪资"
//            cell.salary.text = "\(Data.)"
            return cell
          
         }
        
        return cell
    }
    
    
    
    func package (){
        
        self.performSegueWithIdentifier("toPackage", sender: self)
        
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
    
    
    
//顶部下拉选择控件
//列数
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
//当前选择
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
//具体显示条数
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
//初始显示
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
//具体显示内容
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
        if (indexPath.column == 0) {
            currentData1Index = indexPath.row
            column0 = 0
            row0   =  indexPath.row
        } else if(indexPath.column == 1){
            currentData2Index = indexPath.row;
            row1   =  indexPath.row
            if  serviceTypeData[row1].isPerson == "1"{
                data3 = ["默认排序","人员星级"]
                data31 = ["","servantScore"]
                rightButton.title = ""
                writing.enabled = false
                writing.hidden = true
            }else{
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
        
        if  Person[row1]  == "1"{
            isPerson =  1
            page = 1
          
        }else {
            isPerson =  0
            page = 1
           
        }
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    //从NSUerDefaults 中读取数据
    func readNSUerDefaults () {
        
        var userDefaultes = NSUserDefaults.standardUserDefaults()
        
        if  (userDefaultes.stringForKey("location")) != nil{
            location = userDefaultes.stringForKey("location")!
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
