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
//        self.title = "Leagues"
        self.title = NSLocalizedString("leagues_title", comment: "Title for leagues screen")
        let leagueTableCellnib = UINib(nibName: "LeaguesTableViewCell", bundle: nil)
        tableView.register(leagueTableCellnib, forCellReuseIdentifier: "leagueCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        leaguesPresenter = LeaguesPresenter(leaguesView: self)
        leaguesPresenter?.fetchLeagues(sport: self.sport ?? "football")
        
  
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return leaguesPresenter?.leageus.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeaguesTableViewCell
        
        cell.leagueNameLabel.text = leaguesPresenter?.leageus[indexPath.section].leagueName
        if let imageUrl = leaguesPresenter?.leageus[indexPath.section].leagueLogo {
            cell.leagueImage.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "placeholder.png"))
        } else {
            cell.leagueImage.image = UIImage(named: "football")
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2 
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.clear
        return footerView
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let leagueDetailVc = LeaguesDetailCollectionViewController()
        leagueDetailVc.leagueId = leaguesPresenter?.leageus[indexPath.section].leagueKey
        leagueDetailVc.leagueName = leaguesPresenter?.leageus[indexPath.section].leagueName ?? "No name"
        leagueDetailVc.leagueImage = leaguesPresenter?.leageus[indexPath.section].leagueLogo ?? "star"
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

