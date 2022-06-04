//
//  ViewController.swift
//  Test_TeamDoc
//
//  Created by Guillaume Donzeau on 02/06/2022.
//

import UIKit

class LoadDataViewController: UIViewController {
    
    let dataService = DataService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupView()
    }
    
    func setupView() {
        view.backgroundColor = AppColors.backgroundColor
    }
    
    func loadData() {
        let stringAdress = APIConfig.adress
        dataService.getData(stringAdress: stringAdress) {
            message in
            
            switch message {
            case.success(let results):
                print(results.appVersion[0].os)
                print(results.norm_Iso3166_2.count)
                
                if self.sizeFilesEqual(firstFile: results, secondFile: DataLoaded.allData) {
                    print("Pas de mise à jour")
                } else {
                    print("On met à jour")
                    DataLoaded.allData = results
                }
                
            case.failure(let error):
                if let errorMessage = error.errorDescription, let errorTitle = error.failureReason {
                    self.allErrors(errorMessage: errorMessage, errorTitle: errorTitle)
                }
                return
            }
        }
    }
    
    private func allErrors(errorMessage: String, errorTitle: String) {
        let alertVC = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC,animated: true,completion: nil)
    }
    
    func sizeFilesEqual(firstFile: GeneralBase, secondFile: GeneralBase) -> Bool {
        
        if firstFile == secondFile {
            return true
        } else {
            return false
        }
    }
}

