//
//  ViewController.swift
//  Test_TeamDoc
//
//  Created by Guillaume Donzeau on 02/06/2022.
//

import UIKit

class ViewController: UIViewController {
    
    let dataService = DataService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstTry()
    }
    
    func firstTry() {
        let stringAdress = APIConfig.adress
        dataService.getData(stringAdress: stringAdress) {
            message in
            
            switch message {
            case.success(let results):
                print(results.appVersion[0].os)
                print(results.norm_Iso3166_2.count)
                
            case.failure(let error):
                print(error)
                return
            }
        }
    }
}

