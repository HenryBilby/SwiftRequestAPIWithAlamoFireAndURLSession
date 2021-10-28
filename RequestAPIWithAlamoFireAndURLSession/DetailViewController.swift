//
//  DetailViewController.swift
//  RequestAPIWithAlamoFireAndURLSession
//
//  Created by Henry Bilby on 27/10/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    public var probabilityPerName: ProbabilityPerName?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let probability = self.probabilityPerName {
            print("DetailViewController name retrieved: \(probability.name)")
        }
    }
}
