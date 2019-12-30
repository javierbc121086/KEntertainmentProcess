//
//  GNConnectionServiceDelegate.swift
//  GNNetworkServices
//
//  Created by Javier Bolaños on 8/5/19.
//  Copyright © 2019 GoNet. All rights reserved.
//

@objc public protocol GNConnectionServiceDelegate: class {
    
    @objc func receiveResponse(uniqueIdentifier: String,
                               didReceiveResponse response: URLResponse)
    
    @objc func receiveData(uniqueIdentifier: String,
                           receiveRawDictionary data: NSDictionary)
    
    @objc func requestFailWithError(uniqueIdentifier: String,
                                    didFailWithError error: Error)
    
    @objc func parseJson(uniqueIdentifierFlow: Int,
                         rawDic: NSDictionary)
    @objc func removeReferenceContext()
}
