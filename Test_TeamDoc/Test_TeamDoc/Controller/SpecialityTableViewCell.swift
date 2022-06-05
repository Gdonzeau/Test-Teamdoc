//
//  SpecialityTableViewCell.swift
//  Test_TeamDoc
//
//  Created by Guillaume Donzeau on 04/06/2022.
//

import UIKit

class SpecialityTableViewCell: UITableViewCell {
    
    var howManySubcategories = 0 {
        didSet {
            if howManySubcategories > 0 {
                sub.isHidden = false
            } else {
                sub.isHidden = true
            }
        }
    }

    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var key: UILabel!
    
    @IBOutlet weak var externalKey: UILabel!
    
    @IBOutlet weak var sub: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(label: String, key: String, externalKey: String, howManySubcategories: Int) {
        self.label.text = label
        self.key.text = key
        self.externalKey.text = externalKey
        self.sub.text = ">"
        self.howManySubcategories = howManySubcategories
    }

}
