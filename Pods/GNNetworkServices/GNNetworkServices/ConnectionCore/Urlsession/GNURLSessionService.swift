//
//  BAVURLSessionService.swift
//  BAVService
//
//  Created by Javier on 20/01/18.
//  Copyright © 2018 GoNet. All rights reserved.
//

class GNURLSessionService: NSObject, GNMagicCoreServiceDelegate, URLSessionTaskDelegate {
    private lazy var _dcConnection: [String: URLSession?]? = [:]
    private lazy var _dcDataResponse: [String: Data]?      = [:]
    
    public var delegate: GNConnectionServiceDelegate?
    
    override public required init() {
        super.init()
    }
    
    public func submitRequest(request: URLRequest) -> String {
        let uniqueIdentifier = NSUUID().uuidString
        
        _dcConnection?[uniqueIdentifier] = nil
        _dcConnection?[uniqueIdentifier] = URLSession.shared
        
        let task = _dcConnection?[uniqueIdentifier]??.dataTask(with: request, completionHandler: { (data, response, error) in
            guard error == nil else {
                debugPrint("::: Error dataTask: \(#function) ::: \(error?.localizedDescription ?? "")")
                
                self.delegate?.requestFailWithError(uniqueIdentifier: uniqueIdentifier, didFailWithError: error!)
                return
            }
            
            self.delegate?.receiveResponse(uniqueIdentifier: uniqueIdentifier, didReceiveResponse: response!)
            
            guard let responseData = data else {
                debugPrint(":: Error: \(#function) ::: did not receive data")
                self.delegate?.requestFailWithError(uniqueIdentifier: uniqueIdentifier, didFailWithError: error!)
                
                return
            }
            
            self._dcDataResponse?[uniqueIdentifier] = responseData
            
            if let typeRes: Any = self.getGenericObject(id: uniqueIdentifier, responseData: responseData) {
                var dic: NSDictionary = [:]
                    
                if let dc = typeRes as? NSDictionary {
                    dic = dc
                }
                else {
                    dic = ["gh_generic_key": typeRes]
                }
                
                self.delegate?.receiveData(uniqueIdentifier: uniqueIdentifier,
                                               receiveRawDictionary: dic)
            }
            else {
                self.delegate?.requestFailWithError(uniqueIdentifier: uniqueIdentifier,
                                                    didFailWithError: GNTools.MakeError(message:
                                                                    "Trying convert data JSON to NSDictionary"))
            }
        })
        
        task?.resume()
        
        return uniqueIdentifier
    }
    
    private func getGenericObject<T>(id: String, responseData: Data) -> T? {
        var gen: T?
        
        do {
            if let generyc = try JSONSerialization.jsonObject(with: responseData, options: []) as? T {
                gen = generyc
            }
        }
        catch let err {
            self.delegate?.requestFailWithError(uniqueIdentifier: id, didFailWithError: err)
        }
        
        return gen
    }
    
    
    public func cancelRequestWithIdentifier(identifier: String) {
        _dcConnection?[identifier]??.invalidateAndCancel()
    }
    
    public func cancelAllRequest() {
        _dcConnection?.forEach { $0.value?.invalidateAndCancel() }
    }
    
    public func removeReferenceContext() {
        self.cancelAllRequest()
        
        _dcConnection?.removeAll()
        _dcConnection = nil
        
        _dcDataResponse?.removeAll()
        _dcDataResponse = nil
        
        self.delegate = nil
    }
}
