//
//  PlayerTableViewCell.swift
//  Sportify
//
//  Created by Macos on 15/05/2025.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var playerImage: UIImageView!
    
    @IBOutlet weak var playerName: UILabel!
    
    @IBOutlet weak var playerRole: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
