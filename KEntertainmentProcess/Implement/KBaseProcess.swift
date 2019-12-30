//
//  KBaseProcess.swift
//  KEntertainmentProcess
//
//  Created by Javier Bolaños on 12/29/19.
//  Copyright © 2019 Javier Bolaños. All rights reserved.
//

import GNNetworkServices

public protocol KBaseProcessDelegate {
    func processFailWithError(error: Error)
}

public class KBaseProcess: NSObject, GNBaseServiceDelegate {
    private let tokenV4 = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmNTc1YWY0MjQzNjkxNzUwZjE2OGM5ZmE3ZGNkZmQzYyIsInN1YiI6IjVkNzU4ZmRmNTI5NGU3MDAwZWY0NmQ2MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.NT-V44hdmZtqg3syj3okOe3t1Vc4LX_2ddpvvshZuCo"
    private let tokenV3 = "f575af4243691750f168c9fa7dcdfd3c"
    
    public var delegate: KBaseProcessDelegate?
    
    override public init() {
        super.init()
    }
    
    public func requestFailWithError(error: Error) {
        self.delegate?.processFailWithError(error: error)
    }
    
    func getTokenHeader() -> [String: String] {
        return [
            "Authorization" : "Bearer \(self.tokenV4)"
        ]
    }
    
    var getTokenAPI: String {
        return self.tokenV3
    }
    
    public func removeReferenceContext() {
        self.delegate = nil
    }
}
