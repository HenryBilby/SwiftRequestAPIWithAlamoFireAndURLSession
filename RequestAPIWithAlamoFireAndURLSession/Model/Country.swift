//
//  Country.swift
//  RequestAPIWithAlamoFireAndURLSession
//
//  Created by Henry Bilby on 27/10/21.
//

import Foundation

struct Country : Codable {
    let country_id : String
    let probability : Double
}

extension Country : Equatable {
    static func == (lhs: Country, rhs: Country) -> Bool {
        return lhs.country_id == rhs.country_id &&
        lhs.probability == lhs.probability
    }
}
