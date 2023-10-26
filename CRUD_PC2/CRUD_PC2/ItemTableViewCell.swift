//
//  ItemTableViewCell.swift
//  CRUD_PC2
//
//  Created by DAMII on 24/10/23.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblApellido: UILabel!
    @IBOutlet weak var lblNumero: UILabel!
    @IBOutlet weak var lblOperador: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
