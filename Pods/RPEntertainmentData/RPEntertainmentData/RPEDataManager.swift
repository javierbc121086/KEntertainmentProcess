//
//  RPEDataManager.swift
//  KEntertainmentData
//
//  Created by Javier Bolaños on 12/30/19.
//  Copyright © 2019 Javier Bolaños. All rights reserved.
//

import Foundation
import CoreData

class RPEDataManager {
    private let identifier      = "org.cocoapods.RPEntertainmentData"
    private let coreDataModel   = "RPECoreDataModel"
    
    private let _concurrentQueue = DispatchQueue(label: "concurrentQueue", attributes: .concurrent)
    private static var _shared: RPEDataManager?
    
    class var Shared: RPEDataManager {
        if _shared == nil {
            _shared = RPEDataManager()
        }
        
        return _shared!
    }
    
    class func disposeStance() {
        _shared = nil
    }
    
    private init() { }
    
    @available(iOS 10.0, *)
    lazy var persistentContainer: NSPersistentContainer? = {
        _concurrentQueue.sync {
            let messageKitBundle = Bundle(identifier: self.identifier)
            if let modelURL = messageKitBundle?.url(forResource: self.coreDataModel, withExtension: "momd") {
                if let managedObjectModel =  NSManagedObjectModel(contentsOf: modelURL) {
                    let container = NSPersistentContainer(name: self.coreDataModel, managedObjectModel: managedObjectModel)
                    
                    container.loadPersistentStores { (storeDescription, error) in
                        if let err = error {
                            fatalError("Loading of store failed:\(err)")
                        }
                    }
                    
                    return container
                }
            }
            
            return nil
        }
    }()
}
