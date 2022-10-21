//
//  EmployeesTableViewCell.swift
//  Avito_intern
//
//  Created by Егор Куракин on 19.10.2022.
//

import UIKit

class EmployeesTableViewCell: UITableViewCell {

    @IBOutlet weak var skilsTitle: UILabel!
    @IBOutlet weak var nameTitle: UILabel!
    @IBOutlet weak var phoneTitile: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
