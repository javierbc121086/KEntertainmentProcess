//
//  GNBaseServiceExtension.swift
//  GNNetworkServices
//
//  Created by Javier Bolaños on 22/08/18.
//  Copyright © 2018 GoNet. All rights reserved.
//

extension GNBaseService {
    /***********************************************************
     ********* Helper Dummy Data
     ***********************************************************/
    
    public func dictionaryWithContentsOfJSONString(fileLocation: String, bundleIdentifier: String) {
        var jsonOptional: NSDictionary?
     
        let filePath = Bundle(identifier: bundleIdentifier)?.path(forResource: fileLocation, ofType: "json")
        if let file = filePath {
            do {
                if let data = NSData(contentsOfFile: file) {
                    jsonOptional = try JSONSerialization.jsonObject(with: data as Data,
                                                                    options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                }
            }
            catch let error {
                print("ERROR BaseService - dictionaryWithContentsOfJSONString -: \(error.localizedDescription)")
            }
        }
        
        self.parseJson(uniqueIdentifierFlow: 0, rawDic: jsonOptional ?? NSDictionary())
    }
    
    public func dictionaryWithContentsOfJSONStringObject(fileLocation: NSString) -> Any? {
        var jsonOptional: Any?
        let filePath = Bundle(identifier: "org.cocoapods.GNNetworkServices")?.path(forResource: fileLocation.deletingPathExtension,
                                                                                   ofType: fileLocation.pathExtension)
        //let filePath: String? = Bundle.main.path(forResource: fileLocation.deletingPathExtension, ofType: fileLocation.pathExtension)
        
        if let file = filePath {
            do {
                if let data = NSData(contentsOfFile: file) {
                    jsonOptional = try JSONSerialization.jsonObject(with: data as Data,
                                                                    options: JSONSerialization.ReadingOptions.mutableContainers)
                }
            }
            catch let error {
                print("ERROR BaseService - dictionaryWithContentsOfJSONStringObject -: \(error.localizedDescription)")
            }
        }
        else {
            print("%%%%%% ESTA VACIOOOOOOOOOOO")
        }
        
        return jsonOptional
    }
}
