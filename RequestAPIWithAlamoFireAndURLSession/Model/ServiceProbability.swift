//
//  ServiceProbability.swift
//  RequestAPIWithAlamoFireAndURLSession
//
//  Created by Henry Bilby on 27/10/21.
//

import Foundation

class ServiceProbability {
    
    public func loadProbabilitiesWithUrlSession(name: String, completion: @escaping (ProbabilityPerName?)->Void) {
        let url_typed = "https://api.nationalize.io?name=\(name)"
        
        print(url_typed)
        
        guard let url = URL(string:url_typed) else {
            return completion(nil)
        }
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            guard let dataReceived = data else {
                print("Erro ao receber os dados")
                return completion(nil)
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: dataReceived, options: [])
                print(json)
            } catch {
                print("JSON Error: \(error.localizedDescription)")
            }
        }.resume()
        
        print("Service loadProbabilitiesWithUrlSession Name typed: \(name)")
        let countries : [Country] = [.init(country_id: "US", probability: 0.08986482266532715),
                                     .init(country_id: "AU", probability: 0.05976757527083082)]

        let prob = ProbabilityPerName(name: "Michael", countries: countries)

        completion(prob)
    }
}
