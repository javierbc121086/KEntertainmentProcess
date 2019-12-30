//
//  KMovieProcessTest.swift
//  KEntertainmentProcessTests
//
//  Created by Javier Bolaños on 12/30/19.
//  Copyright © 2019 Javier Bolaños. All rights reserved.
//

import XCTest
import GNNetworkServices
import KEntertainmentDomain
import KEntertainmentService

@testable import KEntertainmentProcess

class KMovieProcessTest: XCTestCase, KMovieProcessDelegate {
    
    private var _movieProcess: KMovieProcess?
    private var _expectation: XCTestExpectation?
    private var _isFailed = false

    override func setUp() {
        super.setUp()
        _isFailed = false
        _movieProcess = KMovieProcess()
        _movieProcess?.delegate = self
    }

    override func tearDown() {
        super.tearDown()
        _movieProcess?.removeReferenceContext()
        _movieProcess = nil
        _expectation = nil
    }

    /************************************************************************
     ** Prueba que ejecuta el servicio de GetPopularityMovies Exitosamente **
     ************************************************************************/
    func testPopularityMoviesProcessSuccess() {
        _expectation = expectation(description: "::: Get Popularity Movies Process Success")
        _movieProcess?.getPopularityMovies()
        self.waitForExpectations(timeout: GNConfigService.TimeOutInterval, handler: nil)
    }

    /******************************************************************
     ** Prueba que ejecuta el servicio de GetRateMovies Exitosamente **
     ******************************************************************/
    func testRateMoviesProcessSuccess() {
        _expectation = expectation(description: "::: Get Rate Movies Process Success")
        _movieProcess?.getRateMovies()
        self.waitForExpectations(timeout: GNConfigService.TimeOutInterval, handler: nil)
    }

    /**********************************************************************
     ** Prueba que ejecuta el servicio de GetUpcomingMovies Exitosamente **
     **********************************************************************/
    func testUpcomingMoviesProcessSuccess() {
        _expectation = expectation(description: "::: Get Upcoming Movies Process Success")
        _movieProcess?.getUpcomingMovies()
        self.waitForExpectations(timeout: GNConfigService.TimeOutInterval, handler: nil)
    }

    func dataResponseProcess(data: [KMovieModel], type: KHttpRequestType) {
        _expectation?.fulfill()

        switch type {
            case .moviePopularity:
                XCTAssert(data.isNotEmpty)
            case .movieRate:
                XCTAssert(data.isNotEmpty)
            case .movieUpcoming:
                XCTAssert(data.isNotEmpty)
            default:
                XCTFail("\n::: Error: \(type) not valid")
        }
    }

    func processFailWithError(error: Error) {
        _expectation?.fulfill()

        if _isFailed {
            XCTAssert(!error.localizedDescription.isEmpty)
        }
        else {
            XCTFail("\n::: Error: \(error.localizedDescription)")
        }
    }
}
