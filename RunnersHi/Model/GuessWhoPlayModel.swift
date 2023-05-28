//
//  GuessWhoPlayModel.swift
//  AgareeGames
//
//  Created by 황원상 on 2023/05/21.
//
import Foundation
import UIKit

// 해야할것 1. 에러처리 2. 캐시 처리 마무리

struct GuessWhoPlayModel:Codable{
    let name:String
    let photo:UIImage
    // 되는지 안되는지 잘 몰겟음...
    // 여기까지 왔을땐, 무조건 이미지 파일이 존재해야함
    func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy:CodingKeys.self)
            try container.encode(name, forKey: .name)
        if let data = photo.pngData(){
            let base64 = data.base64EncodedString()
            try container.encode(base64, forKey: .photo)
        }else if let data = photo.jpegData(compressionQuality: 0.8){
            let base64 = data.base64EncodedString()
            try container.encode(base64, forKey: .photo)
        }
    }
    // ecode가 먼저된다. encode에서 문제가 생기면, encode를 안할거기 때문에 일단은 ! 처리
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        let base64 = try container.decodeIfPresent(String.self, forKey: .photo)!
        let data = Data(base64Encoded: base64, options: .ignoreUnknownCharacters)!
        self.photo = UIImage(data: data)!
    }
    
    init(name:String, photo:UIImage){
        self.name = name
        self.photo = photo
    }
    
    enum CodingKeys:String, CodingKey{
        case name
        case photo
    }
}




