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

    @IBOutlet weak var loadingActivity: UIActivityIndicatorView!
    @IBOutlet weak var nameTextField: UITextField!
    
    private let viewModel = ProbabilityPerNameViewModel()
    
    @IBOutlet weak var apiRequestSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate = self
    }


    @IBAction func LoadProbabilities(_ sender: Any) {
        print("Indice selecionado: \(apiRequestSegmentedControl.selectedSegmentIndex)")
        
        if let name = self.nameTextField.text, !name.isEmpty {
            loadingActivity.startAnimating()
            switch apiRequestSegmentedControl.selectedSegmentIndex {
                case 0:
                    self.viewModel.loadProbabilities(name: name, type: .urlSession)
                case 1:
                    self.viewModel.loadProbabilities(name: name, type: .alamoFire)
                default:
                    break
            }
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
    
    private func stopLoadingIndicator() {
        if self.loadingActivity.isAnimating {
            self.loadingActivity.stopAnimating()
        }
    }
}

extension ViewController:ProbabilityPerNameDelegate {
    func errorOnLoaded() {
        stopLoadingIndicator()
        showDialog(message: "Erro ao carregar os dados.", title: "Erro", probability: nil)
    }
    
    func loadedProbabilitiesPerName(probability: ProbabilityPerName) {
        stopLoadingIndicator()
        showDialog(message: "Sucesso ao carregar os dados.", title: "Sucesso", probability: probability)
    }
}
