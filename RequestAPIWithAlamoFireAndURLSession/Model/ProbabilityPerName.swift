//
//  ProbabilityPerName.swift
//  RequestAPIWithAlamoFireAndURLSession
//
//  Created by Henry Bilby on 27/10/21.
//

import Foundation

class ProbabilityPerName {
    let name : String
    let countries : [Country]

    init(name : String, countries : [Country]) {
        self.name = name
        self.countries = countries
    }
}
