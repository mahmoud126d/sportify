//
//  LatestEventCollectionViewCell.swift
//  Sportify
//
//  Created by Aya Emam on 16/05/2025.
//

import UIKit

class LatestEventCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var homeTeamImage: UIImageView!
    
    @IBOutlet weak var awayTeamImage: UIImageView!
    
    @IBOutlet weak var homeTeamLabel: UILabel!
    
    @IBOutlet weak var awayTeamLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
