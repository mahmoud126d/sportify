//
//  HomeViewController.swift
//  Sportify
//
//  Created by Macos on 14/05/2025.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var sportsCollectionView: UICollectionView!
    private let sports = ["Football","Tennis","Cricket",
    "Basketball"]
    override func viewDidLoad() {
        super.viewDidLoad()
        let sportCellNib = UINib(nibName: "SportViewCell", bundle: nil)
        sportsCollectionView.register(sportCellNib, forCellWithReuseIdentifier: "sportCell")
        

        self.sportsCollectionView.dataSource = self
        self.sportsCollectionView.delegate = self
        
        sportsCollectionView.frame = view.bounds
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
        return sports.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sportCell", for: indexPath) as! SportViewCell
        
        cell.sportLabel.text = sports[indexPath.row]
        cell.sportImageView.image = UIImage(named: sports[indexPath.row].lowercased())

        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth : CGFloat = sportsCollectionView.frame.width / 2 - 8
        let itemHeight : CGFloat = sportsCollectionView.frame.height / 2
        return CGSize(width: itemWidth, height: itemHeight)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let leagueVc = LeaguesTableViewController()
        leagueVc.sport = sports[indexPath.row].lowercased()
        navigationController?.pushViewController(leagueVc, animated: true)
    }
    
}
