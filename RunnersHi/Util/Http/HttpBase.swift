//
//  HttpBase.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/14.
//

import Foundation

struct HttpBaseResource {
    
    private let reqUrl = Global.URL
    private let reqMethod:HttpMethod
    private let isMultiPart:Bool
    private var reqHeader = [String:String]()
    private var params = [String:String]()
    private var path:String
    
    func getRequest()->URLRequest{
        var resultReq:URLRequest
        
        let urlString = reqUrl + "/\(path)"
        
        if reqMethod == .GET {
            resultReq = URLRequest(url: URL(string: urlString + "?" + generateParam())!)
        } else {
            resultReq = URLRequest(url: URL(string: urlString)!)
        }
        
        resultReq.allowsCellularAccess = true
        resultReq.httpMethod = reqMethod.rawValue
        
        for (key, value) in reqHeader {
            resultReq.addValue(value, forHTTPHeaderField: key)
        }
        return resultReq
    }
    
    //urlcomponent쓰면된다.....
    private func generateParam()->String {
        var returnVal = ""
        for (key, value) in self.params{
            if returnVal != ""{
                returnVal += "&"
            }
            returnVal += key + "=" + value.urlEncode()
        }
        return returnVal
    }
  
    // 로그인 위함 -> protocol에 담기
//    func parseHeader(_ resp:HTTPURLResponse){
//        let cookies = HTTPCookie.cookies(withResponseHeaderFields: resp.allHeaderFields as! [String:String], for: resp.url!)
//        for cookie in cookies{
//
//        }
//    }
    
    init(reqMethod: HttpMethod, isMultiPart: Bool, reqHeader: [String : String], params: [String : String], path: String) {
        self.reqMethod = reqMethod
        self.isMultiPart = isMultiPart
        self.reqHeader = reqHeader
        self.params = params
        self.path = path
    }
}

