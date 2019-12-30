//
//  BAVRequestServerTypeExtension.swift
//  BAVService
//
//  Created by Javier on 20/01/18.
//  Copyright © 2018 GoNet. All rights reserved.
//

extension GNRequestServerType {
    
    public func getUrl() -> String {
        var url = String.Empty
        
        if let dic = GNDependencySeriveConfig.objectFromConfigDictionaryKey(pr: "IdentifierRestServer") as? NSDictionary {
            for item:(key: Any, value: Any) in dic {
                if let id = item.key as? String, let valueDic = item.value as? NSDictionary {
                    if id == self.rawValue {
                        if let urlDic = valueDic.object(forKey: "url") as? String, urlDic.isNotEmpty {
                            url = urlDic
                            break
                        }
                    }
                }
            }
        }
        
        return url
    }
}
