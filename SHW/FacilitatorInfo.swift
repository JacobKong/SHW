 //
//  FacilitatorInfo.swift
//  SHW
//
//  Created by Zhang on 15/7/17.
//  Copyright (c) 2015年 star. All rights reserved.
//

import Foundation

import UIKit
// 
//var selectInfo:String?
class facilitatorInfo:NSObject {
    var id :Int
    var facilitatorName:String
    //var companyName :String
    var facilitatorID:String
    var officePhone:String
    
    var qqNumber:String
    var contactPhone:String
    var facilitatorProvince:String
    var facilitatorCity:String
    var facilitatorCounty:String
    
    var emailAddress:String
    var contactAddress:String
    var registerTime: String
    var facilitatorLevel:Int
    var creditScore:String
//    var scoreImg:Int
//    var levelImg:Int
    
    var facilitatorIntro: String
    var facilitatorLogo:String
    var facilitatorStatus:String
    var serviceCount: Int

    init( id:Int,facilitatorName:String,facilitatorID:String,officePhone:String,qqNumber:String,contactPhone:String,facilitatorProvince:String,facilitatorCity:String,facilitatorCounty:String,emailAddress:String,contactAddress:String,registerTime: String,facilitatorLevel:Int,creditScore:String ,
        facilitatorIntro: String,facilitatorLogo:String,facilitatorStatus:String,serviceCount: Int){
            self.id = id
            self.facilitatorName = facilitatorName
            //self.companyName = companyName
            self.facilitatorID = facilitatorID
            self.officePhone = officePhone
            
            self.qqNumber = qqNumber
            self.contactPhone = contactPhone
            self.facilitatorProvince = facilitatorProvince
            self.facilitatorCity = facilitatorCity
            self.facilitatorCounty = facilitatorCounty
            
            self.emailAddress = emailAddress
            self.contactAddress = contactAddress
            self.registerTime = registerTime
            self.facilitatorLevel = facilitatorLevel
            self.creditScore = creditScore
            
            self.facilitatorIntro = facilitatorIntro
            self.facilitatorLogo = facilitatorLogo
            self.facilitatorStatus = facilitatorStatus
            self.serviceCount = serviceCount
        
            super.init()
    }
    
}

//1.1. 查询提供某一服务的所有商家
func refreshFacilitator(secondType:String,attributeName:String,upDown:String,facilitatorCounty:String) ->NSArray  {
    var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileFacilitatorInfoAction?operation=_byServiceType")
    
    println("更新商家信息")
    
    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    //var param:String = "{\"customerAccount\":\"Alex\",\"Password\":\"a123\"}"
    var param:String = "{\"type\":\"\(secondType)\",\"attributeName\":\"\(attributeName)\",\"upDown\":\"\(upDown)\",\"facilitatorCounty\":\"\(facilitatorCounty)\"}"
    var data:NSData = param.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
    request.HTTPBody = data;
    var response:NSURLResponse?
    var error:NSError?
    var receiveData:NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
    if (error != nil)
    {
        println(error?.code)
        println(error?.description)
    }
    else
    {
        var jsonString = NSString(data:receiveData!, encoding: NSUTF8StringEncoding)
        println(jsonString)
        
    }
    
    let json:AnyObject! = NSJSONSerialization.JSONObjectWithData(receiveData!, options: NSJSONReadingOptions.AllowFragments, error: nil)
    //var finishinfo = finishinfo()
    //var FinishData:[finishinfo] = []
    var test1: AnyObject?=json.objectForKey("serverResponse")
    var serverResponse:String = test1 as! String 
    
    var FacilitatorData:[facilitatorInfo] = []
    if  serverResponse == "Success" {
    var test2: AnyObject?=json.objectForKey("data")
    println(test2)
    let jsonArray = test2 as? NSArray
    var count = jsonArray?.count
   
    for value in jsonArray!{
        var id:Int=value.objectForKey("id") as! Int
        var facilitatorName:String=value.objectForKey("facilitatorName") as! String
        //var companyName:String=value.objectForKey("companyName") as! String
        var facilitatorID:String=value.objectForKey("facilitatorID") as! String
        var officePhone:String=value.objectForKey("officePhone") as! String
        
        
        
        var qqNumber:String=value.objectForKey("qqNumber") as! String
        var contactPhone:String=value.objectForKey("contactPhone") as! String
        var facilitatorProvince:String=value.objectForKey("facilitatorProvince") as! String
        var facilitatorCity:String=value.objectForKey("facilitatorCity") as! String
        var facilitatorCounty:String=value.objectForKey("facilitatorCounty") as! String
        
        
        var emailAddress:String=value.objectForKey("emailAddress") as! String
        var contactAddress:String=value.objectForKey("contactAddress") as! String
        var registerTime:String=value.objectForKey("registerTime") as! String
        var facilitatorLevel:Int=value.objectForKey("facilitatorLevel") as! Int
        var creditScore:String = value.objectForKey("creditScore") as! String
        
        
        
        var facilitatorIntro:String=value.objectForKey("facilitatorIntro") as! String
        var facilitatorLogo:String=value.objectForKey("facilitatorLogo") as! String
        var facilitatorStatus:String=value.objectForKey("facilitatorStatus") as! String
        
        var serviceCount:Int=value.objectForKey("serviceCount") as! Int
        var serviceType:String = value.objectForKey("serviceTypeArray") as! String
        let obj:facilitatorInfo = facilitatorInfo(id:id,facilitatorName:facilitatorName,facilitatorID:facilitatorID,officePhone:officePhone,qqNumber:qqNumber,contactPhone:contactPhone,facilitatorProvince:facilitatorProvince,facilitatorCity:facilitatorCity,facilitatorCounty:facilitatorCounty,emailAddress:emailAddress,contactAddress:contactAddress,registerTime: registerTime,facilitatorLevel:facilitatorLevel,creditScore:creditScore,
            facilitatorIntro: facilitatorIntro,facilitatorLogo:facilitatorLogo,facilitatorStatus:facilitatorStatus,serviceCount: serviceCount)
        //println(obj.facilitatorID+" "+obj.facilitatorName);
        //        var FinishiData:[Finishinfo] = []
        FacilitatorData += [obj]
        // obj.confirmTime = a;
        //        var b: AnyObject?=value.objectForKey("customerEvaluate")
        //        finishinfo.customerEvaluate = b
        //        var c: AnyObject?=value.objectForKey("customerName")
        //        finishinfo.customerName = c
        
       }
    }
    return FacilitatorData
    
}
//1.2. 查询提供某一服务的所有人员
func refreshServant(secondType:String,attributeName:String,upDown:String,facilitatorCounty:String) ->NSArray  {
    
    var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileFacilitatorInfoAction?operation=_byServiceType")
    
    println("更新人员信息")
    
    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    var param:String = "{\"type\":\"\(secondType)\",\"attributeName\":\"\(attributeName)\",\"upDown\":\"\(upDown)\",\"facilitatorCounty\":\"\(facilitatorCounty)\"}"
    var data:NSData = param.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
    request.HTTPBody = data;
    var response:NSURLResponse?
    var error:NSError?
    var receiveData:NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
    if (error != nil)
    {
        println(error?.code)
        println(error?.description)
    }
    else
    {
        var jsonString = NSString(data:receiveData!, encoding: NSUTF8StringEncoding)
        println(jsonString)
        
    }
    
    let json:AnyObject! = NSJSONSerialization.JSONObjectWithData(receiveData!, options: NSJSONReadingOptions.AllowFragments, error: nil)
    var test1: AnyObject?=json.objectForKey("serverResponse")
    var serverResponse:String = test1 as! String
    var ServantData:[ServantInfo] = []
    if serverResponse == "Success" {
    var test2: AnyObject?=json.objectForKey("data")
    let jsonArray = test2 as? NSArray
    var count = jsonArray?.count

    for value in jsonArray!{
        var id:Int=value.objectForKey("id") as! Int
        var servantID:String=value.objectForKey("servantID") as! String
        var servantName:String=value.objectForKey("servantName") as! String
        var phoneNo:String=value.objectForKey("phoneNo") as! String
        var servantMobile:String=value.objectForKey("servantMobil") as! String
        var educationLevel:String=value.objectForKey("educationLevel") as! String
        
     
        
        var trainingIntro:String=value.objectForKey("trainingIntro") as! String
        var servantProvince:String=value.objectForKey("servantProvince") as! String
        var servantCity:String=value.objectForKey("servantCity") as! String
        var servantCounty:String=value.objectForKey("servantCounty") as! String
        var servantGender:String=value.objectForKey("servantGender") as! String
        
        
        var headPicture:String=value.objectForKey("headPicture") as! String
        var workYears:Float=value.objectForKey("workYears") as! Float
        var servantHonors:String=value.objectForKey("servantHonors") as! String
        var servantIntro:String = value.objectForKey("servantIntro") as! String
        var isStayHome:Bool = value.objectForKey("isStayHome") as! Bool
        
        
        
        var holidayInMonth:Int=value.objectForKey("holidayInMonth") as! Int
        var servantScore:String=value.objectForKey("servantScore") as! String
        var servantStatus:String=value.objectForKey("servantStatus") as! String
        
        var serviceCount:Int = value.objectForKey("serviceCount") as! Int
        var careerType:String = value.objectForKey("careerType") as! String
        
        
        var serviceItems:String = value.objectForKey("serviceItems") as! String
        var facilitatorName:String = value.objectForKey("facilitatorName") as! String
        var facilitatorID:String = value.objectForKey("facilitatorID") as! String
        
        
        let obj:ServantInfo = ServantInfo(id:id,servantID:servantID,servantName:servantName,phoneNo:phoneNo,servantMobil:servantMobile,educationLevel : educationLevel,trainingIntro : trainingIntro,servantProvince : servantProvince,
            servantCity : servantCity,
            servantCounty : servantCounty,
            servantGender : servantGender,
            
            headPicture : headPicture,
            workYears : workYears,
            servantHonors : servantHonors,
            servantIntro : servantIntro,
            isStayHome : isStayHome,
            
            holidayInMonth : holidayInMonth,
            servantScore : servantScore,
            servantStatus : servantStatus,
            serviceCount : serviceCount,
            careerType : careerType,
            
            serviceItems : serviceItems,
            facilitatorName : facilitatorName,
            facilitatorID : facilitatorID)
        
        ServantData += [obj]
        
        }
    }
    return ServantData
    
}
//商家详情
 func refreshFDetail (facilitatorID:String)->facilitatorInfo{
    var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileFacilitatorInfoAction?operation=_detailQuery")
    println("查询指定facilitatorID商家")
    
    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    //var param:String = "{\"customerAccount\":\"Alex\",\"Password\":\"a123\"}"
    var param:String = "{\"facilitatorID\":\"\(facilitatorID)\"}"
    println("param:\(param)")
    var data:NSData = param.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
    request.HTTPBody = data;
    var response:NSURLResponse?
    var error:NSError?
    var receiveData:NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
    if (error != nil)
    {
        println(error?.code)
        println(error?.description)
    }
    else
    {
        var jsonString = NSString(data:receiveData!, encoding: NSUTF8StringEncoding)
//        println(jsonString)
        
    }
    
    let json:AnyObject! = NSJSONSerialization.JSONObjectWithData(receiveData!, options: NSJSONReadingOptions.AllowFragments, error: nil)
 
    var detailData:facilitatorInfo?
    var test1: AnyObject?=json.objectForKey("serverResponse")
    
    var serverResponse:String = test1 as! String
    
 
    if  serverResponse == "Success" {
    var basic: AnyObject?=json.objectForKey("basic")
    var id:Int=basic!.objectForKey("id") as! Int
    var facilitatorName1:String=basic!.objectForKey("facilitatorName") as! String
    //var companyName1:String=basic!.objectForKey("companyName") as! String
    var facilitatorID1:String=basic!.objectForKey("facilitatorID") as! String
    var officePhone1:String=basic!.objectForKey("officePhone") as! String
    
    
    
    var qqNumber1:String=basic!.objectForKey("qqNumber") as! String
    var contactPhone1:String=basic!.objectForKey("contactPhone") as! String
    var facilitatorProvince1:String=basic!.objectForKey("facilitatorProvince") as! String
    var facilitatorCity1:String=basic!.objectForKey("facilitatorCity") as! String
    var facilitatorCounty1:String=basic!.objectForKey("facilitatorCounty") as! String
    
    
    var emailAddress1:String=basic!.objectForKey("emailAddress") as! String
    var contactAddress1:String=basic!.objectForKey("contactAddress") as! String
    var registerTime1:String=basic!.objectForKey("registerTime") as! String
    var facilitatorLevel1:Int=basic!.objectForKey("facilitatorLevel") as! Int
    var creditScore1:String = basic!.objectForKey("creditScore") as! String
    
    
    
    var facilitatorIntro1:String=basic!.objectForKey("facilitatorIntro") as! String
    var facilitatorLogo1:String=basic!.objectForKey("facilitatorLogo") as! String
    var facilitatorStatus1:String=basic!.objectForKey("facilitatorStatus") as! String
    
    var serviceCount1:Int=basic!.objectForKey("serviceCount") as! Int
    
    let obj:facilitatorInfo = facilitatorInfo(id:id,facilitatorName:facilitatorName1,facilitatorID:facilitatorID1,officePhone:officePhone1,qqNumber:qqNumber1,contactPhone:contactPhone1,facilitatorProvince:facilitatorProvince1,facilitatorCity:facilitatorCity1,facilitatorCounty:facilitatorCounty1,emailAddress:emailAddress1,contactAddress:contactAddress1,registerTime: registerTime1,facilitatorLevel:facilitatorLevel1,creditScore:creditScore1,
        facilitatorIntro: facilitatorIntro1,facilitatorLogo:facilitatorLogo1,facilitatorStatus:facilitatorStatus1,serviceCount: serviceCount1)
    
      detailData = obj
    }
    
    return detailData!
    
}
 //是否被收藏
 func GetCollect (facilitatorID:String,customerID:String)->String{
    var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileFacilitatorInfoAction?operation=_detailQuery")
    println("是否被收藏")
    
    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    //var param:String = "{\"customerAccount\":\"Alex\",\"Password\":\"a123\"}"
    var param:String = "{\"facilitatorID\":\"\(facilitatorID)\",\"customerID\":\"\(customerID)\"}"
    var data:NSData = param.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
    request.HTTPBody = data;
    var response:NSURLResponse?
    var error:NSError?
    var receiveData:NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
    if (error != nil)
    {
        println(error?.code)
        println(error?.description)
    }
    else
    {
        var jsonString = NSString(data:receiveData!, encoding: NSUTF8StringEncoding)
//        println(jsonString)
        
    }
    
    let json:AnyObject! = NSJSONSerialization.JSONObjectWithData(receiveData!, options: NSJSONReadingOptions.AllowFragments, error: nil)
    var collect: AnyObject?=json.objectForKey("isCollected")
//    println(collect)
    var isCollected :String = collect as! String
    
    return isCollected
  }
 
 
 
 
//添加收藏时的函数
func addCollection(n:String) ->String  {
    //要改URL
    
    var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileFacilitatorCollectionAction?operation=_add")
    
    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    //要改参数类型
    var param:String = "{\"typeName\":\"\(n)\"}"
    //println("typeName\(select)")
    var data:NSData = param.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
    request.HTTPBody = data;
    var response:NSURLResponse?
    var error:NSError?
    var receiveData:NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
    if (error != nil)
    {
        println(error?.code)
        println(error?.description)
    }
    else
    {
        var jsonString = NSString(data:receiveData!, encoding: NSUTF8StringEncoding)
        println(jsonString)
        
    }
    
    let json:AnyObject! = NSJSONSerialization.JSONObjectWithData(receiveData!, options: NSJSONReadingOptions.AllowFragments, error: nil)
    
    
    var serviceresponse: AnyObject?=json.objectForKey("serverResponse")
    var Response :String = serviceresponse as! String


    return Response
}
 //取消收藏时的函数
 /*func deleteCollection(select:String) ->String  {
    //要改URL
    var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileFacilitatorCollectionAction?operation=_add")
    
    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    //要改参数类型
    //var param:String = "{\"customerID\":\"\(customerid)\",\"facilitatorID\":\"\(detailItem.facilitatorID)\",\"facilitatorName\":\"\(detailItem.facilitatorName)\"}"
    
    var data:NSData = param.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
    request.HTTPBody = data;
    var response:NSURLResponse?
    var error:NSError?
    var receiveData:NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
    if (error != nil)
    {
        println(error?.code)
        println(error?.description)
    }
    else
    {
        var jsonString = NSString(data:receiveData!, encoding: NSUTF8StringEncoding)
        println(jsonString)
        
    }
    
    let json:AnyObject! = NSJSONSerialization.JSONObjectWithData(receiveData!, options: NSJSONReadingOptions.AllowFragments, error: nil)

    
    
    var serviceresponse: AnyObject?=json.objectForKey("serverResponse")
    var Response :String = serviceresponse as! String
    
    
    return Response
 }*/
 
// 
// class CountyInfo:NSObject {
//    var id :Int
//    var cityCode:String
//    var cityName:String
//    var countyName:String
//    var isCovered:String
//        init( id:Int,cityCode:String,cityName:String,countyName:String,isCovered:String){
//            self.id = id
//            self.cityCode = cityCode
//            self.cityName = cityName
//            self.countyName = countyName
//            self.isCovered = isCovered
//            super.init()
//    }
//    
// }

 func queryCounty(cityName:String) ->NSArray  {
    //要改URL
    
    var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileCountyInfoAction?operation=_querycoveredCounty")
    println(url)
    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    //要改参数类型
    var param:String = "{\"cityName\":\"\(cityName)\"}"
    println("cityName:\(cityName)") 
    var data:NSData = param.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
    request.HTTPBody = data;
    var response:NSURLResponse?
    var error:NSError?
    var receiveData:NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
    if (error != nil)
    {
        println(error?.code)
        println(error?.description)
    }
    else
    {
        var jsonString = NSString(data:receiveData!, encoding: NSUTF8StringEncoding)
       println(jsonString)
        
    }
    
    let json:AnyObject! = NSJSONSerialization.JSONObjectWithData(receiveData!, options: NSJSONReadingOptions.AllowFragments, error: nil)
    
    //var detailData:CountyInfo!
    var test1: AnyObject?=json.objectForKey("serverResponse")
    var serverResponse:String = test1 as! String
    
    var countyData:[String] = []
    if  serverResponse == "Success" {
    var test2: AnyObject?=json.objectForKey("data")
    
    let jsonArray = test2 as? NSArray
    var count = jsonArray?.count
   
        
        
    for value in jsonArray!{
        
//          var id:Int=value.objectForKey("id") as! Int
//          println("id")
//        
//          println("zenemhuishi")
//        var cityCode:String=basic!.objectForKey("cityCode") as! String
//        println("cityCode\(cityCode)")
//        var cityName:String=basic!.objectForKey("cityName") as! String
//        println("cityName\(cityName)")
       var countyName:String=value.objectForKey("countyName") as! String
//        var isCovered:String=basic!.objectForKey("isCovered") as! String
//        println("countyName:\(countyName)")
//        
//        let obj:CountyInfo = CountyInfo(id:id,cityCode:cityCode,cityName:cityName,countyName:countyName,isCovered:isCovered)
//        detailData = obj
          
   
            countyData += [countyName]
            
        }
    }
    
    return countyData
    
        
 }