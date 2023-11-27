//
//  Playable.swift
//  AgareeGames_dis
//
//  Created by 황원상 on 11/26/23.
//

import UIKit
import RxSwift

protocol Playable {
    var name:String { get }
    var photo:UIImage? { get set }
    func matchAnswer(submission:String) -> Observable<Bool>
    init(name:String, photo:UIImage?)
}
