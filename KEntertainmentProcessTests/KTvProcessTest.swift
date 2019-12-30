//
//  KTvProcessTest.swift
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

class KTvProcessTest: XCTestCase, KTvProcessDelegate {
    private var _tvProcess: KTvProcess?
    private var _expectation: XCTestExpectation?
    private var _isFailed = false

    override func setUp() {
        super.setUp()
        _isFailed = false
        _tvProcess = KTvProcess()
        _tvProcess?.delegate = self
    }

    override func tearDown() {
        super.tearDown()
        _tvProcess?.removeReferenceContext()
        _tvProcess = nil
        _expectation = nil
    }

    /********************************************************************
     ** Prueba que ejecuta el servicio de GetPopularityTv Exitosamente **
     ********************************************************************/
    func testPopularityTVProcessSuccess() {
        _expectation = expectation(description: "::: Get Popularity TV Process Success")
        _tvProcess?.getPopularityTv()
        self.waitForExpectations(timeout: GNConfigService.TimeOutInterval, handler: nil)
    }

    /**************************************************************
     ** Prueba que ejecuta el servicio de GetRateTv Exitosamente **
     **************************************************************/
    func testRateTVProcessSuccess() {
        _expectation = expectation(description: "::: Get Rate TV Process Success")
        _tvProcess?.getRateTv()
        self.waitForExpectations(timeout: GNConfigService.TimeOutInterval, handler: nil)
    }

    /******************************************************************
     ** Prueba que ejecuta el servicio de GetUpcomingTv Exitosamente **
     ******************************************************************/
    func testUpcomingTVProcessSuccess() {
        _expectation = expectation(description: "::: Get Upcoming TV Process Success")
        _tvProcess?.getUpcomingTv()
        self.waitForExpectations(timeout: GNConfigService.TimeOutInterval, handler: nil)
    }

    func testGetCurrentValidDate() {
        if let dateStr = _tvProcess?.getDateFilter() {
            XCTAssert(dateStr.isNotEmpty)
            return
        }

        XCTFail("\n::: Error: Date not valid")
    }

    func dataResponseProcess(data: [KTvModel], type: KHttpRequestType) {
        _expectation?.fulfill()

        switch type {
        case .tvPopularity:
            XCTAssert(data.isNotEmpty)
        case .tvRate:
            XCTAssert(data.isNotEmpty)
        case .tvUpcoming:
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
