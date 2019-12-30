//
//  KEntertainmentProcess.swift
//  KEntertainmentProcess
//
//  Created by Javier Bolaños on 12/30/19.
//  Copyright © 2019 Javier Bolaños. All rights reserved.
//

import KEntertainmentDomain
import KEntertainmentService

public protocol KEntertainmentProcessDelegate: KBaseProcessDelegate {
    func dataResponseProcess(list: [KEntertainmentModel])
}

public class KEntertainmentProcess: KBaseProcess {
    private var _movieProcess: KMovieProcess?
    private var _tvProcess: KTvProcess?
    
    private var _list: [KEntertainmentModel] = []
    
    override public init() {
        super.init()
        
        _movieProcess   = KMovieProcess()
        _movieProcess?.delegate = self
        
        _tvProcess      = KTvProcess()
        _tvProcess?.delegate = self
        
        _list.append(KEntertainmentModel(type: .moviePopularity))
        _list.append(KEntertainmentModel(type: .movieRate))
        _list.append(KEntertainmentModel(type: .movieUpcoming))
        _list.append(KEntertainmentModel(type: .tvPopularity))
        _list.append(KEntertainmentModel(type: .tvRate))
        _list.append(KEntertainmentModel(type: .tvUpcoming))
        
    }
    
    func getListEntertainment() {
        _movieProcess?.getPopularityMovies()
        _movieProcess?.getRateMovies()
        _movieProcess?.getUpcomingMovies()
        
        _tvProcess?.getPopularityTv()
        _tvProcess?.getRateTv()
        _tvProcess?.getUpcomingTv()
    }
    
    public func processFailWithError(error: Error) {
        self.delegate?.processFailWithError(error: error)
    }
    
    private func validateCommonResponse(data: [KEntertainmentType], type: KHttpRequestType) {
        for item in _list {
            if item.type == type {
                item.list = data
                break
            }
        }
        
        let listIsEmpty = _list.filter { $0.list == nil }.isEmpty
        
        if listIsEmpty {
            (self.delegate as? KEntertainmentProcessDelegate)?.dataResponseProcess(list: _list)
        }
    }
}

extension KEntertainmentProcess: KMovieProcessDelegate {
    public func dataResponseProcess(data: [KMovieModel], type: KHttpRequestType) {
        self.validateCommonResponse(data: data, type: type)
    }
}

extension KEntertainmentProcess: KTvProcessDelegate {
    public func dataResponseProcess(data: [KTvModel], type: KHttpRequestType) {
        self.validateCommonResponse(data: data, type: type)
    }
}
