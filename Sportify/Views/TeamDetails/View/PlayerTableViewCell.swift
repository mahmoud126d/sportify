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
        setupUI()
    }

    private func setupUI() {
        playerImage.layer.cornerRadius = playerImage.frame.width / 2
        playerImage.clipsToBounds = true
    }
    
}
