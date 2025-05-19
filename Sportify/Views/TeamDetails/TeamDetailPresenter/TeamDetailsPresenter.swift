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
        networkManager.fetchTeamDetails(sport: sport, teamId: teamId) { [weak self] result in
            switch result {
            case .success(let teamDetails):
                guard let team = teamDetails.first else {
                    return
                }
                self?._teamDetails = [team]
                self?._players = team.players ?? []
                self?._coaches = team.coaches ?? []
            case .failure(let error):
                print("Failed to fetch team details: \(error.localizedDescription)")
            }
        }
    }
}


