//
//  ImageCacheManager.swift
//  AgareeGames
//
//  Created by 황원상 on 2023/05/27.
//

import UIKit

final class ImageCacheManager{
    static let shared = NSCache<NSString, UIImage>()
    private init(){}
}


final class TempCache{
    static let shared = TempCache()
    var cache:[String:UIImage]  = [:]
    private init() {}
}
