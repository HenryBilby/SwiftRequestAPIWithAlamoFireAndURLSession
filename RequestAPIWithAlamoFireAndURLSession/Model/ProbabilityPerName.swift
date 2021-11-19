//
//  ProbabilityPerName.swift
//  RequestAPIWithAlamoFireAndURLSession
//
//  Created by Henry Bilby on 27/10/21.
//

import Foundation

struct ProbabilityPerName : Decodable {
    let name : String
    let country : [Country]
}

extension ProbabilityPerName: Equatable {
    static func == (lhs: ProbabilityPerName, rhs: ProbabilityPerName) -> Bool {
        return lhs.name == rhs.name &&
        lhs.country == rhs.country
    }
}
