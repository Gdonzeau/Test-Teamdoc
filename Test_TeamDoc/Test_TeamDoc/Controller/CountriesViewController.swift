//
//  CountriesViewController.swift
//  Test_TeamDoc
//
//  Created by Guillaume Donzeau on 03/06/2022.
//

import UIKit

class CountriesViewController: UIViewController {
    
    private let dataCountries = DataLoaded.allData.norm_Iso3166_2
    private var countries = [String]()

    @IBOutlet weak var countriesPickerView: UIPickerView!
    
    @IBOutlet weak var divisionsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preparingDatas()
    }
    
    func preparingDatas() {
        
        for dico in dataCountries {
            for (countryIndex, country) in dico {
                print("Le pays \(country.name) a pour index \(countryIndex)")
                countries.append(country.name)
            }
        }
    }
}

extension CountriesViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        dataCountries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries[row]
    }
    
}
