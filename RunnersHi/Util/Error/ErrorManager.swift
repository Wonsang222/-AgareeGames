//
//  ErrorManager.swift
//  AgareeGames_dis
//
//  Created by 황원상 on 2023/06/24.
//

import Foundation

class ErrorManager{
    static let shared = ErrorManager()
    var errors:[Error]?
    private init(){}
}
