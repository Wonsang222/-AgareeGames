//
//  Protocol.swift
//  AgareeGames
//
//  Created by 위사모바일 on 2023/05/23.
//

import Foundation

protocol BaseDelegate{
    func handleError(_ error:Error)
}

extension BaseDelegate{
    func handleError(_ error:Error){
        // handleError 고려..
    }
}
