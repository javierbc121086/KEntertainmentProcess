//
//  BAVConfigService.swift
//  BAVService
//
//  Created by Javier on 20/01/18.
//  Copyright © 2018 GoNet. All rights reserved.
//

public class GNConfigService: NSObject {
    
    public class var TimeOutInterval: TimeInterval {
        return 30.0
    }
    
    public class var GETMethod: String {
        return "GET"
    }
    
    public class var POSTMethod: String {
        return "POST"
    }
    
    public class var PUTMethod: String {
        return "PUT"
    }
    
    public class var DELETEMethod: String {
        return "DELETE"
    }
    
    public class var PATCHMethod: String {
        return "PATCH"
    }
    
    public class var HeaderFields: [String: String] {
        get {
            return [
                "Accept": "application/json",
                "Content-Type": "application/json"
            ]
        }
    }
}
