//
//  RPEMovieWrapper.swift
//  KEntertainmentData
//
//  Created by Javier Bolaños on 12/30/19.
//  Copyright © 2019 Javier Bolaños. All rights reserved.
//

import KEntertainmentDomain
import CoreData

public class RPEMovieWrapper: IRPEDataManagerDelegate {
    public typealias T = KMovieModel
    
    private var entityCoraDataName: String {
        return "RPECDMovieEntity"
    }
    
    public init() { }
    
    public func get(id: Int) -> KMovieModel? {
        if let context = RPEDataManager.Shared.persistentContainer?.viewContext {
            let fetchRequest = NSFetchRequest<RPECDMovieEntity>(entityName: self.entityCoraDataName)
            fetchRequest.predicate = NSPredicate(format: "id = %d", id)
            
            do {
                if let coreDataMovieEntity = try context.fetch(fetchRequest).first {
                    let model = KMovieModel(
                        id: Int(coreDataMovieEntity.id),
                        popularity: coreDataMovieEntity.popularity,
                        voteCount:  Int(coreDataMovieEntity.voteCount),
                        video:  coreDataMovieEntity.video,
                        adult:  coreDataMovieEntity.adult,
                        originalLanguage:  coreDataMovieEntity.originalLanguage ?? "",
                        originalTitle:  coreDataMovieEntity.originalTitle ?? "",
                        genreIds: (coreDataMovieEntity.genreIds as? NSSet)?.allObjects as? [Int] ?? [],
                        title: coreDataMovieEntity.title ?? "",
                        voteAverage:  coreDataMovieEntity.voteAverage,
                        overview:  coreDataMovieEntity.overview ?? "",
                        releaseDate:  coreDataMovieEntity.releaseDate ?? "",
                        backdropPath:  coreDataMovieEntity.backdropPath ?? "",
                        posterPath:  coreDataMovieEntity.posterPath ?? "",
                        requestType: Int(coreDataMovieEntity.requestType)
                    )
                    
                    return model
                }
            }
            catch let fetchErr {
                print("Failed to update \(entityCoraDataName): \n \(fetchErr.localizedDescription)")
            }
        }
        
        return nil
    }

    public func getAll() -> [KMovieModel]? {
        var list = [KMovieModel]()

        if let context = RPEDataManager.Shared.persistentContainer?.viewContext {
            let fetchRequest = NSFetchRequest<RPECDMovieEntity>(entityName: self.entityCoraDataName)
            
            do {
                let movieCoreDataEntity = try context.fetch(fetchRequest)
                
                for movieEntity in movieCoreDataEntity {
                    let model = KMovieModel(
                        id: Int(movieEntity.id),
                        popularity: movieEntity.popularity,
                        voteCount:  Int(movieEntity.voteCount),
                        video:  movieEntity.video,
                        adult:  movieEntity.adult,
                        originalLanguage:  movieEntity.originalLanguage ?? "",
                        originalTitle:  movieEntity.originalTitle ?? "",
                        genreIds: (movieEntity.genreIds as? NSSet)?.allObjects as? [Int] ?? [],
                        title: movieEntity.title ?? "",
                        voteAverage:  movieEntity.voteAverage,
                        overview:  movieEntity.overview ?? "",
                        releaseDate:  movieEntity.releaseDate ?? "",
                        backdropPath:  movieEntity.backdropPath ?? "",
                        posterPath:  movieEntity.posterPath ?? "",
                        requestType: Int(movieEntity.requestType)
                    )
                    
                    list.append(model)
                }
            }
            catch let fetchErr {
                print("Failed to fetch \(entityCoraDataName): \n \(fetchErr.localizedDescription)")
            }
        }

        return list
    }
    
    public func save(model: KMovieModel) {
        let isModified = self.update(model: model)
        
        if !isModified {
            if let context = RPEDataManager.Shared.persistentContainer?.viewContext {
                if let movieCoreDataEntity = NSEntityDescription.insertNewObject(
                    forEntityName: self.entityCoraDataName,
                    into: context
                    ) as? RPECDMovieEntity {
                    
                    movieCoreDataEntity.id                  = Int32(model.id)
                    movieCoreDataEntity.popularity          = model.popularity
                    movieCoreDataEntity.voteCount           = Int32(model.voteCount)
                    movieCoreDataEntity.video               = model.video
                    movieCoreDataEntity.adult               = model.adult
                    movieCoreDataEntity.originalLanguage    = model.originalLanguage
                    movieCoreDataEntity.originalTitle       = model.originalTitle
                    movieCoreDataEntity.title               = model.title
                    movieCoreDataEntity.voteAverage         = model.voteAverage
                    movieCoreDataEntity.overview            = model.overview
                    movieCoreDataEntity.releaseDate         = model.releaseDate
                    movieCoreDataEntity.backdropPath        = model.backdropPath
                    movieCoreDataEntity.posterPath          = model.posterPath
                    movieCoreDataEntity.genreIds            = NSSet(array: model.genreIds)
                    movieCoreDataEntity.requestType         = Int32(model.requestType)
                    
                    do {
                        try context.save()
                        print("\(entityCoraDataName) saved successfully")
                    }
                    catch let error {
                        print("Failed to create \(entityCoraDataName): \n \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    public func saveAll(list: [KMovieModel]) {
        list.forEach { (model) in
            self.save(model: model)
        }
    }
    
    public func update(model: KMovieModel) -> Bool {
        var isModifiedModel = false
        
        if let context = RPEDataManager.Shared.persistentContainer?.viewContext {
            let fetchRequest = NSFetchRequest<RPECDMovieEntity>(entityName: self.entityCoraDataName)
            fetchRequest.predicate = NSPredicate(format: "id = %d", model.id)
            
            do {
                if let movieCoreDataEntity = try context.fetch(fetchRequest).first {
                    movieCoreDataEntity.setValue(Int32(model.id), forKey: "id")
                    movieCoreDataEntity.setValue(model.popularity, forKey: "popularity")
                    movieCoreDataEntity.setValue(Int32(model.voteCount), forKey: "voteCount")
                    movieCoreDataEntity.setValue(model.video, forKey: "video")
                    movieCoreDataEntity.setValue(model.adult, forKey: "adult")
                    movieCoreDataEntity.setValue(model.originalLanguage, forKey: "originalLanguage")
                    movieCoreDataEntity.setValue(model.originalTitle, forKey: "originalTitle")
                    movieCoreDataEntity.setValue(model.title, forKey: "title")
                    movieCoreDataEntity.setValue(model.voteAverage, forKey: "voteAverage")
                    movieCoreDataEntity.setValue(model.overview, forKey: "overview")
                    movieCoreDataEntity.setValue(model.releaseDate, forKey: "releaseDate")
                    movieCoreDataEntity.setValue(model.backdropPath, forKey: "backdropPath")
                    movieCoreDataEntity.setValue(model.posterPath, forKey: "posterPath")
                    movieCoreDataEntity.setValue(NSSet(array: model.genreIds), forKey: "genreIds")
                    movieCoreDataEntity.setValue(model.requestType, forKey: "requestType")
                    
                    try context.save()
                    
                    print("\(entityCoraDataName) update successfully")
                    isModifiedModel = true
                }
            }
            catch let fetchErr {
                print("Failed to update \(entityCoraDataName): \n \(fetchErr.localizedDescription)")
            }
        }
        
        return isModifiedModel
    }
    
    public func delete(id: Int) {
        if let context = RPEDataManager.Shared.persistentContainer?.viewContext {
            let fetchRequest = NSFetchRequest<RPECDMovieEntity>(entityName: self.entityCoraDataName)
            fetchRequest.predicate = NSPredicate(format: "id = %d", id)
            
            do {
                if let movieCoreDataEntity = try context.fetch(fetchRequest).first {
                    context.delete(movieCoreDataEntity)
                    try context.save()
                }
            }
            catch let fetchErr {
                print("Failed to update \(entityCoraDataName): \n \(fetchErr.localizedDescription)")
            }
        }
    }
    
    public func deleteAll() {
        if let context = RPEDataManager.Shared.persistentContainer?.viewContext {
            let fetchRequest = NSFetchRequest<RPECDMovieEntity>(entityName: self.entityCoraDataName)
            
            do {
                let movieCoreDataEntity = try context.fetch(fetchRequest)
                
                movieCoreDataEntity.forEach { (entity) in
                    context.delete(entity)
                }
                
                try context.save()
            }
            catch let fetchErr {
                print("Failed to fetch \(entityCoraDataName): \n \(fetchErr.localizedDescription)")
            }
        }
    }
}
