//
//  CountriesViewController.swift
//  Test_TeamDoc
//
//  Created by Guillaume Donzeau on 03/06/2022.
//

import UIKit

class CountriesViewController: UIViewController {
    
    /* Petit changement = On charge les données à l'apparition de la vue pour permettre de les actualiser le cas échéant
     * Les données modifiées ont volontairement été laissées en commentaire
     */
    private var dataUsed = [[String : Country]]()
    //private let dataCountries = DataLoaded.allData.norm_Iso3166_2
    private var countries = [Country]()
    private var divisions = [String]()
    
    @IBOutlet weak var countriesPickerView: UIPickerView!
    
    @IBOutlet weak var divisionsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadingData()
        preparingDatas()
        countriesPickerView.reloadAllComponents()
        divisionsTableView.reloadData()
    }
    
    func setupView() {
        view.backgroundColor = AppColors.backgroundColor
    }
    
    func loadingData() {
        dataUsed = [[String : Country]]()
        countries = [Country]()
        divisions = [String]()
        dataUsed = DataLoaded.allData.norm_Iso3166_2
    }
    
    func preparingDatas() {
        // On charge un pays "vide" pour la présentation
        let firstCountryEmpty = Country(name: "- -", divisions: [:])
        countries.append(firstCountryEmpty)
        
        //for dico in dataCountries {
        for dico in dataUsed {
            for (_, country) in dico {
                countries.append(country)
            }
        }
    }
}

// MARK: - Gestion du PickerView

extension CountriesViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //dataCountries.count
        dataUsed.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        divisions = [String]() // Réinitialisation
        for (divisionIndex, division) in countries[row].divisions {
            divisions.append("\(divisionIndex) \(division)")
        }
        divisionsTableView.reloadData()
    }
}

// MARK: - Gestion de la TableView

extension CountriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        divisions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DivisionCell", for: indexPath)
        let division = divisions[indexPath.row]
        cell.textLabel?.text = division
        
        return cell
    }
}
