//
//  LeagueDetailsPresenter.swift
//  Sportify
//
//  Created by Macos on 16/05/2025.
//

import Foundation

class LeagueDetailsPresenter{
    
    private let leagueDetailsView:LeaguesDetailsViewProtocol
    private let networkManger:NetworkMangerProtocol
    let coreDataManager: CoreDataManager
    private var _sport: String?
    
    private var _upcommingEvents : [FixtureDto] = [] {
        didSet{
            leagueDetailsView.displayUpcommingEvents(upcommingEvents: upcommingEvents)
        }
    }
    
    var upcommingEvents:[FixtureDto] {
        get{
            return _upcommingEvents
        }
    }
    
    private var _latestEvents : [FixtureDto] = [] {
        didSet{
            leagueDetailsView.displayLatestEvents(latestEvents: latestEvents)
        }
    }
    
    var latestEvents:[FixtureDto] {
        get{
            return _latestEvents
        }
    }
    
    private var _teams : [TeamDto] = [] {
        didSet{
            leagueDetailsView.displayTeams(teams: teams)
        }
    }
    
    var teams:[TeamDto] {
        get{
            return _teams
        }
    }
    private var _currentLeague: LeagueDto?
    var currentLeague: LeagueDto? {
        get{
            return _currentLeague
        }
    }
    init(leagueDetailsView: LeaguesDetailsViewProtocol, networkManger: NetworkMangerProtocol = NetworkManger.shared , coreDataManager: CoreDataManager = CoreDataManager.shared ){
        self.leagueDetailsView = leagueDetailsView
        self.networkManger = networkManger
        self.coreDataManager = coreDataManager
    }
    func fetchUpcommingEvents(sport:String,leagueId:Int){
        networkManger.fetchUpCommingEvents(sport: sport,leagueId:leagueId){[weak self]
            result in
            switch result{
            case .success(let upcommingEvents):
                self?._upcommingEvents = upcommingEvents
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchLatestEvents(sport:String,leagueId:Int){
        networkManger.fetchLatestEvents(sport: sport,leagueId:leagueId){[weak self]
            result in
            switch result{
            case .success(let latestEvents):
                self?._latestEvents = latestEvents
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchTeams(sport:String,leagueId:Int){
        networkManger.fetchTeams(sport: sport,leagueId:leagueId){[weak self]
            result in
            switch result{
            case .success(let teams):
                self?._teams = teams
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func setCurrentLeague(league: LeagueDto, sport: String) {
            _currentLeague = league
            _sport = sport
            checkFavoriteStatus()
        }
    func toggleFavoriteStatus(sport: String, leagueId: Int) {
             
            guard let league = _currentLeague, (leagueId != 0) else {
                print(sport,leagueId)
                return
            }
        let validLeagueName = _currentLeague?.leagueName ?? "League \(leagueId)"
            let leagueToSave = LeagueDto(
                leagueKey: league.leagueKey,
                leagueName: validLeagueName,
                leagueLogo: league.leagueLogo
            )
            
            
            if coreDataManager.isLeagueInFavorites(leagueId: leagueId) {
                if coreDataManager.removeLeagueFromFavorites(leagueId: leagueId) {
                    leagueDetailsView.updateFavoriteStatus(isFavorite: false)
                    print("removed")
                } else {
                    leagueDetailsView.showError("Failed to remove league from favorites")
                }
            } else {
                if coreDataManager.saveLeagueToFavorites(league: leagueToSave, sport: _sport ?? sport) {
                    leagueDetailsView.updateFavoriteStatus(isFavorite: true)
                    print("added")
                } else {
                    leagueDetailsView.showError("Failed to add league to favorites")
                }
            }
        }
        
        func checkFavoriteStatus() {
            guard let leagueId = _currentLeague?.leagueKey else {
                leagueDetailsView.updateFavoriteStatus(isFavorite: false)
                return
            }
            
            let isFavorite = coreDataManager.isLeagueInFavorites(leagueId: leagueId)
            leagueDetailsView.updateFavoriteStatus(isFavorite: isFavorite)
        }
    }
