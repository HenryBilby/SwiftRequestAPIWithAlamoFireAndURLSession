//
//  ProbabilityPerName.swift
//  RequestAPIWithAlamoFireAndURLSession
//
//  Created by Henry Bilby on 27/10/21.
//

import Foundation

struct ProbabilityPerName : Codable {
    let name : String
    let country : [Country]
}
