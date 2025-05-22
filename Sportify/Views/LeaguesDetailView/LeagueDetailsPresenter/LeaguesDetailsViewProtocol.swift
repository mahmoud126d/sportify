//
//  LeaguesDetailsViewProtocol.swift
//  Sportify
//
//  Created by Macos on 16/05/2025.
//

import Foundation

protocol LeaguesDetailsViewProtocol{
    
    func displayUpcommingEvents()
    func displayLatestEvents()
    func displayTeams()
    
    func updateFavoriteStatus(isFavorite: Bool)
    func showError(_ message: String)
}
