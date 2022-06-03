//
//  StatutsViewController.swift
//  Test_TeamDoc
//
//  Created by Guillaume Donzeau on 03/06/2022.
//

import UIKit

class StatutsViewController: UIViewController {

    private var dataStatuts = DataLoaded.allData.proStatus
    
    @IBOutlet weak var statutsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sortingInAlphabeticOrder()
    }
    
    private func sortingInAlphabeticOrder() {
        // On classe chaque tableau de statut dans l'ordre, un par un
        for index in 0 ..< dataStatuts.count {
            dataStatuts[index].status.sort { $0.label < $1.label }
        }
    }
}

// MARK: - Gestion de la TableView

extension StatutsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        dataStatuts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataStatuts[section].status.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatutCell", for: indexPath)
        let statut = dataStatuts[indexPath.section].status[indexPath.row].label
        cell.textLabel?.text = statut
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 100
        }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(dataStatuts[section].label)"
    }
}
