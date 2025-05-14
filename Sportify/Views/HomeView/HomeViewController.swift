//
//  HomeViewController.swift
//  Sportify
//
//  Created by Macos on 14/05/2025.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup UI elements, connect outlets, and add actions here


    }
    
    override func loadView() {
            // This is the correct place to load a custom view from a nib
            if let view = UINib(nibName: "HomeViewController", bundle: nil)
                .instantiate(withOwner: self, options: nil).first as? UIView {
                self.view = view
            } else {
                // Fallback to a basic view if nib loading fails
                super.loadView()
                self.view.backgroundColor = .white
                print("Error: Failed to load HomeViewController.xib")
            }
        }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
        

}
