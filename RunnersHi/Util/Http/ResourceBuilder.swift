//
//  ResourceBuilder.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/05/05.
//

import Foundation

enum HttpMethod:String{
    case GET
    case POST
}

final class ResourceBuilder{
    private var reqMethod:HttpMethod = .GET
    private var isMultiPart = false
    private var reqHeader = [String:String]()
    private var params:[String:String] = [String:String]()
    private var path:String = ""
    
    func setReqMethod(_ method:HttpMethod) -> Self {
        self.reqMethod = method
        return self
    }
    
    func setMultiPart(_ bool:Bool) -> Self{
        self.isMultiPart = bool
        return self
    }
    
    func setParams(_ param1:String, _ param2:Any) -> Self {
        switch param2{
        case let num as Int:
            self.params[param1] = String(num)
        case let str as String:
            self.params[param1] = str
        default:
            break
        }
        return self
    }
    
    func setPath(_ path:String) -> Self{
        self.path = path
        return self
    }
    
    func setReqHeader(_ header1:String, _ header2:String) -> Self {
        self.reqHeader[header1] = header2
        return self
    }

    func build() -> HttpBaseResource{
        return HttpBaseResource(reqMethod: reqMethod, isMultiPart: isMultiPart, reqHeader: reqHeader, params: params, path: path)
    }
        
    static let shared = ResourceBuilder()
    
    private init(){}
}


