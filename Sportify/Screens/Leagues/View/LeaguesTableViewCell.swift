//
//  LeaguesTableViewCell.swift
//  Sportify
//
//  Created by Macos on 14/05/2025.
//

import UIKit

class LeaguesTableViewCell: UITableViewCell {

    @IBOutlet weak var leagueNameLabel: UILabel!
    
    @IBOutlet weak var leagueImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupUI()
        // Configure the view for the selected state
    }
        private func setupUI() {
            leagueImage.layer.cornerRadius = leagueImage.frame.width / 2
            leagueImage.clipsToBounds = true
        }
    
}
