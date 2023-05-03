//
//  Extension.swift
//  RunnersHi
//
//  Created by 위사모바일 on 2023/05/03.
//

import Foundation

extension String{
    func urlEncode() -> String{
        let escapedString = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        return escapedString
    }
}
