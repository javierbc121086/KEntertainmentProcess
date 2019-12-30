//
//  KTvProcess.swift
//  KEntertainmentProcess
//
//  Created by Javier Bolaños on 12/30/19.
//  Copyright © 2019 Javier Bolaños. All rights reserved.
//

import GNNetworkServices
import KEntertainmentDomain
import KEntertainmentService

public protocol KTvProcessDelegate: KBaseProcessDelegate {
    func dataResponseProcess(data: [KTvModel], type: KHttpRequestType)
}

public class KTvProcess: KBaseProcess {
    private var _tvService: KTvService?
    
    override public init() {
        super.init()
        
        _tvService = KTvService(identifierService: GNConnectionType.NSURLSessionService.rawValue)
        _tvService?.delegate = self
    }
    
    public func getPopularityTv() {
        let tokenUrl = String(
            format: KServiceConfig.tv_popular, self.getTokenAPI
        )

        _tvService?.httpGetRest(
            url: tokenUrl,
            gnRequestType: KHttpRequestType.tvPopularity.rawValue)
    }

    public func getRateTv() {
        let tokenUrl = String(
                format: KServiceConfig.tv_rated, self.getTokenAPI
        )

        _tvService?.httpGetRest(
                url: tokenUrl,
                gnRequestType: KHttpRequestType.tvRate.rawValue)
    }

    public func getUpcomingTv() {
        let tokenUrl = String(
                format: KServiceConfig.tv_upcoming,
                self.getTokenAPI,
                self.getDateFilter()
        )

        _tvService?.httpGetRest(
                url: tokenUrl,
                gnRequestType: KHttpRequestType.tvUpcoming.rawValue)
    }

    func getDateFilter() -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy-MM-dd"

        let dateStr = dateFormatterPrint.string(from: Date())

        return dateStr
    }
    
    override public func removeReferenceContext() {
        _tvService?.removeReferenceContext()
        _tvService = nil
        
        super.removeReferenceContext()
    }
}
