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
    private let reqMethod:HttpMethod
    private let shouldHandleCookie:Bool
    private let isMultiPart:Bool
    private var reqHeader:[String:String]?
    private var params = [String:String]()
    
    func request()->URLRequest{
        var resultReq:URLRequest
        
        if reqMethod == .GET {
            resultReq = URLRequest(url: URL(string: reqUrl + "?" + generateParam())!)
        } else {
            resultReq = URLRequest(url: URL(string: reqUrl)!)
        }
        
        resultReq.httpMethod = reqMethod.rawValue
        
        if let reqHeader = reqHeader{
            for (key, value) in reqHeader{
                resultReq.addValue(value, forHTTPHeaderField: key)
            }
        }
        // 일단은 get만...
        //        resultReq.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        resultReq.httpBody = generateParam().data(using: String.Encoding.utf8)
        
        return resultReq
    }
    
    private func generateParam()->String{
        var returnVal = ""
        for (key, value) in self.params{
            if returnVal != ""{
                returnVal += "&"
            }
            returnVal += key + "=" + value.urlEncode()
        }
        return returnVal
    }
    
    init(reqMethod: HttpMethod, shouldHandleCookie: Bool, isMultiPart: Bool, params: [String : String]) {
        self.reqMethod = reqMethod
        self.shouldHandleCookie = shouldHandleCookie
        self.isMultiPart = isMultiPart
        self.params = params
    }
}

