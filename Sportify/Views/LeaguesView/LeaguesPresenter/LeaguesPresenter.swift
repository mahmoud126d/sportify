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
            leaguesView.displayLeagues()
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
    
    
    
    func fetchLeagues(sport:String) {
        
        
        networkManger.fetchData(
            sport: sport,
            requestType : ApiCallType.leagues.rawValue, 
            leagueId: 0
        ) { (result: Result<[LeagueDto], Error>) in
            switch result {
            case .success(let leagues):
                self._leagues = leagues
            case .failure(let error):
                print("Failed to fetch leagues: \(error.localizedDescription)")
                
            }
        }
    }

}
