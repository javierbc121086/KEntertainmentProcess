//
//  KEntertainmentProcess.swift
//  KEntertainmentProcess
//
//  Created by Javier Bolaños on 12/30/19.
//  Copyright © 2019 Javier Bolaños. All rights reserved.
//

import KEntertainmentDomain
import KEntertainmentService
import RPEntertainmentData
import GNSwissRazor
import GNNetworkServices

public protocol KEntertainmentProcessDelegate: KBaseProcessDelegate {
    func dataResponseProcess(list: [KEntertainmentModel])
}

public class KEntertainmentProcess: KBaseProcess {
    private var _movieProcess: KMovieProcess?
    private var _tvProcess: KTvProcess?
    
    private var _list: [KEntertainmentModel] = []
    private lazy var tvWrapper = RPETvWrapper()
    private lazy var movieWrapper = RPEMovieWrapper()
    
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
    
    private func isValidNetworkConnection() -> Bool {
        return GNDependencySeriveConfig.getStatusNetwork()
    }
    
    public func getListEntertainment() {
        if self.isValidNetworkConnection() {
            _movieProcess?.getPopularityMovies()
            _movieProcess?.getRateMovies()
            _movieProcess?.getUpcomingMovies()
            
            _tvProcess?.getPopularityTv()
            _tvProcess?.getRateTv()
            _tvProcess?.getUpcomingTv()
        }
        else {
            self.getStorageData()
        }
    }
    
    private func getStorageData() {
        let listMovie = self.movieWrapper.getAll()
        let listTv = self.tvWrapper.getAll()
        
        for item in _list {
            let listMovieFilter = listMovie?.filter({ movie -> Bool in
                movie.requestType == item.type.rawValue
            })
            
            if let list = listMovieFilter, list.isNotEmpty {
                item.list = list
            }
            else {
                let listTvFilter = listTv?.filter({ tv -> Bool in
                    tv.requestType == item.type.rawValue
                })
                if let list = listTvFilter, list.isNotEmpty {
                    item.list = listTvFilter
                }
            }
        }
        
        let listIsEmpty = _list.filter { $0.list == nil }.isEmpty
        
        if listIsEmpty {
            (self.delegate as? KEntertainmentProcessDelegate)?.dataResponseProcess(list: _list)
        }
        else {
            self.processFailWithError(error: GNTools.MakeError(message: "No valid Storage Data"))
        }
    }
    
    private func saveRequestDataToCache() {
        self.movieWrapper.deleteAll()
        self.tvWrapper.deleteAll()
        
        _list.forEach { entertainmentModel in
            entertainmentModel.list?.forEach({ model in
                if let movieModel = model as? KMovieModel {
                    var temp = movieModel
                    temp.requestType = entertainmentModel.type.rawValue
                    self.movieWrapper.save(model: temp)
                }
                else if let tvModel = model as? KTvModel {
                    var temp = tvModel
                    temp.requestType = entertainmentModel.type.rawValue
                    self.tvWrapper.save(model: temp)
                }
            })
        }
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
            self.saveRequestDataToCache()
            (self.delegate as? KEntertainmentProcessDelegate)?.dataResponseProcess(list: _list)
        }
    }
    
    public func processFailWithError(error: Error) {
        self.delegate?.processFailWithError(error: error)
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
