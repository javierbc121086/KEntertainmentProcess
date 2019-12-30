//
//  GNMagicCoreServiceDelegate.swift
//  GNNetworkServices
//
//  Created by Javier Bolaños on 8/5/19.
//  Copyright © 2019 GoNet. All rights reserved.
//

@objc public protocol GNMagicCoreServiceDelegate: class {
    var delegate: GNConnectionServiceDelegate? { get set }
    
    init()
    
    func submitRequest(request: URLRequest) -> String
    func cancelRequestWithIdentifier(identifier: String)
    func cancelAllRequest()
    
    func removeReferenceContext()
}
