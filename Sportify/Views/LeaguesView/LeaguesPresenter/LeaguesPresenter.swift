//
//  LeaguesPresenter.swift
//  Sportify
//
//  Created by Macos on 16/05/2025.
//

import Foundation

class LeaguesPresenter{
    
    let leaguesView:LeaguesViewProtocol
    let networkManger:NetworkMangerProtocol
    
    private var _leagues:[LeagueDto] = [] {
        didSet{
            leaguesView.displayLeagues(leagues: self.leageus)
        }
    }
    
     var leageus:[LeagueDto] {
        get{
            return _leagues
        }
    }
    
    init(leaguesView: LeaguesViewProtocol,networkManger:NetworkMangerProtocol = NetworkManger.shared) {
        self.leaguesView = leaguesView
        self.networkManger = networkManger
    }
    
    func fetchLeagues(sport: String) {
        networkManger.fetchLeagues(sport: sport){[weak self]
            result in
            switch result{
            case .success(let leagues):
                self?._leagues = leagues
                //self?.leaguesView.displayLeagues(leagues: leagues)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}
