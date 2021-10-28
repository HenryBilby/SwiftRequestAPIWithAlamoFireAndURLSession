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
    private var probabilityPerName : ProbabilityPerName?
    
    public func loadProbabilitiesWithUrlSession(name : String) {
        service.loadProbabilitiesWithUrlSession(name: name) { probabilityPerName in
            if let probability = probabilityPerName {
                DispatchQueue.main.async {
                    self.delegate?.loadedProbabilitiesPerName(probability: probability)
                }
            } else {
                DispatchQueue.main.async {
                    self.delegate?.errorOnLoaded()
                }
            }
        }
    }
}
