//
//  ProbabilityPerNameViewModel.swift
//  RequestAPIWithAlamoFireAndURLSession
//
//  Created by Henry Bilby on 27/10/21.
//

import Foundation

protocol ProbabilityPerNameDelegate {
    func loadedProbabilitiesPerName(probability: ProbabilityPerName)
    func errorOnLoaded()
}

class ProbabilityPerNameViewModel {
    public var delegate : ProbabilityPerNameDelegate?
    
    private let service = ServiceProbability()
    
    public func loadProbabilities(name : String, type: ApiRequestType) {
        service.loadProbabilitiesPerName(name: name, type: type) { probability in
            DispatchQueue.main.async {
                if let probability = probability {
                    self.delegate?.loadedProbabilitiesPerName(probability: probability)
                } else {
                    self.delegate?.errorOnLoaded()
                }
            }
        }
    }
}
