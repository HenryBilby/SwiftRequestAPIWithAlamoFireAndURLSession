//
//  ProbabilityPerNameWithCountryTests.swift
//  RequestAPIWithAlamoFireAndURLSessionTests
//
//  Created by Henry Bilby on 28/10/21.
//

import XCTest

@testable import RequestAPIWithAlamoFireAndURLSession

class ProbabilityPerNameWithCountryTests: XCTestCase {

    func testInit() {
        let name = "Henry MMB"
        let country : [Country] = [.init(country_id: "Brazil", probability: 0.874),
                                   .init(country_id: "Japan", probability: 0.598),
                                   .init(country_id: "Canada", probability: 0.345)]
        
        let probability = ProbabilityPerName(name: name, country: country)
        
        XCTAssertEqual(probability.name, name)
        XCTAssertEqual(probability.country, country)
        
        let issue = ProbabilityPerName(name: name, country: country)
        XCTAssert(probability == issue)
    }

}
