//
//  DetailViewController.swift
//  RequestAPIWithAlamoFireAndURLSession
//
//  Created by Henry Bilby on 27/10/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    public var probabilityPerName: ProbabilityPerName?
    
    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let probability = self.probabilityPerName {
            contentTextView.text.append("Name: \(probability.name)\n")
            for nation in probability.country {
                contentTextView.text.append("Country ID: \(nation.country_id) ")
                contentTextView.text.append("Probability: \(nation.probability)\n")
            }
            
        }
    }
}
