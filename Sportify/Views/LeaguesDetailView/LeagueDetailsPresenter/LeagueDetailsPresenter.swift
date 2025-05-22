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
            leagueDetailsView.displayUpcommingEvents()
        }
    }
    
    var upcommingEvents:[FixtureDto] {
        get{
            return _upcommingEvents
        }
    }
    
    private var _latestEvents : [FixtureDto] = [] {
        didSet{
            leagueDetailsView.displayLatestEvents()
        }
    }
    
    var latestEvents:[FixtureDto] {
        get{
            return _latestEvents
        }
    }
    
    private var _teams : [TeamDto] = [] {
        didSet{
            leagueDetailsView.displayTeams()
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
    
    func fetchEvents(sport:String,leagueId:Int){
        
        if sport == "tennis"{
            let requestType = ApiCallType.fixture.rawValue
            networkManger.fetchData(
                sport: sport,
                requestType: requestType,
                leagueId: 0
            ) { (result: Result<[TennisFixtureDto], Error>) in
                switch result {
                case .success(let events):
                    print(events.count)
                    let latestTennisEvents = events.filter { event in
                        guard let finalResult = event.eventFinalResult else { return false }
                        return finalResult != "-"
                    }
                    let upCommingTennisEvents = events.filter { event in
                        guard let finalResult = event.eventFinalResult else { return false }
                        return finalResult == "-"
                    }
                    let latestEvents = Array.toFixtureModels(latestTennisEvents)
                    let upCommingEvents = Array.toFixtureModels(upCommingTennisEvents)
                    self._latestEvents = latestEvents()
                    self._upcommingEvents = upCommingEvents()
                case .failure(let error):
                    print("Failed to fetch leagues: \(error.localizedDescription)")
                    
                }
            }
        }else{
            let requestType = ApiCallType.fixture.rawValue
            
            
            networkManger.fetchData(
                sport: sport,
                requestType: requestType,
                leagueId: leagueId
            ) { (result: Result<[CommonFixtureDto], Error>) in
                switch result {
                case .success(let events):
                    print(events.count)
                    let latestCommonEvents = events.filter { event in
                        guard let finalResult = event.eventFinalResult else { return false }
                        return finalResult != "-"
                    }
                    let upCommingCommonEvents = events.filter { event in
                        guard let finalResult = event.eventFinalResult else { return false }
                        return finalResult == "-"
                    }
                    let latestEvents = Array.toFixtureModels(latestCommonEvents)
                    let upCommingEvents = Array.toFixtureModels(upCommingCommonEvents)
                    self._latestEvents = latestEvents()
                    self._upcommingEvents = upCommingEvents()
                    
                case .failure(let error):
                    print("Failed to fetch leagues: \(error.localizedDescription)")
                    
                }
            }
        }
        
        
        
        
    }
    func fetchEvents(sport:String,leagueName:String){
        
    }
        func fetchTeams(sport:String,leagueId:Int
        ){
            
            let requestType = ApiCallType.teams.rawValue
            networkManger.fetchData(
                sport: sport,
                requestType:requestType,
                leagueId:leagueId
            ) { (result: Result<[TeamDto], Error>) in
                switch result {
                case .success(let teams):
                    self._teams = teams
                case .failure(let error):
                    print("Failed to fetch leagues: \(error.localizedDescription)")
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
                    
                } else {
                    leagueDetailsView.showError("Failed to remove league from favorites")
                }
            } else {
                if coreDataManager.saveLeagueToFavorites(league: leagueToSave, sport: _sport ?? sport) {
                    leagueDetailsView.updateFavoriteStatus(isFavorite: true)
                    
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
    

