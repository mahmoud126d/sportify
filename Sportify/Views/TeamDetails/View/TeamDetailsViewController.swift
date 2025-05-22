//
//  TeamDetailsViewController.swift
//  Sportify
//
//  Created by Macos on 15/05/2025.
//
import UIKit
import SDWebImage

class TeamDetailsViewController: UIViewController, TeamDetailsViewProtocol {
   
    @IBOutlet weak var teamLogo: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var playersTable: UITableView!
    
    
    var teamDetailsPresenter: TeamDetailsPresenter?
    var sport: String?
    var teamKey: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        if let sport = sport, let teamKey = teamKey {
            teamDetailsPresenter = TeamDetailsPresenter(teamDetailsView: self)
                        
            teamDetailsPresenter?.fetchTeamDetails(sport: sport, teamId: teamKey)
        } else {
            return
        }
    }
    
    private func setupTableView() {
        let playerCellNib = UINib(nibName: "PlayerTableViewCell", bundle: nil)
        playersTable.register(playerCellNib, forCellReuseIdentifier: "playerCell")
        let coachCellNib = UINib(nibName: "CoachTableViewCell", bundle: nil)
        playersTable.register(coachCellNib, forCellReuseIdentifier: "coachCell")
        playersTable.delegate = self
        playersTable.dataSource = self
        
    }
    
    
    // MARK: - TeamDetailsViewProtocol Methods
    
    func displayTeamDetails(team: [TeamDetailDto]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self, let teamInfo = team.first else {
                return
            }
            
            self.teamNameLabel.text = teamInfo.teamName
            
            if let logoUrl = teamInfo.teamLogo, let url = URL(string: logoUrl) {
                self.teamLogo.sd_setImage(
                    with: url,
                    placeholderImage: UIImage(named: "placeholder"),
                    options: [.retryFailed, .refreshCached],
                    completed: nil
                )
            } else {
                self.teamLogo.image = UIImage(named: "placeholder")
            }
        }
    }
    
    func displayplayers(players: [PlayerDto]) {
        DispatchQueue.main.async { [weak self] in
            self?.playersTable.reloadData()
        }
    }

    func displaycoach(coach: [CoachDto]) {
        DispatchQueue.main.async { [weak self] in
            self?.playersTable.reloadData()
        }
    }

}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension TeamDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return teamDetailsPresenter?.coaches.count ?? 0
        case 1:
            return teamDetailsPresenter?.players.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "coachCell", for: indexPath) as? CoachTableViewCell else {
                return UITableViewCell()
            }
            let coach = teamDetailsPresenter?.coaches[indexPath.row]
            cell.coachNameLabel.text = coach?.coachName
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as? PlayerTableViewCell else {
                return UITableViewCell()
            }
            let player = teamDetailsPresenter?.players[indexPath.row]
            cell.playerName.text = player?.playerName
            cell.playerRole.text = player?.playerType ?? "Player"
            if let imageUrl = player?.playerImage{
                cell.playerImage.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(systemName: "person.circle"))
            }else{
                cell.playerImage.image = UIImage(systemName: "person.circle")
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
//            return "Coach"
            return NSLocalizedString("section_coach", comment: "Section title for coach")
        case 1:
//            return "Players"
            return NSLocalizedString("section_players", comment: "Section title for players")
        default:
            return nil
        }
    }
}
