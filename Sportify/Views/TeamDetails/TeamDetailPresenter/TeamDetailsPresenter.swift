//
//  TeamDetailsPresenter.swift
//  Sportify
//
//  Created by Aya Emam on 16/05/2025.
//
import Foundation


class TeamDetailsPresenter {
    private let teamDetailsView: TeamDetailsViewProtocol
    private let networkManager: NetworkMangerProtocol
    
    private var _teamDetails: [TeamDetailDto] = [] {
        didSet {
            teamDetailsView.displayTeamDetails(team: teamDetails)
        }
    }
    var teamDetails: [TeamDetailDto] {
        get {
            return _teamDetails
        }
    }

    private var _coaches: [CoachDto] = [] {
        didSet {
            teamDetailsView.displaycoach(coach: coaches)
        }
    }
    var coaches: [CoachDto] {
        get {
            return _coaches
        }
    }

    private var _players: [PlayerDto] = [] {
        didSet {
            teamDetailsView.displayplayers(players: players)
        }
    }
    var players: [PlayerDto] {
        get {
            return _players
        }
    }

    init(teamDetailsView: TeamDetailsViewProtocol, networkManager: NetworkMangerProtocol = NetworkManger.shared) {
        self.teamDetailsView = teamDetailsView
        self.networkManager = networkManager
    }
    
    func fetchTeamDetails(sport: String, teamId: Int) {
        let requestType = ApiCallType.teamsDetails.rawValue
        networkManager.fetchData(
            sport: sport,
            requestType: requestType,
            leagueId: teamId
        
        ) { (result: Result<[TeamDetailDto], Error>) in
            switch result {
            case .success(let teamDetails):
                self._teamDetails = teamDetails
                self._players = teamDetails.first?.players ?? []
                self._coaches = teamDetails.first?.coaches ?? []
                //print(teamsDetails)
            case .failure(let error):
                print("Failed to fetch leagues: \(error.localizedDescription)")
                
            }
        }
    }
}


