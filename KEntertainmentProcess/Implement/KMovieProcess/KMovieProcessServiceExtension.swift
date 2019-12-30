//
//  KMovieProcessServiceExtension.swift
//  KEntertainmentProcess
//
//  Created by Javier Bolaños on 12/29/19.
//  Copyright © 2019 Javier Bolaños. All rights reserved.
//

import KEntertainmentService
import KEntertainmentDomain

extension KMovieProcess: KMovieServiceDelegate {
    public func dataResponseService(response: [KMovieModel], type: KHttpRequestType) {
        (self.delegate as? KMovieProcessDelegate)?.dataResponseProcess(data: response, type: type)
    }
}
