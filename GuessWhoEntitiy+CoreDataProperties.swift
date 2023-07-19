//
//  GuessWhoEntitiy+CoreDataProperties.swift
//  AgareeGames
//
//  Created by 황원상 on 2023/07/19.
//
//

import Foundation
import CoreData


extension GuessWhoEntitiy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GuessWhoEntitiy> {
        return NSFetchRequest<GuessWhoEntitiy>(entityName: "GuessWho")
    }

    @NSManaged public var name: String?
    @NSManaged public var photo: Data?

}

extension GuessWhoEntitiy : Identifiable {

}
