//
//  GNTools.swift
//  GNSwissRazor
//
//  Created by Javier on 20/01/18.
//  Copyright © 2018 javier. All rights reserved.
//

@objc public class GNTools: NSObject {
    @objc public class func MakeError(message: Any) -> NSError {
        var errorDetail: [String : Any] = [:]
        
        errorDetail[NSLocalizedDescriptionKey] = message
        
        return NSError(domain: "mx.com.gipsyhall.GHWissRazor", code: 121086, userInfo: errorDetail)
    }
}

