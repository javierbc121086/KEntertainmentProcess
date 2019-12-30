//
//  BAVDependencySeriveConfig.swift
//  BAVService
//
//  Created by Javier on 20/01/18.
//  Copyright © 2018 GoNet. All rights reserved.
//

import UIKit
import Reachability

public class GNDependencySeriveConfig: NSObject {
    
    class var GetNameProject: String {
        return (Bundle.main.infoDictionary?["CFBundleExecutable"] as? String) ?? ""
    }
    
    public class var StrBundlePodNetworkServices: String {
        return "org.cocoapods.GNNetworkServices"
    }
    
    public class var GetIdentifierRestServer: GNRequestServerType {
        var sourceIdentifier: GNRequestServerType = .PRODUCTION
        
        if let dic = self.objectFromConfigDictionaryKey(pr: "IdentifierRestServer") as? NSDictionary {
            for item:(key: Any, value: Any) in dic {
                if let id = item.key as? String, let valueDic = item.value as? NSDictionary {
                    if let enabled = valueDic.object(forKey: "enabled") as? Bool, enabled {
                        if let identifier = GNRequestServerType(rawValue: id) {
                            sourceIdentifier = identifier
                        }
                        break
                    }
                }
            }
        }
        
        return sourceIdentifier
    }

    public class var GetIdentifierBundleJsonMock: String {
        return self.objectFromConfigDictionaryKey(pr: "BundleIdentifierJsonMock") as? String ?? String.Empty
    }
    
    public class func objectFromConfigDictionaryKey(pr: String) -> Any? {
        var anyObj: Any?
        
        if let path = Bundle(identifier: StrBundlePodNetworkServices)?.path(forResource: "GNConfig-Info", ofType: "plist") {
            if let dict = NSDictionary(contentsOfFile: path) {
                anyObj = dict.object(forKey: pr)
            }
        }
        
        return anyObj
    }
    
    public class func getStatusNetwork() -> Bool {
        var connection = false
        
        if let networkReachability = Reachability() {
            switch networkReachability.connection {
            case .none:
                break
            case .wifi, .cellular:
                connection = true
                break
            }
        }
        
        return connection
    }
    
    public class func getStringForDictionary(dictionary: [String: String], join: String) -> String {
        var resultString = String.Empty
        
        var first = true
        let joinFirst = "?"
        
        for (key, value) in dictionary {
            resultString = resultString.appendingFormat("\(first ? joinFirst : join)%@=%@", key, value)
            
            if first {
                first = false
            }
        }
        
        return resultString
    }
    
    public class func stringToSendService(str: String) -> String {
        var returnValue = String.Empty
        
        for char in str {
            if char == " " {
                returnValue = returnValue + "%20"
            }
            else {
                returnValue = returnValue + String(char)
            }
        }
        
        return returnValue
    }
}
