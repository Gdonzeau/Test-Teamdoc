//
//  SubSpecialityViewController.swift
//  Test_TeamDoc
//
//  Created by Guillaume Donzeau on 04/06/2022.
//

import UIKit

class SubSpecialityViewController: UIViewController {
    
    var subSpecialities = [SubSpeciality]()

    @IBAction func dismiss(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.backgroundColor
    }
}

extension SubSpecialityViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        subSpecialities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subSpecialityCell", for: indexPath)
        let speciality = subSpecialities[indexPath.row]
        cell.textLabel?.text = speciality.label
        
        return cell
    }
    
    
}
