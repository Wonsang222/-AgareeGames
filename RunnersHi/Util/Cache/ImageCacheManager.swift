//
//  ImageCacheManager.swift
//  AgareeGames
//
//  Created by 황원상 on 2023/05/27.
//

import UIKit
import CoreData

final class ImageCacheManager{
    static let shared = NSCache<NSString, UIImage>()
    private init(){}
}

// 이 둘의 차이!!


final class TempCache{
    static let shared = TempCache()
    var cache:[String:UIImage]  = [:]
    private init() {}
}


class DataManager{
    static let shared = DataManager()
    private init(){}
    
    var container:NSPersistentContainer?
    
    var mainContext:NSManagedObjectContext {
        guard let context = container?.viewContext else {
            fatalError("error")
        }
        return context
    }
     
    func setup(modelName:String){
        container = NSPersistentContainer(name: modelName)
        container?.loadPersistentStores(completionHandler: { desc, err in
            if let err = err {
                fatalError(err.localizedDescription)
            }
        })
    }
    
    func saveMainContext(){
        mainContext.perform {
            if self.mainContext.hasChanges{
                do{
                    try self.mainContext.save()
                } catch{
                    print(error)
                }
            }
        }
    }
    
    func createModel(name:String, photo:UIImage){
        mainContext.perform {[weak self] in
            guard let self = self else { return }
            let newModel = GuessWhoEntitiy(context: self.mainContext)
            newModel.name = name
            
//            newModel.photo = photo
            self.saveMainContext()
        }
    }
    
    func fetchModel(targetName:String) -> [GuessWhoEntitiy]{
        var result = [GuessWhoEntitiy]()
        
        mainContext.performAndWait {
            let request = GuessWhoEntitiy.fetchRequest()
            let sortByName = NSSortDescriptor(key: targetName, ascending: true)
            request.sortDescriptors = [sortByName]
            
            do{
                result = try mainContext.fetch(request)
            } catch{
                print(error)
            }
        }
        return result
    }
    
}
