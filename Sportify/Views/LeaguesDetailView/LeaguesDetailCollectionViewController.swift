//
//  LeaguesDetailCollectionViewController.swift
//  Sportify
//
//  Created by Aya Emam on 15/05/2025.
//

import UIKit


class LeaguesDetailCollectionViewController: UICollectionViewController , UICollectionViewDelegateFlowLayout,LeaguesDetailsViewProtocol {
    
    var leagueDetailsPresenter:LeagueDetailsPresenter?
    var sport , leagueName , leagueImage :String?
    var leagueId:Int?
    private var favoriteButton: UIBarButtonItem!
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCells()
        setUpLayout()
        setUpNavigationIcon()
        setUpPresenter()
    }
    
    private func setUpCells(){
        let upcomingCellnib = UINib(nibName: "UpcomingEventCollectionViewCell", bundle: nil)
        collectionView.register(upcomingCellnib, forCellWithReuseIdentifier: "upcomingCell")
        let latestEventCellnib = UINib(nibName: "LatestEventCollectionViewCell", bundle: nil)
        collectionView.register(latestEventCellnib, forCellWithReuseIdentifier: "latestEventCell")
        let teamCellnib = UINib(nibName: "TeamsCollectionViewCell", bundle: nil)
        collectionView.register(teamCellnib, forCellWithReuseIdentifier: "teamsCell")
    }
    private func setUpLayout(){
        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment in
            if sectionIndex == 0 {
                return self.upcomingEventsSection()
            } else if sectionIndex == 1{
                return self.latestEventSection()
            }else {
                return self.teamsSection()
            }
        }
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    private func setUpNavigationIcon(){
        favoriteButton = UIBarButtonItem(
            image: UIImage(systemName: "heart"),
            style: .plain,
            target: self,
            action: #selector(favoriteButtonTapped)
        )
        navigationItem.rightBarButtonItem = favoriteButton
    }
    private func setUpPresenter(){
        leagueDetailsPresenter = LeagueDetailsPresenter(leagueDetailsView: self)
        var league = leagueDetailsPresenter?.currentLeague
        if league == nil && leagueId != nil {
            league = LeagueDto(leagueKey: leagueId, leagueName: leagueName, leagueLogo: leagueImage)
        }
        if let currentLeague = league, let sportType = sport {
            leagueDetailsPresenter?.setCurrentLeague(league: currentLeague, sport: sportType)
            print(currentLeague)
        }
        
        leagueDetailsPresenter?.fetchUpcommingEvents(sport: sport ?? "football", leagueId: leagueId ?? 255)
        leagueDetailsPresenter?.fetchLatestEvents(sport: sport ?? "football", leagueId: leagueId ?? 255)
        leagueDetailsPresenter?.fetchTeams(sport: sport ?? "football", leagueId: leagueId ?? 255)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return leagueDetailsPresenter?.upcommingEvents.count ?? 0
        case 1:
            return leagueDetailsPresenter?.latestEvents.count ?? 0
        case 2:
            return leagueDetailsPresenter?.teams.count ?? 0
        default:
            return 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "latestEventCell", for: indexPath) as! LatestEventCollectionViewCell
            let upcommingEvent = leagueDetailsPresenter?.upcommingEvents[indexPath.row]
            
            setUpCommingEventsCell(upcommingEvent: upcommingEvent,cell: cell)
            
            return cell

        }else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "latestEventCell", for: indexPath) as! LatestEventCollectionViewCell
            
            let latestEvent = leagueDetailsPresenter?.latestEvents[indexPath.row]
            
            setLatestEventsCell(latestEvent: latestEvent, cell: cell)
            
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamsCell", for: indexPath) as! TeamsCollectionViewCell
            
            cell.teamName.text = leagueDetailsPresenter?.teams[indexPath.row].teamName
            if let imageUrl = leagueDetailsPresenter?.teams[indexPath.row].teamLogo {
                cell.teamImage.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "placeholder.png"))
            }else{
                cell.teamImage.image = UIImage(named: "placeholder.png")
            }
            
            return cell
        }
    }
    private func setUpCommingEventsCell(upcommingEvent:FixtureDto?,cell:LatestEventCollectionViewCell){
        cell.homeTeamLabel.text = upcommingEvent?.eventHomeTeam
        cell.awayTeamLabel.text = upcommingEvent?.eventAwayTeam
        cell.dateLabel.text = upcommingEvent?.eventDate
        cell.timeLabel.text = upcommingEvent?.eventTime
        
        if let imageUrl = upcommingEvent?.homeTeamLogo {
            cell.homeTeamImage.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "placeholder.png"))
        }else{
            cell.homeTeamImage.image = UIImage(named: "placeholder.png")
        }
        
        if let imageUrl = upcommingEvent?.awayTeamLogo {
            cell.awayTeamImage.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "placeholder.png"))
        }else{
            cell.homeTeamImage.image = UIImage(named: "placeholder.png")
        }
    }
    
    private func setLatestEventsCell(latestEvent:FixtureDto?,cell:LatestEventCollectionViewCell){
        cell.homeTeamLabel.text = latestEvent?.eventHomeTeam
        cell.awayTeamLabel.text = latestEvent?.eventAwayTeam
        cell.dateLabel.text = latestEvent?.eventDate
        cell.timeLabel.text = latestEvent?.eventTime
        cell.scoreLabel.text = latestEvent?.eventFinalResult
        if let imageUrl = latestEvent?.homeTeamLogo {
            cell.homeTeamImage.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "placeholder.png"))
        }else{
            cell.homeTeamImage.image = UIImage(named: "placeholder.png")
        }
        if let imageUrl = latestEvent?.awayTeamLogo {
            cell.awayTeamImage.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "placeholder.png"))
        }else{
            cell.homeTeamImage.image = UIImage(named: "placeholder.png")
        }
    }
    
    
    func upcomingEventsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 32)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 50, leading: 16, bottom: 16, trailing: 0)
        return section
    }
    func latestEventSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.9))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 50, leading: 16, bottom: 16, trailing: 16)
        return section
    }
    func teamsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 32)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 50, leading: 16, bottom: 16, trailing: 0)
        
        return section
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            let teamVc = TeamDetailsViewController()
            teamVc.teamKey = leagueDetailsPresenter?.teams[indexPath.row].teamKey
            teamVc.sport = self.sport
            navigationController?.pushViewController(teamVc, animated: true)
        }
    }
    
    @objc func favoriteButtonTapped() {
            if let sportType = sport, let id = leagueId {
                leagueDetailsPresenter?.toggleFavoriteStatus(sport: sportType, leagueId: id)
            } else {
                showError("Missing sport or league ID")
            }
        }
        
        func updateFavoriteStatus(isFavorite: Bool) {
            let heartImage = isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
            favoriteButton.image = heartImage
        }
        
        func showError(_ message: String) {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
        
    func setCurrentLeague(_ league: LeagueDto) {
            if let sportType = self.sport {
                leagueDetailsPresenter?.setCurrentLeague(league: league, sport: sportType)
            }
        }

    func displayUpcommingEvents(upcommingEvents: [FixtureDto]) {
        
        collectionView.reloadData()
    }
    
    func displayLatestEvents(latestEvents: [FixtureDto]) {
              
        collectionView.reloadData()
    }
    func displayTeams(teams: [TeamDto]) {
        collectionView.reloadData()
    }
}
