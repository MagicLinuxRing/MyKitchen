//
//  MKBaseAccess.swift
//  MyKitchen
//
//  Created by wochu on 15/12/22.
//  Copyright © 2015年 @Wochu. All rights reserved.
//

import UIKit

let __tempConfiture : String = "client/v1/"

class MKBaseAccess: MKBaseWebService {
    
    required init() {
        super.init()
    }
    
    class func assembleURLString(urlString : String) -> String {
        return "\(__tempConfiture)\(urlString)"
    }
    
    class func verifyResponseObject(responseObject : AnyObject) -> NSError! {
        
        if ((responseObject["hasError"] as? Int) > 0){
            var error : NSError?
            
            if responseObject["errorCode"] is NSNull{
                error = NSError(domain: "MKBaseAccessDomain", code: -10001, userInfo: [NSLocalizedDescriptionKey : responseObject["errorMessage"]!!])
            }
            else{
                error = NSError(domain: "MKBaseAccessDomain", code: -10000, userInfo: [NSLocalizedDescriptionKey : responseObject["errorMessage"]!!])
            }
            return error
        }
        return nil
    }
    
    class func GET(urlString : String, parameters : AnyObject, action : (dataTask : NSURLSessionDataTask ,results : AnyObject? ,justError : NSError?)->()) ->NSURLSessionDataTask
    {
        let dataTask : NSURLSessionDataTask = self.GET(urlString, parameters: parameters, successBlock: { (task, responseObject) -> () in
                let error : NSError? = self.verifyResponseObject(responseObject!)
                if  error != nil{
                    print(error!.localizedDescription)
                }
                    action(dataTask: task!,results: responseObject,justError: nil)
            }) { (task, error) -> () in
               action(dataTask: task!,results: nil,justError: error)
        }!
        return dataTask
    }
    class func POST(urlString : String,parameters : AnyObject,action : (resultTask : NSURLSessionDataTask,result : AnyObject?,justError : NSError?)->()) ->NSURLSessionDataTask {
        let dataTask : NSURLSessionDataTask = self.POST(urlString, parameters: parameters, success: { (task, responseObject) -> () in
                let error : NSError? = self.verifyResponseObject(responseObject!)
                if  error != nil{
                    print(error!.localizedDescription)
                }
            action(resultTask: task!,result: responseObject,justError: nil)
            }) { (task, error) -> () in
                action(resultTask: task!,result: nil,justError: error)
        }!
        return dataTask
    }
    
    class func assembleParametersWithKey(assemblyKey : String , parameters: Dictionary<String,AnyObject>) -> NSDictionary {
        let assemblyString = NSMutableString()
        
        var parts = [String]()
        
        for key in parameters.keys{
            var encodedValue = parameters[key]
            if encodedValue is NSDictionary{
                encodedValue = try? NSJSONSerialization.dataWithJSONObject(encodedValue!, options: .PrettyPrinted)
                 let tempString = String(data: encodedValue as! NSData, encoding: NSUTF8StringEncoding)?.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
                encodedValue = tempString?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0 ? tempString : encodedValue
            }
            else if encodedValue is String || encodedValue is NSNumber{
            }
            else if encodedValue is NSData{
                let tempString = String(data: encodedValue as! NSData, encoding: NSUTF8StringEncoding)?.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
                encodedValue = (tempString?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0) ?  tempString : encodedValue
            }
            else if encodedValue is NSArray{
                encodedValue = try? NSJSONSerialization.dataWithJSONObject(encodedValue!, options: .PrettyPrinted)
                let tempString = String(data: encodedValue as! NSData, encoding: NSUTF8StringEncoding)?.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
                encodedValue = (tempString?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0) ?  tempString : encodedValue
            }
            
            let encodedKey : String = key.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
            var part : String?
            if encodedValue is String{
                part = "\"\(encodedKey)\":\"\(encodedValue)\""
            }
            else{
                part = "\"\(encodedKey)\":\(encodedValue)"
            }
            parts.append(part!)
        }
        assemblyString.appendString("{")
        for var idx : NSInteger = 0 ; idx < parts.count;idx++ {
            assemblyString.appendString(parts[idx])
            if idx != parts.count - 1{
                assemblyString.appendString(",")
            }
        }
        assemblyString.appendString("}")
        let tempKey = assemblyKey.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
        
        return [tempKey : assemblyString]
    }
}
