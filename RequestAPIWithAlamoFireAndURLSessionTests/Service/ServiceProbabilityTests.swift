//
//  ServiceProbabilityTests.swift
//  RequestAPIWithAlamoFireAndURLSessionTests
//
//  Created by Henry Bilby on 28/10/21.
//

import XCTest

@testable import RequestAPIWithAlamoFireAndURLSession

class ServiceProbabilityTests: XCTestCase {
    private var sut: ServiceProbability!
    private var jsonData: Data!

    override func setUp() {
        super.setUp()
        // sut - system under test
        sut = ServiceProbability()
        
        guard let bundlePath = Bundle.main.path(forResource: "result", ofType: "json") else {
            return XCTFail("Error: non-existent file")
        }
        
        do {
            jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8)
        } catch let error {
            XCTFail("Error: \(error.localizedDescription)")
        }
        
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testWithJsonFile() throws {
        let probability = sut.decodeDataFromJSON(data: jsonData)

        XCTAssert(probability != nil)
        XCTAssertEqual(probability?.name, "henry")
        XCTAssert(probability?.country.count == 3)
    }
    
    func testWithDataNil() {
        let propabilityLocal = sut.decodeDataFromJSON(data: nil)
        
        XCTAssertNil(propabilityLocal)
    }
    
    func testWithUrlSession() {
        let promise = expectation(description: "testWithUrlSession")
        
        sut.loadProbabilitiesWithUrlSession(name: "henry") { probabilityLocal in
            if probabilityLocal != nil {
                XCTAssertEqual(probabilityLocal?.name, "henry")
                promise.fulfill()
            } else {
                XCTFail("Error: cannot request probability per name at API.")
            }
        }
        waitForExpectations(timeout: 4, handler: nil)
    }

    func testWithAlamoFire() {
        let promise = expectation(description: "testWithAlamoFire")
        
        sut.loadProbabilitiesWithAlamo(name: "henry") { probabilityLocal in
            if probabilityLocal != nil {
                XCTAssertEqual(probabilityLocal?.name, "henry")
                promise.fulfill()
            } else {
                XCTFail("Error: cannot request probability per name at API.")
            }
        }
        waitForExpectations(timeout: 4, handler: nil)
    }
    
}
