//
//  BAVBaseService.swift
//  BAVService
//
//  Created by Javier on 20/01/18.
//  Copyright © 2018 GoNet. All rights reserved.
//

open class GNBaseService: NSObject, GNConnectionServiceDelegate {
    
    private var gnConnectionService: GNMagicCoreServiceDelegate?
    @objc public var delegate: GNBaseServiceDelegate?
    
    lazy var dcRequestReference: [String: Int]? = [:]
    public var esError: Bool = false
    
    @objc public init(identifierService: Int) {
        super.init()
        
        if let gnConnectionType = GNConnectionType(rawValue: identifierService) {
            let strClass = String(format: "%@.%@", arguments: ["GNNetworkServices", gnConnectionType.getMagicCoreClass()])
            
            if let classCoreService = NSClassFromString(strClass) as? GNMagicCoreServiceDelegate.Type {
                self.gnConnectionService = classCoreService.init()
            }
        }
        
        self.gnConnectionService = self.gnConnectionService == nil ? GNURLSessionService() : self.gnConnectionService
        self.gnConnectionService?.delegate = self
    }
    
    public func httpPostRest(url: String, bodyData: Any, extraHeaders: [String:String]? = nil,
                             gnRequestType: Int, jsonFile: String = String.Empty) {
        self.esError = false
        
        self.commonHttpRest(url: url,
                            gnRequestType: gnRequestType,
                            restMethod: GNConfigService.POSTMethod,
                            extraHeaders: extraHeaders,
                            bodyData: bodyData,
                            jsonFile: jsonFile)
    }
    
    public func httpPatch(url: String, bodyData: Any, extraHeaders: [String: String]? = nil,
                          gnRequestType: Int, jsonFile: String = String.Empty) {
        self.esError = false
        
        self.commonHttpRest(url: url,
                            gnRequestType: gnRequestType,
                            restMethod: GNConfigService.PATCHMethod,
                            extraHeaders: extraHeaders,
                            bodyData: bodyData,
                            jsonFile: jsonFile)
    }
    
    public func httpGetRest(url: String, extraHeaders: [String:String]? = nil,
                            gnRequestType: Int, jsonFile: String = String.Empty) {
        self.esError = false
        
        self.commonHttpRest(url: url,
                            gnRequestType: gnRequestType,
                            restMethod: GNConfigService.GETMethod,
                            extraHeaders: extraHeaders,
                            bodyData: nil,
                            jsonFile: jsonFile)
    }
    
    private func commonHttpRest(url: String, gnRequestType: Int, restMethod: String,
                                extraHeaders: [String: String]?, bodyData: Any?, jsonFile: String) {
        if GNDependencySeriveConfig.GetIdentifierRestServer == .SIMULATION {
            self.dictionaryWithContentsOfJSONString(fileLocation: jsonFile,
                    bundleIdentifier: GNDependencySeriveConfig.GetIdentifierBundleJsonMock)
        }
        else if GNDependencySeriveConfig.getStatusNetwork() {
            if let nsurl = URL(string: url) {
                var request = URLRequest(url: nsurl)
                
                if restMethod == GNConfigService.POSTMethod ||
                        restMethod == GNConfigService.PATCHMethod {
                    do {
                        request.httpBody = try JSONSerialization.data(withJSONObject: bodyData ?? [], options: [])
                    }
                    catch _ {
                        request.httpBody = nil
                    }
                }
                
                request.httpMethod          = restMethod
                request.timeoutInterval     = GNConfigService.TimeOutInterval
                request.allHTTPHeaderFields = GNConfigService.HeaderFields
                
                if let headers = extraHeaders, headers.count > 0 {
                    for (key, value) in headers {
                        request.addValue(value, forHTTPHeaderField: key)
                    }
                }
                
                if let data = UserDefaults.standard.object(forKey: "BH_Cookies") as? Data,
                    let cookies = NSKeyedUnarchiver.unarchiveObject(with: data) as? [BMPCookie],
                    cookies.isEmpty {
                    
                    cookies.forEach { (bmpCookie) in
                        if let newCookie = HTTPCookie(properties: [.name: bmpCookie.Name,
                                                                   .value: bmpCookie.Value,
                                                                   .path: bmpCookie.Path,
                                                                   .domain: bmpCookie.Domain]) {
                            
                            HTTPCookieStorage.shared.setCookie(newCookie)
                        }
                    }
                }
                
                if let uniqueIdentifier = gnConnectionService?.submitRequest(request: request) {
                    self.dcRequestReference?[uniqueIdentifier] = gnRequestType
                }
            }
            else {
                self.requestFailWithError(uniqueIdentifier: String.Empty,
                                          didFailWithError: GNTools.MakeError(message:
                                            "URL Inválida, verifica que la url proporcionada tenga el formato completo"))
            }
        }
        else {
            self.requestFailWithError(uniqueIdentifier: String.Empty, didFailWithError:
                GNTools.MakeError(message: "No se detectó una conexión a internet válida"))
        }
    }
    
    public func receiveResponse(uniqueIdentifier: String, didReceiveResponse response: URLResponse) {
        if let httpResponse = response as? HTTPURLResponse {
            debugPrint("BaseService Status: \(httpResponse.statusCode)")
            
            if let arrCokies = HTTPCookieStorage.shared.cookies {
                var cookies: [BMPCookie] = []
                for cookie in arrCokies {
                    let bmpcookie = BMPCookie(name: cookie.name, value: cookie.value,
                                              path: cookie.path, domain: cookie.domain)
                    debugPrint("BaseService Cookie: \(bmpcookie.description)")
                    cookies.append(bmpcookie)
                }
                
                let saveData = NSKeyedArchiver.archivedData(withRootObject: cookies)
                UserDefaults.standard.set(saveData, forKey: "BH_Cookies")
            }
            
            debugPrint("BaseService HttpResponse: \(httpResponse)")
            
            switch httpResponse.statusCode {
            case 200...299:
                self.esError = false
                break
            case 300...399,
                 400...499:
                self.requestFailWithError(uniqueIdentifier: String.Empty,
                        didFailWithError: GNTools.MakeError(message:
                        "Error de comunicaciones, favor de reintentar mas tarde"))
                self.esError = true
                break
            case 500...599:
                self.requestFailWithError(uniqueIdentifier: String.Empty,
                                          didFailWithError: GNTools.MakeError(message:
                                            "Servicio no disponible, favor de reintentar mas tarde"))
                self.esError = true
                break
            default:
                debugPrint("Error: Cuidado, entro en default statusCode: \(httpResponse.statusCode)")
                break
            }
        }
        else {
            debugPrint("GNBaseService Error: No llego nada del response: \(response)")
        }
    }
    
    public func receiveData(uniqueIdentifier: String, receiveRawDictionary data: NSDictionary) {
        debugPrint("BaseService: \(data)")

        if data.count > 0 {
            if self.esError {
                self.esError = false
                self.requestFailWithError(uniqueIdentifier: String.Empty,
                        didFailWithError: GNTools.MakeError(message: data))
            }
            else {
                if let flow = self.dcRequestReference?[uniqueIdentifier] {
                    self.parseJson(uniqueIdentifierFlow: flow, rawDic: data)
                }
            }
        }
        else {
            self.requestFailWithError(uniqueIdentifier: String.Empty,
                    didFailWithError: GNTools.MakeError(message: "Response data is empty :("))
        }
    }
    
    public func requestFailWithError(uniqueIdentifier: String, didFailWithError error: Error) {
        if !self.esError {
            self.esError = true
            self.delegate?.requestFailWithError(error: error)
        }
    }
    
    open func parseJson(uniqueIdentifierFlow: Int, rawDic: NSDictionary) { }
    
    open func removeReferenceContext() {
        gnConnectionService?.removeReferenceContext()
        gnConnectionService = nil
        
        self.dcRequestReference?.removeAll()
        self.dcRequestReference = nil
        
        self.delegate = nil
    }
}
