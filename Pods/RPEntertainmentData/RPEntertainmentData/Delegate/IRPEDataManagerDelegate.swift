//
//  IRPEDataManagerDelegate.swift
//  KEntertainmentData
//
//  Created by Javier Bolaños on 12/30/19.
//  Copyright © 2019 Javier Bolaños. All rights reserved.
//

public protocol IRPEDataManagerDelegate {
    associatedtype T
    
    func get(id: Int) -> T?
    func getAll() -> [T]?
    func save(model: T)
    func saveAll(list: [T])
    func update(model: T) -> Bool
    func delete(id: Int)
    func deleteAll()
}
