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
    
    init(leagueDetailsView: LeaguesDetailsViewProtocol, networkManger: NetworkMangerProtocol = NetworkManger.shared) {
        self.leagueDetailsView = leagueDetailsView
        self.networkManger = networkManger
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
}
