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
        return HttpBaseResource(reqMethod: .GET, shouldHandleCookie: shouldHandleCookie, isMultiPart: isMultiPart, params: params)
    }
    
    static let shared = ResourceBuilder()
    
    private init(){}
}


