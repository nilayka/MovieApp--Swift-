//
//  headerCell.swift
//  MovieApp
//
//  Created by Nilay KADİROĞULLARI on 20.07.2023.
//

import UIKit

class HeaderCell: UITableViewCell {

    @IBOutlet weak var headerLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(title: String) {

        //title text
        headerLabel.text = title

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
