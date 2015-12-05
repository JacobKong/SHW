//
//  MineTVC.swift
//  
//
//  Created by Zhang on 15/12/5.
//
//

import UIKit

class MineTVC: UITableViewController {
    
    
  let baseArray:[String] = ["基本资料","修改密码","修改头像"]
  let dataArray:[String] = ["我的收藏"]
    //读取本地数据
    var customerid:String  = ""
    var loginPassword:String = ""
    //存储查询的用户信息
    var  MineData:MyInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //读取用户信息，如果不是第一次登录，则会自动登录
        readNSUerDefaults()
        if customerid != "" && loginPassword != ""{
        MineData = QueryInfo(customerid) as MyInfo
            
        }
        let width = self.view.frame.width
        let height = self.view.frame.height
//        self.tableView.frame = CGRectMake(0,0, width, height)
        self.tableView.scrollEnabled = false
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
   //section Number
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 3
    }
   //cell Number
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         if section == 0{
            return 1

           
        }else if section == 1{
          return baseArray.count
        
        }else if section == 2{
           return  dataArray.count
      
        }
        return 0
     }

     
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if indexPath.section == 0 {
            let  cell = tableView.dequeueReusableCellWithIdentifier("HeaderCell", forIndexPath: indexPath) as! HeaderCell
            if customerid != "" && loginPassword != ""{
            //1.定义一个地址字符串常量
                let imageUrlString:String = HttpData.http+"/FamilyServiceSystem/upload/customer/\(MineData.id)/\(MineData.headPicture)"
              cell.Picture.setZYHWebImage(imageUrlString, defaultImage: "touxiang.jpg")
              cell.CustomerName.text = MineData.customerName
              cell.Phone.text = MineData.mobilePhone
                //cell不可被点击
              cell.userInteractionEnabled = false
                
            }else {
              cell.userInteractionEnabled = true
               cell.Picture.image = UIImage(named: "touxiang.jpg")
            }
            //圆角
            cell.Picture.layer.cornerRadius = 50
            cell.Picture.layer.masksToBounds = true
            let color = UIColor  (red: 234/255, green: 103/255, blue: 7/255, alpha: 1.0)
            cell.backgroundColor = color
            return cell
            
            
        }else if indexPath.section == 1{
             let  cell = tableView.dequeueReusableCellWithIdentifier("FooterCell", forIndexPath: indexPath) as! FooterCell
            
              let imageName:[String]  = ["phone.png","tel.png","location.png"]
              var image  = UIImage(named:imageName[indexPath.row])
              cell.Picture.image = image
              cell.Label.text = baseArray[indexPath.row]
              return cell
        }else if indexPath.section == 2{
            let  cell = tableView.dequeueReusableCellWithIdentifier("FooterCell", forIndexPath: indexPath) as! FooterCell
            
            let imageName:[String]  = ["phone.png"]
            var image  = UIImage(named:imageName[indexPath.row])
            cell.Picture.image = image
            cell.Label.text = dataArray[indexPath.row]

            return cell
        }
        

       
 
        return cell
    }


    //set Cell Row Height
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var  h = 50
        if indexPath.section == 0{
        h =  140;
        }else {
        h = 50
        }
        return CGFloat(h)
    }
    //set Footer Height
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    //set Header Height
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0000000000000000000000001
    }
    
    //cell  DidSelectAction
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
          
            
//            let sb = UIStoryboard(name: "Main", bundle: nil)
//            let vc = sb.instantiateViewControllerWithIdentifier("LoginVC") as! UIViewController
            let vc = LoginVC()
            self.navigationController!.pushViewController(vc, animated:true)
            

            
            
        }else if indexPath.section == 1{
            
            if customerid != "" && loginPassword != ""{
                
                var x = indexPath.row
                switch(x){
                case 0:
                    let vc = BaseInfoVC()
                    self.navigationController!.pushViewController(vc, animated:true)
                    
                    break
                case 1:
                    
                    let vc = ChangePasswordVC()
                    vc.Password = MineData.loginPassword
                    vc.id = MineData.id
                    self.navigationController!.pushViewController(vc, animated:true)

                    break
                    
                default:
//                    let vc = ChangeHeadPictureVC()
//                    vc.Picturename = MineData.headPicture
//                    vc.customerID = MineData.customerID
//                    self.navigationController!.pushViewController(vc, animated:true)

                    break
                }
                

                
            }else{
                
                let vc = LoginVC()
                self.navigationController!.pushViewController(vc, animated:true)
                
            }
       
            
 
            
                
        }else if indexPath.section == 2{
           
            
            
            
       }
        

        
    }
    

    //从NSUerDefaults 中读取数据
    func readNSUerDefaults () {
        
        var userDefaultes = NSUserDefaults.standardUserDefaults()
        if  (userDefaultes.stringForKey("customerID")) != nil && (userDefaultes.stringForKey("loginPassword")) != nil{
            customerid = userDefaultes.stringForKey("customerID")!
            loginPassword = userDefaultes.stringForKey("loginPassword")!
            
        }
        
    }
    
    
}
