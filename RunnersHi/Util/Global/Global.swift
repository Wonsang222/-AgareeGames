//
//  Global.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/26.
//

import Foundation

enum STTError:Error{
    case wrongLanguage
    case idkTheReason
}

enum HttpMethod:String{
    case GET
    case POST
}


struct Queue<T>{
    var queue:[T?] = []
    var head = 0
    
    var isEmpty:Bool {
        return queue.isEmpty
    }
    
    mutating func enqueue(value:T){
        queue.append(value)
    }
    
    @discardableResult
    mutating func dequeue() -> T?{
        guard head <= queue.count, let element = queue[head] else { return nil }
        queue[head] = nil
        head += 1
        return element
    }
    
}
