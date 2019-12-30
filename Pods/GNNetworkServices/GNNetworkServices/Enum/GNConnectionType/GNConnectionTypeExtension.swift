//
//  BAVConnectionTypeExtension.swift
//  BAVService
//
//  Created by Javier on 20/01/18.
//  Copyright © 2018 GoNet. All rights reserved.
//

extension GNConnectionType {
    
    func getMagicCoreClass() -> String {
        var nameClass = ""
        
        switch self {
        case .NSURLSessionService:
            nameClass = "GNURLSessionService"
            break
        }
        
        return nameClass
    }
}
