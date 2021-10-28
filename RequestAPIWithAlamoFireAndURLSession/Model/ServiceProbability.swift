//
//  ServiceProbability.swift
//  RequestAPIWithAlamoFireAndURLSession
//
//  Created by Henry Bilby on 27/10/21.
//

import Foundation
import SwiftyJSON
import Alamofire

enum ApiRequestType {
    case urlSession
    case alamoFire
}

class ServiceProbability {
    private let url = "https://api.nationalize.io?name="
    
    public func loadProbabilitiesPerName(name: String, type: ApiRequestType, completion: @escaping (ProbabilityPerName?)->Void){
        switch type {
            case .urlSession:
                self.loadProbabilitiesWithUrlSession(name: name) { probability in
                    completion(probability)
                }
            case .alamoFire:
                self.loadProbabilitiesWithAlamo(name: name) { probability in
                    completion(probability)
                }
        }
    }
    
    private func loadProbabilitiesWithUrlSession(name: String, completion: @escaping (ProbabilityPerName?)->Void) {
        guard let urlFull = URL(string:url+name) else {
            return completion(nil)
        }
        
        URLSession.shared.dataTask(with: urlFull) {data, response, error in
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                return completion(nil)
            }
            
            completion(self.decodeDataFromJSON(data: data))
            
        }.resume()
    }
    
    private func loadProbabilitiesWithAlamo(name: String, completion: @escaping (ProbabilityPerName?)->Void) {
        Alamofire.request(url+name).responseJSON { response in
            switch response.result {
                case .failure(_):
                    return completion(nil)
                case .success(_):
                    completion(self.decodeDataFromJSON(data: response.data))
            }
        }.resume()
    }
    
    private func decodeDataFromJSON(data: Data?) -> ProbabilityPerName? {
        guard let dataReceived = data else {
            return nil
        }
        
        do {
            let probabilityPerName = try JSONDecoder().decode(ProbabilityPerName.self, from: dataReceived)
            return probabilityPerName
        } catch (let error) {
            print("JSON Error: \(error.localizedDescription)")
            return nil
        }
    }
}
