//
//  HttpBase.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/14.
//

import Foundation

// builder로 구현.

protocol downloadParser{
    
}

struct HttpBaseResource {
    let reqMethod:String
    let shouldHandleCookie:Bool
    let isMultiPart:Bool
    let params:[String:String]
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
    
    func setParams(_ param:String...) ->Self{
        self.params[param[0]] = param[1]
        return self
    }

    func build() -> HttpBaseResource{
        return HttpBaseResource(reqMethod: reqMethod, shouldHandleCookie: shouldHandleCookie, isMultiPart: isMultiPart, params: params)
    }
}

