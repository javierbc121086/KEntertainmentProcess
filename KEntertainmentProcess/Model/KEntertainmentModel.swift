//
//  KEntertainmentModel.swift
//  KEntertainmentProcess
//
//  Created by Javier Bolaños on 12/30/19.
//  Copyright © 2019 Javier Bolaños. All rights reserved.
//

import KEntertainmentDomain

public class KEntertainmentModel: NSObject {
    public var type: KHttpRequestType = .none
    public var list: [KEntertainmentType]? = nil
    
    public init(type: KHttpRequestType) {
        self.type = type
        super.init()
    }
}
