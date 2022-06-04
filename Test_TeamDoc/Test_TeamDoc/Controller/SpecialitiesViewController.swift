//
//  SpecialitiesViewController.swift
//  Test_TeamDoc
//
//  Created by Guillaume Donzeau on 03/06/2022.
//

import UIKit

class SpecialitiesViewController: UIViewController {
    
    private var dataUsed = [Speciality]()

    @IBOutlet weak var specialitiesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadingData()
        specialitiesTableView.reloadData()
    }
    
    func setupView() {
        view.backgroundColor = AppColors.backgroundColor
        specialitiesTableView.layer.cornerRadius = 5
    }
    
    func loadingData() {
        dataUsed = DataLoaded.allData.speciality
    }
}

extension SpecialitiesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataUsed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SpecialityCell", for: indexPath) as? SpecialityTableViewCell else {
            return UITableViewCell()
        }
        
        let label = dataUsed[indexPath.row].label
        cell.label.text = label
        
        let key = dataUsed[indexPath.row].key
        cell.key.text = key
        
        let externalKey = dataUsed[indexPath.row].external_keys[0]
        cell.externalKey.text = externalKey
        
        return cell
    }
    
    
}
