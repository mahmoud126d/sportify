//
//  LeaguesDetailsViewProtocol.swift
//  Sportify
//
//  Created by Macos on 16/05/2025.
//

import Foundation

protocol LeaguesDetailsViewProtocol{
    
    func displayUpcommingEvents(upcommingEvents:[FixtureDto])
    func displayLatestEvents(latestEvents:[FixtureDto])
    func displayTeams(teams:[TeamDto])
    
    func updateFavoriteStatus(isFavorite: Bool)
    func showError(_ message: String)
}
