//
//  ServiceProbability.swift
//  RequestAPIWithAlamoFireAndURLSession
//
//  Created by Henry Bilby on 27/10/21.
//

import Foundation

class ServiceProbability {
    
    let url_typed = "https://api.nationalize.io?name="
    
    public func loadProbabilitiesWithUrlSession(name: String, completion: @escaping (ProbabilityPerName?)->Void) {
        guard let url = URL(string:url_typed+name) else {
            return completion(nil)
        }
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            guard let dataReceived = data else {
                print("Erro ao receber os dados")
                return completion(nil)
            }
            
            do {
                let probabilityPerName = try JSONDecoder().decode(ProbabilityPerName.self, from: dataReceived)
                completion(probabilityPerName)
            } catch {
                print("JSON Error: \(error.localizedDescription)")
                completion(nil)
            }
            
        }.resume()
    }
    
    public func loadProbabilitiesWithAlamo(name: String, completion: @escaping (ProbabilityPerName?)->Void) {
    
    }
}
