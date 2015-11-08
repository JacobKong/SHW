//
//  reserveData.swift
//  SHW
//
//  Created by Zhang on 15/7/17.
//  Copyright (c) 2015年 star. All rights reserved.


import Foundation
import UIKit
//var FinishiData:[Finishinfo] = []

class reserveInfo:NSObject {
    var confirmTime:String
    var customerEvaluate:String
    var customerID:String
    var customerName:String
    var facilitatorID:String
    
    var facilitatorName:String
    var id:Int
    var itemID:String
    var itemName:String
    var orderNo:String
    
    var orderStatus:String
    var orderTime:String
    var overTime:String
    var paidAmount:Float
    var remarks:String
    
    var servantID:String
    var servantName:String
    var serviceContent:String
    var servicePrice:Float
    var serviceType:String
    

    var startTime:String
    init(confirmTime:String,customerEvaluate:String,customerID:String,customerName:String,facilitatorID:String,
        facilitatorName:String,id:Int,itemID:String,itemName:String,orderNo:String,orderStatus:String,orderTime:String,overTime:String,paidAmount:Float,remarks:String,servantID:String,servantName:String,serviceContent:String,servicePrice:Float ,serviceType:String,startTime:String){
            self.confirmTime = confirmTime
            self.customerEvaluate = customerEvaluate
            self.customerID = customerID
            self.customerName = customerName
            self.facilitatorID = facilitatorID
            
            self.facilitatorName = facilitatorName
            self.id = id
            self.itemID = itemID
            self.itemName = itemName
            self.orderNo = orderNo
            
            self.orderStatus = orderStatus
            self.orderTime = orderTime
            self.overTime = overTime
            self.paidAmount = paidAmount
            self.remarks = remarks
            
            self.servantID = servantID
            self.servantName = servantName
            self.serviceContent = serviceContent
            self.servicePrice = servicePrice
            self.serviceType = serviceType
            
            self.startTime = startTime
            super.init()
    }
    
}


func refreshReserve(customerID:String) ->NSArray  {
 
    var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileServiceOrderAction?operation=_processingOrder")
    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    //var param:String = "{\"customerAccount\":\"Alex\",\"Password\":\"a123\"}"
    var param:String = "{\"customerID\":\"\(customerID)\"}"
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
    var ReserveData:[reserveInfo] = []
    var test1: AnyObject?=json.objectForKey("serverResponse")
    var response1 :String = test1 as! String
    if  response1 == "Success"{
    var test2: AnyObject?=json.objectForKey("data")
    let jsonArray = test2 as? NSArray
    var count = jsonArray?.count
 
    for value in jsonArray!{
        var confirmTime:String=value.objectForKey("confirmTime") as! String
        var customerEvaluate:String=value.objectForKey("customerEvaluate") as! String
        var customerID:String=value.objectForKey("customerID") as! String
        var customerName:String=value.objectForKey("customerName") as! String
        var facilitatorID:String=value.objectForKey("facilitatorID") as! String
        
        var facilitatorName:String=value.objectForKey("facilitatorName") as! String
        var id:Int=value.objectForKey("id") as! Int
        var itemID:String=value.objectForKey("itemID") as! String
        var itemName:String=value.objectForKey("itemName") as! String
        var orderNo:String=value.objectForKey("orderNo") as! String
        
        var orderStatus:String=value.objectForKey("orderStatus") as! String
        var orderTime:String=value.objectForKey("orderTime") as! String
        var overTime:String=value.objectForKey("overTime") as! String
        var paidAmount:Float=value.objectForKey("paidAmount") as! Float
        var remarks:String=value.objectForKey("remarks") as! String
        
        var servantID:String=value.objectForKey("servantID") as! String
        var servantName:String=value.objectForKey("servantName") as! String
        var serviceContent:String=value.objectForKey("serviceContent") as! String
        var servicePrice:Float=value.objectForKey("servicePrice") as! Float
        var serviceType:String=value.objectForKey("serviceType") as! String
        
        var startTime:String=value.objectForKey("startTime") as! String
        
        let obj:reserveInfo=reserveInfo(confirmTime: confirmTime,customerEvaluate: customerEvaluate, customerID: customerID, customerName: customerName, facilitatorID: facilitatorID, facilitatorName: facilitatorName, id: id, itemID: itemID, itemName: itemName, orderNo: orderNo, orderStatus: orderStatus, orderTime: orderTime, overTime: overTime, paidAmount: paidAmount, remarks: remarks, servantID: servantID, servantName: servantName, serviceContent: serviceContent, servicePrice: servicePrice, serviceType: serviceType, startTime: startTime)
        //println(obj.facilitatorID+" "+obj.facilitatorName);
        //        var FinishiData:[Finishinfo] = []
        ReserveData += [obj]
        // obj.confirmTime = a;
        //        var b: AnyObject?=value.objectForKey("customerEvaluate")
        //        finishinfo.customerEvaluate = b
        //        var c: AnyObject?=value.objectForKey("customerName")
        //        finishinfo.customerName = c
        
       }
    }
    return ReserveData
    
}
