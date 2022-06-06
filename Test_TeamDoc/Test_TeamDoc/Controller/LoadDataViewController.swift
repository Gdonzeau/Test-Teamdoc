//
//  ViewController.swift
//  Test_TeamDoc
//
//  Created by Guillaume Donzeau on 02/06/2022.
//

import UIKit

class LoadDataViewController: UIViewController {
    
    let dataService = DataService.shared
    var onLineVersion = GeneralBase(resource_version: 0, appVersion: [OS](), prefixes: [Prefix](), norm_Iso3166_2: [[String : Country]](), proStatus: [ProStatus](), speciality: [Speciality]())
    
    var didLoadLastVersion = false {
        didSet {
            if didLoadLastVersion {
                updateButton.isHidden = false // Le bouton apparaît pour la démonstration. On peut ensuite le passer en commentaire. Si les versions sont différentes il apparaîtra.
                if self.sizeFilesEqual(firstFile: onLineVersion, secondFile: DataLoaded.allData) {
                    print("Pas de mise à jour nécessaire")
                } else {
                    print("On peut mettre à jour")
                    updateButton.isHidden = false
                }
            } else {
                
            }
        }
    }
    
    var didUpdateVersion = false
    
    @IBOutlet weak var mainTitle: UILabel!
    
    @IBOutlet weak var loadDataButton: UIButton!
    
    @IBOutlet weak var versionMemorized: UITextView!
    
    @IBOutlet weak var updateButton: UIButton!
    
    @IBOutlet weak var onLineVersionTextView: UITextView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func loadData(_ sender: UIButton) {
        loadData()
    }
    
    @IBAction func update(_ sender: UIButton) {
        update()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showActivityIndicator(show: false)
        updateButton.isHidden = true
        //loadData() // On peut demander aussi une actualisation au démarrage en retirant le commentaire
        setupView()
    }
    
    func setupView() {
        view.backgroundColor = AppColors.backgroundColor
        loadDataButton.backgroundColor = AppColors.backgroundButton
        loadDataButton.layer.cornerRadius = 5
        loadDataButton.layer.borderWidth = 1
        
        updateButton.backgroundColor = AppColors.backgroundButton
        updateButton.layer.cornerRadius = 5
        updateButton.layer.borderWidth = 1
        
        versionMemorized.layer.cornerRadius = 5
        versionMemorized.layer.borderWidth = 1
        
        onLineVersionTextView.layer.cornerRadius = 5
        onLineVersionTextView.layer.borderWidth = 1
        
        mainTitle.text = "Version en cours"
        
        versionMemorized.text =
            """
            Version utilisée :

            version ressources : \(DataLoaded.allData.resource_version)

            version android : \(DataLoaded.allData.appVersion[0].intern)
            version iOS : \(DataLoaded.allData.appVersion[1].intern)

            Nombre de pays mémorisés : \(DataLoaded.allData.norm_Iso3166_2.count)
            Nombre de statuts mémorisés : \(DataLoaded.allData.proStatus.count)
            Nombre de spécialités mémorisées : \(DataLoaded.allData.speciality.count)
            """
        
        onLineVersionTextView.text =
            """
            Version en ligne :

            version ressources : \(onLineVersion.resource_version == 0 ? "inconnue": String(onLineVersion.resource_version))

            version android : \(onLineVersion.appVersion.count >= 1 ? String(onLineVersion.appVersion[0].intern) : "inconnue")
            version iOS : \(onLineVersion.appVersion.count >= 2 ? String(onLineVersion.appVersion[1].intern) : "inconnue")

            Nombre de pays mémorisés : \(onLineVersion.norm_Iso3166_2.count == 0 ? "inconnu": String(onLineVersion.norm_Iso3166_2.count))
            Nombre de statuts mémorisés : \(onLineVersion.proStatus.count == 0 ? "inconnu": String(onLineVersion.proStatus.count))
            Nombre de spécialités mémorisées : \(onLineVersion.speciality.count == 0 ? "inconnu": String(onLineVersion.speciality.count))
            """
        
        
        showActivityIndicator(show: false)
    }
    
    func loadData() {
        showActivityIndicator(show: true)
        let stringAdress = APIConfig.adress
        dataService.getData(stringAdress: stringAdress) {
            message in
            
            switch message {
            case.success(let results):
                print(results.appVersion[0].os)
                print(results.norm_Iso3166_2.count)
                self.didLoadLastVersion = true
                self.onLineVersion = results
                self.setupView()
                
            case.failure(let error):
                if let errorMessage = error.errorDescription, let errorTitle = error.failureReason {
                    self.allErrors(errorMessage: errorMessage, errorTitle: errorTitle)
                }
                self.showActivityIndicator(show: false)
                return
            }
        }
    }
    
    func showActivityIndicator(show: Bool) {
        activityIndicator.isHidden = !show
        onLineVersionTextView.isHidden = show
    }
    
    func update() {
        print("On met à jour")
        DataLoaded.allData = onLineVersion
        updateButton.isHidden = true
        didUpdateVersion = true
        setupView()
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

