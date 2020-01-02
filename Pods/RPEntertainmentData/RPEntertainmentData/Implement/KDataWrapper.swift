//
//  KDataWrapper.swift
//  RPEntertainmentData
//
//  Created by Javier Bolaños on 1/2/20.
//  Copyright © 2020 gipsyhub. All rights reserved.
//

public class KDataWrapper {

    private let fileManager = FileManager.default
    
    public static let shared = KDataWrapper()
    
    private init() { }
    
    public func saveImage(image: UIImage) -> String? {
        let date = String( Date.timeIntervalSinceReferenceDate )
        let imageName = date.replacingOccurrences(of: ".", with: "-") + ".png"
        
        if let imageData = image.pngData() {
            do {
                guard let documentsPath = FileManager.default.urls(for: .documentDirectory,
                                                                   in: .userDomainMask).first else {
                    return nil
                }
                
                let filePath = documentsPath.appendingPathComponent(imageName)
                try imageData.write(to: filePath)
                
                print("\(imageName) was saved.")
                return imageName
            }
            catch let error as NSError {
                print("\(imageName) could not be saved: \(error)")
                return nil
            }
            
        }
        else {
            print("Could not convert UIImage to png data.")
            return nil
        }
    }
    
    public func fetchImage(imageName: String) -> UIImage? {
        guard let documentsPath = FileManager.default.urls(for: .documentDirectory,
                                                           in: .userDomainMask).first else {
            return nil
        }
        
        let imagePath = documentsPath.appendingPathComponent(imageName).path
        
        guard self.fileManager.fileExists(atPath: imagePath) else {
            print("Image does not exist at path: \(imagePath)")
            return nil
        }
        
        if let imageData = UIImage(contentsOfFile: imagePath) {
            return imageData
        }
        else {
            print("UIImage could not be created.")
            return nil
        }
    }
    
    public func deleteImage(imageName: String) {
        guard let documentsPath = FileManager.default.urls(for: .documentDirectory,
                                                           in: .userDomainMask).first else {
            return
        }
        
        let imagePath = documentsPath.appendingPathComponent(imageName)
        
        guard self.fileManager.fileExists(atPath: imagePath.path) else {
            print("Image does not exist at path: \(imagePath)")
            return
        }
        
        do {
            try self.fileManager.removeItem(at: imagePath)
            print("\(imageName) was deleted.")
        }
        catch let error as NSError {
            print("Could not delete \(imageName): \(error)")
        }
    }
}
