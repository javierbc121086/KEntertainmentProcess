//
//  KMovieProcess.swift
//  KEntertainmentProcess
//
//  Created by Javier Bolaños on 12/29/19.
//  Copyright © 2019 Javier Bolaños. All rights reserved.
//

import GNNetworkServices
import KEntertainmentService
import KEntertainmentDomain

public protocol KMovieProcessDelegate: KBaseProcessDelegate {
    func dataResponseProcess(data: [KMovieModel], type: KHttpRequestType)
}

public class KMovieProcess: KBaseProcess {
    private var _movieService: KMovieService?
    
    override public init() {
        super.init()
        
        _movieService = KMovieService(
                identifierService: GNConnectionType.NSURLSessionService.rawValue
        )
        _movieService?.delegate = self
    }
    
    public func getPopularityMovies() {
        _movieService?.httpGetRest(
            url: KServiceConfig.movie_popular,
            extraHeaders: self.getTokenHeader(),
            gnRequestType: KHttpRequestType.moviePopularity.rawValue)
    }

    public func getRateMovies() {
        _movieService?.httpGetRest(
                url: KServiceConfig.movie_rated,
                extraHeaders: self.getTokenHeader(),
                gnRequestType: KHttpRequestType.movieRate.rawValue)
    }

    public func getUpcomingMovies() {
        let tokenUrl = String(format: KServiceConfig.movie_upcoming, self.getTokenAPI)
        _movieService?.httpGetRest(
                url: tokenUrl,
                extraHeaders: self.getTokenHeader(),
                gnRequestType: KHttpRequestType.movieUpcoming.rawValue)
    }
    
    override public func removeReferenceContext() {
        _movieService?.removeReferenceContext()
        _movieService = nil
        
        super.removeReferenceContext()
    }
}
