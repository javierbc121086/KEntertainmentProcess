//
//  KEntertainmentProcessTest.swift
//  KEntertainmentProcessTests
//
//  Created by Javier Bolaños on 12/30/19.
//  Copyright © 2019 Javier Bolaños. All rights reserved.
//

import XCTest
import GNNetworkServices
import KEntertainmentDomain
import KEntertainmentService
import RPEntertainmentData

@testable import KEntertainmentProcess

class KEntertainmentProcessTest: XCTestCase, KEntertainmentProcessDelegate {

    private var _entertainmentProcess: KEntertainmentProcess?
    private var _expectation: XCTestExpectation?
    private var _isFailed = false

    override func setUp() {
        super.setUp()
        _isFailed = false
        _entertainmentProcess = KEntertainmentProcess()
        _entertainmentProcess?.delegate = self
    }

    override func tearDown() {
        super.tearDown()
        _entertainmentProcess?.removeReferenceContext()
        _entertainmentProcess = nil
        _expectation = nil
    }

    /**********************************************************************
     ** Prueba que obtiene la lista de Peliculas y Tv Shows Exitosamente **
     **********************************************************************/
    func testListEntertainmentSuccess() {
        _expectation = expectation(description: "::: Get List Entertainment Success")
        _entertainmentProcess?.getListEntertainment()
        self.waitForExpectations(timeout: GNConfigService.TimeOutInterval, handler: nil)
    }
    
    func testSaveRabgeData() {
        let modelWrapper = RPEMovieWrapper()
        for index in 1...1000 {
            let movieModel = KMovieModel(
                id: index,
                popularity: Double(index),
                voteCount: index,
                video: false,
                adult: false,
                originalLanguage: "originalLanguage \(index)",
                originalTitle: "originalTitle \(index)",
                genreIds: [100, 200, 300],
                title: "title \(index)",
                voteAverage: Double(index),
                overview: "overview \(index)",
                releaseDate: "releaseDate \(index)",
                backdropPath: "backdropPath \(index)",
                posterPath: "posterPath \(index)",
                requestType: -1
            )
            
            modelWrapper.save(model: movieModel)
        }
    }
    
    func testGetAllDataStorage() {
        let movieWrapper = RPEMovieWrapper()
        let tvWrapper = RPETvWrapper()
        
        let movieList = movieWrapper.getAll()
        let tvList = tvWrapper.getAll()
        
        movieList?.forEach({ (movieModel) in
            print(movieModel)
        })
        
        tvList?.forEach({ (tvModel) in
            print(tvModel)
        })
    }
    
    func testDeleteStorageData() {
        let movieWrapper = RPEMovieWrapper()
        let tvWrapper = RPETvWrapper()
        
        movieWrapper.deleteAll()
        tvWrapper.deleteAll()
    }
    
    func dataResponseProcess(list: [KEntertainmentModel]) {
        _expectation?.fulfill()
        
        XCTAssert(list.isNotEmpty)
    }

    func processFailWithError(error: Error) {
        _expectation?.fulfill()

        if _isFailed {
            XCTAssert(!error.localizedDescription.isEmpty)
        }
        else {
            XCTFail("\n::::::::::: Error: \(error.localizedDescription)")
        }
    }

}
