//
//  KTvProcessServiceExtension.swift
//  KEntertainmentProcess
//
//  Created by Javier Bolaños on 12/30/19.
//  Copyright © 2019 Javier Bolaños. All rights reserved.
//

import KEntertainmentService
import KEntertainmentDomain

extension KTvProcess: KTvServiceDelegate {
    public func dataResponseService(response: [KTvModel], type: KHttpRequestType) {
        (self.delegate as? KTvProcessDelegate)?.dataResponseProcess(data: response, type: type)
    }
}
