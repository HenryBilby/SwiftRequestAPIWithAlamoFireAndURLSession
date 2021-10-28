//
//  ViewController.swift
//  RequestAPIWithAlamoFireAndURLSession
//
//  Created by Henry Bilby on 27/10/21.
//

//Help to install cocoapods no M1:
//Utilizei o brew install cocoapods na raiz e na pasta do projeto após pod init
//arch -x86_64 pod install


import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    private let viewModel = ProbabilityPerNameViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }


    @IBAction func LoadProbabilities(_ sender: Any) {
        if let name = nameTextField.text {
            print("View Controller Name typed: \(name)")
            viewModel.loadProbabilities(name: name)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailViewController = segue.destination as? DetailViewController, segue.identifier == "detailProbabilities" {
            detailViewController.probabilityPerName = sender as? ProbabilityPerName
        }
    }
}

extension ViewController:ProbabilityPerNameDelegate {
    func loadedProbabilitiesPerName(probability: ProbabilityPerName) {
        print("ViewController:ProbabilityPerNameDelegate Name retrieved: \(probability.name)")
        performSegue(withIdentifier: "detailProbabilities", sender: probability)
    }
}
