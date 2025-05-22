//
//  LeaguesDetailCollectionViewController.swift
//  Sportify
//
//  Created by Aya Emam on 15/05/2025.
//

import UIKit
import Lottie

class LeaguesDetailCollectionViewController: UICollectionViewController , UICollectionViewDelegateFlowLayout,LeaguesDetailsViewProtocol {
    
    var leagueDetailsPresenter:LeagueDetailsPresenter?
    var sport , leagueName , leagueImage :String?
    var leagueId:Int?
    private var favoriteButton: UIBarButtonItem!
    private var animationView: LottieAnimationView?
    
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
        displayAnimation()
    }
    
    private func setUpCells(){
        let upcomingCellnib = UINib(nibName: "UpcomingEventCollectionViewCell", bundle: nil)
        collectionView.register(upcomingCellnib, forCellWithReuseIdentifier: "upcomingCell")
        let latestEventCellnib = UINib(nibName: "LatestEventCollectionViewCell", bundle: nil)
        collectionView.register(latestEventCellnib, forCellWithReuseIdentifier: "latestEventCell")
        let teamCellnib = UINib(nibName: "TeamsCollectionViewCell", bundle: nil)
        collectionView.register(teamCellnib, forCellWithReuseIdentifier: "teamsCell")
        let headerNib = UINib(nibName: "SectionHeaderView", bundle: nil)
        collectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeaderView")
    }
    private func setUpLayout(){
        self.title = leagueName
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
        
        
        leagueDetailsPresenter?.fetchEvents(sport: self.sport ?? "football", leagueId: leagueId ?? 152)
        
        if sport != "tennis"{
            leagueDetailsPresenter?.fetchTeams(sport: sport ?? "football", leagueId: leagueId ?? 255)
        }
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcomingCell", for: indexPath) as! UpcomingEventCollectionViewCell
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
            
//            cell.teamName.text = leagueDetailsPresenter?.teams[indexPath.row].teamName
            if let imageUrl = leagueDetailsPresenter?.teams[indexPath.row].teamLogo {
                cell.teamImage.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "placeholder.png"))
            }else{
                cell.teamImage.image = UIImage(named: "placeholder.png")
            }
            
            return cell
        }
    }
    private func setUpCommingEventsCell(upcommingEvent:FixtureDto?,cell:UpcomingEventCollectionViewCell){
        cell.homeTeamLabel.text = upcommingEvent?.eventHome
        cell.awayTeamLabel.text = upcommingEvent?.eventAway
        cell.dateLabel.text = upcommingEvent?.eventDate
        cell.timeLabel.text = upcommingEvent?.eventTime
        
        if let imageUrl = upcommingEvent?.homeLogo {
            cell.homeTeamImage.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "placeholder.png"))
        }else{
            cell.homeTeamImage.image = UIImage(named: "placeholder.png")
        }
        
        if let imageUrl = upcommingEvent?.awayLogo {
            cell.awayTeamImage.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "placeholder.png"))
        }else{
            cell.homeTeamImage.image = UIImage(named: "placeholder.png")
        }
    }
    
    private func setLatestEventsCell(latestEvent:FixtureDto?,cell:LatestEventCollectionViewCell){
        cell.homeTeamLabel.text = latestEvent?.eventHome
        cell.awayTeamLabel.text = latestEvent?.eventAway
        cell.dateLabel.text = latestEvent?.eventDate
        cell.timeLabel.text = latestEvent?.eventTime
        cell.scoreLabel.text = latestEvent?.eventFinalResult
        if let imageUrl = latestEvent?.homeLogo {
            cell.homeTeamImage.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "placeholder.png"))
        }else{
            cell.homeTeamImage.image = UIImage(named: "placeholder.png")
        }
        if let imageUrl = latestEvent?.awayLogo {
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
        section.contentInsets = .init(top: 10, leading: 16, bottom: 16, trailing: 16)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                    heightDimension: .absolute(40))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .topLeading)
            section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    func latestEventSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.9))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 10, leading: 16, bottom: 16, trailing: 16)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                    heightDimension: .absolute(40))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top)
            section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    func teamsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(153), heightDimension: .absolute(140))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 10, leading: 16, bottom: 16, trailing: 0)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                    heightDimension: .absolute(40))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top)
            section.boundarySupplementaryItems = [sectionHeader]
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
            favoriteButton.tintColor = isFavorite ? .systemRed : .label 
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

    func displayUpcommingEvents() {
        hideAnimation()
        collectionView.reloadData()
    }
    
    func displayLatestEvents() {
        hideAnimation()
        collectionView.reloadData()
    }
    func displayTeams() {
        hideAnimation()
        collectionView.reloadData()
    }
    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "SectionHeaderView",
                for: indexPath) as! SectionHeaderView
            
            switch indexPath.section {
            case 0:
                header.titleLabel.text = NSLocalizedString("upcoming_events", comment: "Section header for upcoming events")
            case 1:
                header.titleLabel.text = NSLocalizedString("latest_events", comment: "Section header for latest events")
            case 2:
                header.titleLabel.text = NSLocalizedString("teams", comment: "Section header for teams")
            default:
                header.titleLabel.text = ""
            }
            
            return header
        }
        return UICollectionReusableView()
    }

    private func displayAnimation(){
        animationView = LottieAnimationView(name: "animation")

               guard let animationView = animationView else { return }
               animationView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
               animationView.center = view.center
               animationView.contentMode = .scaleAspectFit
               animationView.loopMode = .loop
               animationView.play()

               view.addSubview(animationView)
    }
    private func hideAnimation(){
        animationView?.removeFromSuperview()
    }
}
