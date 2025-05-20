//
//  LeaguesTableViewController.swift
//  Sportify
//
//  Created by Macos on 14/05/2025.
//

import UIKit
import SDWebImage

class LeaguesTableViewController: UITableViewController , LeaguesViewProtocol{
    
    private var leaguesPresenter:LeaguesPresenter?
    var sport:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leagueTableCellnib = UINib(nibName: "LeaguesTableViewCell", bundle: nil)
        tableView.register(leagueTableCellnib, forCellReuseIdentifier: "leagueCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        leaguesPresenter = LeaguesPresenter(leaguesView: self)
        leaguesPresenter?.fetchLeagues(sport: self.sport ?? "football")
        
  
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leaguesPresenter?.leageus.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeaguesTableViewCell
        
        cell.leagueNameLabel.text = leaguesPresenter?.leageus[indexPath.row].leagueName
        if let imageUrl = leaguesPresenter?.leageus[indexPath.row].leagueLogo{
            cell.leagueImage.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "placeholder.png"))
        }else{
            cell.leagueImage.image = UIImage(named: "football")
        }
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let leagueDetailVc = LeaguesDetailCollectionViewController()
        leagueDetailVc.leagueId = leaguesPresenter?.leageus[indexPath.row].leagueKey
        leagueDetailVc.leagueName = leaguesPresenter?.leageus[indexPath.row].leagueName ?? "No name"
        leagueDetailVc.leagueImage = leaguesPresenter?.leageus[indexPath.row].leagueLogo ?? "star"
        leagueDetailVc.sport = sport
        navigationController?.pushViewController(leagueDetailVc, animated: true)
    }
    
    func displayLeagues() {
        tableView.reloadData()
    }
    
    func showError(_ message: String) {
        print(message)
    }
}

