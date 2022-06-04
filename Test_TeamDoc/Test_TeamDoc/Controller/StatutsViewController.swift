//
//  StatutsViewController.swift
//  Test_TeamDoc
//
//  Created by Guillaume Donzeau on 03/06/2022.
//

import UIKit

class StatutsViewController: UIViewController {
    
    private var dataUsed = [ProStatus]()
    var hiddenSections = Set<Int>()
    
    @IBOutlet weak var statutsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadingData()
        sortingInAlphabeticOrder()
        statutsTableView.reloadData()
    }
    
    func setupView() {
        view.backgroundColor = AppColors.backgroundColor
        statutsTableView.layer.cornerRadius = 5
    }
    
    func loadingData() {
        dataUsed = DataLoaded.allData.proStatus
    }
    
    private func sortingInAlphabeticOrder() {
        // On classe chaque tableau de statut dans l'ordre, un par un
        for index in 0 ..< dataUsed.count {
            dataUsed[index].status.sort { $0.label < $1.label }
        }
    }
}

// MARK: - Gestion de la TableView

extension StatutsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        dataUsed.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.hiddenSections.contains(section) {
            return 0
        }
        return dataUsed[section].status.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatutCell", for: indexPath)
        let statut = dataUsed[indexPath.section].status[indexPath.row].label
        cell.textLabel?.text = statut
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(dataUsed[section].label)"
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionButton = UIButton()
        sectionButton.layer.borderWidth = 1
        sectionButton.layer.cornerRadius = 5
        sectionButton.setTitle(dataUsed[section].label, for: .normal)
        sectionButton.backgroundColor = AppColors.backgroundButton
        
        // Pour identifier le bouton, on lui assigne son numéro de section
        sectionButton.tag = section
        sectionButton.addTarget(self, action: #selector(self.hideSection(sender:)), for: .touchUpInside)
        
        return sectionButton
    }
    
    @objc private func hideSection(sender: UIButton) {
        // On récuppère la section concernée
        let section = sender.tag
        
        func indexPathsForSection() -> [IndexPath] {
            var indexPaths = [IndexPath]()
            
            for row in 0..<self.dataUsed[section].status.count {
                indexPaths.append(IndexPath(row: row, section: section))
            }
            return indexPaths
        }
        
        if self.hiddenSections.contains(section) {
            self.hiddenSections.remove(section)
            self.statutsTableView.insertRows(at: indexPathsForSection(), with: .fade)
        } else {
            self.hiddenSections.insert(section)
            self.statutsTableView.deleteRows(at: indexPathsForSection(), with: .fade)
        }
    }
}
