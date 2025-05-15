//
//  TeamDetailsViewController.swift
//  Sportify
//
//  Created by Macos on 15/05/2025.
//

import UIKit

class TeamDetailsViewController: UIViewController  {

    @IBOutlet weak var playersTable: UITableView!
    let coaches = ["klob","Pep"]
    let players = ["messi","ronaldo","salah"]
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTable()

    }
    
    
    private func setUpTable(){
        let playerCellNib = UINib(nibName: "PlayerTableViewCell", bundle: nil)
        playersTable.register(playerCellNib, forCellReuseIdentifier: "playerCell")
        
        playersTable.delegate = self
        playersTable.dataSource = self
    }

}

extension TeamDetailsViewController:UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return coaches.count
        case 1:
            return players.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayerTableViewCell
        
        switch indexPath.section {
        case 0:
            cell.playerName.text = coaches[indexPath.row]
            cell.playerImage.image = UIImage(named: "ronaldo")
        case 1:
            cell.playerName.text = players[indexPath.row]
            cell.playerImage.image = UIImage(named: "ronaldo")
        default:
            return cell
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return "Coaches"
        case 1:
            return "Players"
        default:
            return ""
        }
    }
}
