//
//  OnboardingContentViewController.swift
//  Sportify
//
//  Created by Aya Emam on 23/05/2025.
//

import UIKit

class OnboardingContentViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var startButton: UIButton!

    var text: String?
    var imageToShow: UIImage?
    var showGetStartedButton: Bool = false
    var onGetStarted: (() -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = text
        image.image = imageToShow
        startButton.isHidden = !showGetStartedButton
        startButton.addTarget(self, action: #selector(getStartedTapped), for: .touchUpInside)
    }

    @objc func getStartedTapped() {
           onGetStarted?()
       }

}
