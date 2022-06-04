//
//  SpecialityTableViewCell.swift
//  Test_TeamDoc
//
//  Created by Guillaume Donzeau on 04/06/2022.
//

import UIKit

class SpecialityTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var key: UILabel!
    
    @IBOutlet weak var externalKey: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(label: String, key: String, externalKey: String) {
        self.label.text = label
        self.key.text = key
        self.externalKey.text = externalKey
    }

}
