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
            viewModel.loadProbabilitiesWithUrlSession(name: name.lowercased())
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailViewController = segue.destination as? DetailViewController, segue.identifier == "detailProbabilities" {
            detailViewController.probabilityPerName = sender as? ProbabilityPerName
        }
    }
    
    private func showDialog(message :String, title: String, probability: ProbabilityPerName?) {
        let dialogMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            if let probabilityLocal = probability {
                self.performSegue(withIdentifier: "detailProbabilities", sender: probabilityLocal)
            }
        })
         
        dialogMessage.addAction(ok)
        
        self.present(dialogMessage, animated: true, completion: nil)
    }
}

extension ViewController:ProbabilityPerNameDelegate {
    func errorOnLoaded() {
        showDialog(message: "Erro ao carregar os dados.", title: "Erro", probability: nil)
    }
    
    func loadedProbabilitiesPerName(probability: ProbabilityPerName) {
        showDialog(message: "Sucesso ao carregar os dados.", title: "Sucesso", probability: probability)
    }
}
