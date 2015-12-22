//
//  MKBaseWebService.swift
//  MyKitchen
//
//  Created by wochu on 15/12/22.
//  Copyright © 2015年 @Wochu. All rights reserved.
//

import UIKit

typealias SuccessBlock = (task : NSURLSessionDataTask?,responseObject : AnyObject?) -> ()
typealias FailedBlock = (task : NSURLSessionDataTask?,error : NSError) -> ()

class MKBaseWebService: MKObject {

    
    internal var _manager : AFHTTPSessionManager?
    
    var manager : AFHTTPSessionManager?{
        get{return _manager}
        set{_manager = newValue}
    }
    
    internal var _JSONRequestSerializer : AFJSONRequestSerializer?
    
    var JSONRequestSerializer : AFJSONRequestSerializer?{
        get{return _JSONRequestSerializer}
        set{_JSONRequestSerializer = newValue}
    }
    
    internal var _HTTPRequestSerializer : AFHTTPRequestSerializer?
    
    var HTTPRequestSerializer : AFHTTPRequestSerializer?{
        get{return _HTTPRequestSerializer}
        set{_HTTPRequestSerializer = newValue}
    }
    
    required init() {
        _manager = AFHTTPSessionManager(baseURL: NSURL(string: MKBaseConnectorAddress), sessionConfiguration: NSURLSessionConfiguration.defaultSessionConfiguration())
        _manager?.requestSerializer = AFJSONRequestSerializer(writingOptions: .PrettyPrinted)
        _manager?.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/json", "text/javascript", "text/html") as? Set<String>
        _manager?.requestSerializer.timeoutInterval = 20
        _manager?.responseSerializer.acceptableStatusCodes = NSIndexSet(indexesInRange: NSMakeRange(200,200))
        _manager?.securityPolicy = AFSecurityPolicy(pinningMode: .None)
        
        _JSONRequestSerializer = AFJSONRequestSerializer(writingOptions: .PrettyPrinted)
        _HTTPRequestSerializer = AFHTTPRequestSerializer()
        
        super.init()
    }
    
    class func shareService() -> MKBaseWebService {
        struct baseWebService{
            static var onceToken : dispatch_once_t = 0
            static var instance : MKBaseWebService? = nil
        }
        dispatch_once(&baseWebService.onceToken) { () -> Void in
            baseWebService.instance = MKBaseWebService()
        }
        return baseWebService.instance!
    }
    
    func baseURL() ->String{
        return MKBaseConnectorAddress
    }
    
    class func GET(urlString : String,parameters : AnyObject?, successBlock : SuccessBlock!,failedBlock : FailedBlock! ) ->NSURLSessionDataTask?
    {
        if MKGlobalHeader.defaultInstance().accessToken() != nil
        {
            self.shareService().manager?.requestSerializer.setValue(MKGlobalHeader.defaultInstance().accessToken(), forKey: "Authorization")
        }
        let dataTask : NSURLSessionDataTask? = self.shareService().manager?.GET(urlString, parameters: parameters,
            success: { (task : NSURLSessionDataTask, response : AnyObject?) -> Void in
                successBlock(task: task,responseObject: response)
            }, failure: { (task : NSURLSessionDataTask?, error : NSError) -> Void in
               failedBlock(task: task,error: error)
        })
        self.shareService().manager?.requestSerializer = self.shareService().JSONRequestSerializer!
        return dataTask
    }
    
    func responseWithObject(responseObject : AnyObject?){
        if responseObject is NSDictionary {
            let data : NSData! = try? NSJSONSerialization.dataWithJSONObject(responseObject!, options: .PrettyPrinted)
            let dataString = String(data: data, encoding: NSUTF8StringEncoding)
            print(dataString)
        }
    }
    
    class func POST(urlString : String,parameters : AnyObject?,success : SuccessBlock,failedBlock : FailedBlock) -> NSURLSessionDataTask?
    {
        if MKGlobalHeader.defaultInstance().accessToken() != nil {
            self.shareService().manager?.requestSerializer.setValue(MKGlobalHeader.defaultInstance().accessToken(), forKey: "Authorization")
        }
        let dataTask : NSURLSessionDataTask? = self.shareService().manager?.POST(urlString, parameters: parameters, success: {  (task : NSURLSessionDataTask, response : AnyObject?) -> Void in
            success(task: task,responseObject: response)
            }, failure: { (task : NSURLSessionDataTask?, error : NSError) -> Void in
                failedBlock(task: task,error: error)
        })
        self.shareService().manager?.requestSerializer = self.shareService().JSONRequestSerializer!
        return dataTask
    }
    
    class func HEAD(urlString : String,parameters : AnyObject?,success : (task : NSURLSessionDataTask?) -> (),failedBlock : FailedBlock) -> NSURLSessionDataTask? {
        let dataTask : NSURLSessionDataTask? = self.shareService().manager?.HEAD(urlString, parameters: parameters, success: success, failure: failedBlock)
        self.shareService().manager?.requestSerializer = self.shareService().JSONRequestSerializer!
        return dataTask
    }
    
    class func downloadTaskWithRequest(request : NSURLRequest,progress : NSProgress,destionation : (NSURL ,NSURLResponse) -> NSURL ,completionHandler : (NSURLResponse,NSURL,NSError))  {
        
    }
    
    class func requestForHttpSerializer(){
        self.shareService().manager?.requestSerializer = self.shareService().HTTPRequestSerializer!
    }
    
}





















