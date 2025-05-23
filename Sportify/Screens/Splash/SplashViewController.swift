//
//  SplashViewController.swift
//  Sportify
//
//  Created by Aya Emam on 21/05/2025.
//

import UIKit
import WebKit
import SDWebImage

class SplashViewController: UIViewController {
    @IBOutlet weak var gifImageView: SDAnimatedImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let gifPath = Bundle.main.path(forResource: "splash", ofType: "gif") {
            let gifURL = URL(fileURLWithPath: gifPath)
            gifImageView.sd_setImage(with: gifURL)
        }
    }
}
