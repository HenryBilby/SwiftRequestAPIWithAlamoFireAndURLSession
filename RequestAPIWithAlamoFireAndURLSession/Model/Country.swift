//
//  Country.swift
//  RequestAPIWithAlamoFireAndURLSession
//
//  Created by Henry Bilby on 27/10/21.
//

import Foundation

//{"country_id":"US","probability":0.08986482266532715}

class Country {
    let country_id : String
    let probability : Double
    
    init(country_id : String, probability : Double) {
        self.country_id = country_id
        self.probability = probability
    }
}
