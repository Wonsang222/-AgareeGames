//
//  HttpBase.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/14.
//

import Foundation

// builder로 구현.
// protocol oriented 시도

struct HttpBaseResource {
    private let reqUrl = Global.URL
    private let reqMethod:HttpMethod
    private let isMultiPart:Bool
    private var reqHeader = [String:String]()
    private var params = [String:String]()
    private var path:String
    
    func request()->URLRequest{
        var resultReq:URLRequest
        
        let urlString = reqUrl + "/\(path)"
        
        if reqMethod == .GET {
            resultReq = URLRequest(url: URL(string: urlString + "?" + generateParam())!)
        } else {
            resultReq = URLRequest(url: URL(string: urlString)!)
        }
        
        resultReq.allowsCellularAccess = true
        resultReq.httpMethod = reqMethod.rawValue
        
        for (key, value) in reqHeader{
            resultReq.addValue(value, forHTTPHeaderField: key)
        }
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
    
    init(reqMethod: HttpMethod, isMultiPart: Bool, reqHeader: [String : String], params: [String : String], path: String) {
        self.reqMethod = reqMethod
        self.isMultiPart = isMultiPart
        self.reqHeader = reqHeader
        self.params = params
        self.path = path
    }
}

