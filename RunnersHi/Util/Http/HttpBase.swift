//
//  HttpBase.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/14.
//

import Foundation

// builder로 구현.

struct HttpBaseResource {
    private let reqUrl = ""
    private let reqMethod:String
    private let shouldHandleCookie:Bool
    private let isMultiPart:Bool
    private var reqHeader:[String:String]?
    private var params = [String:String]()
    
    init(reqMethod: String, shouldHandleCookie: Bool, isMultiPart: Bool, params: [String : String]) {
        self.reqMethod = reqMethod
        self.shouldHandleCookie = shouldHandleCookie
        self.isMultiPart = isMultiPart
        self.params = params
    }
    
    func generateParam()->String{
        var returnVal = ""
        for (key, value) in self.params{
            if returnVal != ""{
                returnVal += "&"
            }
            returnVal += key + "=" + value.urlEncode()
        }
        return returnVal
    }
    // 완성해야함
    func makeReq() -> URLRequest{
        
        var resultReq:URLRequest
        
        if self.reqMethod == "GET" {
            resultReq = URLRequest(url: URL(string: self.reqUrl + "?" + self.generateParam())!)
        } else {
            resultReq = URLRequest(url: URL(string: self.reqUrl)!)
        }
        
        resultReq.httpMethod = self.reqMethod
        
        if let reqHeader = self.reqHeader{
            for (key, value) in reqHeader{
                resultReq.addValue(value, forHTTPHeaderField: key)
            }
        }
        // 일단은 get만...
        resultReq.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        resultReq.httpBody = self.generateParam().data(using: String.Encoding.utf8)
            
        return resultReq
    }
}

class ResourceBuilder{
    private var reqMethod:String = "GET"
    private var shouldHandleCookie = true
    private var isMultiPart = false
    private var params:[String:String] = [String:String]()
    
    func setReqMethod(_ method:String) -> Self{
        self.reqMethod = method
        return self
    }
    // Oauth도 쿠키로 하나?????
    func setCookie(_ bool:Bool)->Self{
        self.shouldHandleCookie = bool
        return self
    }
    
    func setMultiPart(_ bool:Bool)->Self{
        self.isMultiPart = bool
        return self
    }
    
    func setParams(_ param1:String, _ param2:String) ->Self{
        self.params[param1] = param2
        return self
    }

    func build() -> HttpBaseResource{
        return HttpBaseResource(reqMethod: reqMethod, shouldHandleCookie: shouldHandleCookie, isMultiPart: isMultiPart, params: params)
    }
    
    static let shared = ResourceBuilder()
    
    private init(){}
}


