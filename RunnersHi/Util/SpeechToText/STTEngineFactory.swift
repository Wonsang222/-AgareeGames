//
//  STTEngineFactory.swift
//  RunnersHi
//
//  Created by 황원상 on 2023/04/30.
//

import Foundation

class STTEngineFactory{
    static func create(_ controller:BaseController)-> STTEngine{
        return STTEngine(controller: controller)
    }
}
