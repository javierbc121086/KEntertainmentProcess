//
//  GNBaseServiceDelegate.swift
//  GNNetworkServices
//
//  Created by Javier Bolaños on 8/5/19.
//  Copyright © 2019 GoNet. All rights reserved.
//

@objc public protocol GNBaseServiceDelegate: class {
    @objc func requestFailWithError(error: Error)
}
