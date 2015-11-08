//: Playground - noun: a place where people can play

import UIKit


var url: NSURL! = NSURL(string:"http://59.46.2.105:8080/FamilyServiceSystem/ MobileRefundAction?operation=_query")


var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)

request.HTTPMethod = "POST"

 var param:String = "{\"orderNo\":\"7841efcd-0e5b-4136-8fd1-2293be444a46\"}"
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
var test2: AnyObject?=json.objectForKey("data")
//var test3:AnyObject? = json.objectForKey("types")
let jsonArray = test2 as? NSArray
var count = jsonArray?.count
for value in jsonArray!{
    var confirmTime:String=value.objectForKey("countyName") as! String
 
}



