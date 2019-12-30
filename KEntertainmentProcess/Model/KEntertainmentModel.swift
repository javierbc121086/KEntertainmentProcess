//
//  KEntertainmentModel.swift
//  KEntertainmentProcess
//
//  Created by Javier Bolaños on 12/30/19.
//  Copyright © 2019 Javier Bolaños. All rights reserved.
//

import KEntertainmentDomain

public class KEntertainmentModel: NSObject {
    var type: KHttpRequestType = .none
    var list: [KEntertainmentType]? = nil
    
    init(type: KHttpRequestType) {
        self.type = type
        super.init()
    }
}
