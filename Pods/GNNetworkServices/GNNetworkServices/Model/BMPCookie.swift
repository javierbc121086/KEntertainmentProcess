//
//  BMPCookie.swift
//  GNNetworkServices
//
//  Created by Javier Bolaños on 14/11/18.
//  Copyright © 2018 GoNet. All rights reserved.
//

class BMPCookie: NSObject, NSCoding {
    
    //-----------All params, example: -------
    //var cookieProperties = [String: AnyObject]()
    //cookieProperties[NSHTTPCookieName] = "locale"
    //cookieProperties[NSHTTPCookieValue] = "nl_NL"
    //cookieProperties[NSHTTPCookieDomain] = "www.digitaallogboek.nl"
    //cookieProperties[NSHTTPCookiePath] = "/"
    //cookieProperties[NSHTTPCookieVersion] = NSNumber(integer: 0)
    //cookieProperties[NSHTTPCookieExpires] = NSDate().dateByAddingTimeInterval(31536000)
    //var newCookie = NSHTTPCookie(properties: cookieProperties)
    //println("\(newCookie)")
    
    var _name: String?
    var _value: String?
    var _path: String?
    var _domain: String?
    
    override init() {
        super.init()
        _name = String()
        _value = String()
        _path = String()
        _domain = String()
    }
    
    init(name: String, value: String, path: String, domain: String) {
        _name = name
        _value = value
        _path = path
        _domain = domain
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        let value = aDecoder.decodeObject(forKey: "value") as? String ?? ""
        let path = aDecoder.decodeObject(forKey: "path") as? String ?? ""
        let domain = aDecoder.decodeObject(forKey: "domain") as? String ?? ""
        self.init(name: name, value: value, path: path, domain: domain)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(_name, forKey: "name")
        aCoder.encode(_value, forKey: "value")
        aCoder.encode(_path, forKey: "path")
        aCoder.encode(_domain, forKey: "domain")
    }
    
    var Name: String {
        get {
            return _name ?? ""
        }
        set {
            _name = newValue
        }
    }
    
    var Value: String {
        get {
            return _value ?? ""
        }
        set {
            _value = newValue
        }
    }
    
    var Path: String {
        get {
            return _path ?? ""
        }
        set {
            _path = newValue
        }
    }
    
    var Domain: String {
        get {
            return _domain ?? ""
        }
        set {
            _domain = newValue
        }
    }
    
    override var description: String {
        return "BMPCookie ==> name: \(self.Name) <--> value: \(self.Value) <--> path: \(self.Path) <--> domain: \(self.Domain)"
    }
}
