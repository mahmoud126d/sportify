//
//  UpcomingEventCollectionViewCell.swift
//  Sportify
//
//  Created by Aya Emam on 15/05/2025.
//

import UIKit

class UpcomingEventCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var homeTeamImage: UIImageView!
    
    @IBOutlet weak var awayTeamImage: UIImageView!
    
    @IBOutlet weak var homeTeamLabel: UILabel!
    
    @IBOutlet weak var awayTeamLabel: UILabel!
    
    @IBOutlet weak var noeventsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
