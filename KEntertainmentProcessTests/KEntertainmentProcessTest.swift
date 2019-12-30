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
            XCTFail("\n::: Error: \(error.localizedDescription)")
        }
    }

}
