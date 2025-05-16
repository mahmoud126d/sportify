//
//  LeaguesViewProtocol.swift
//  Sportify
//
//  Created by Macos on 16/05/2025.
//

import Foundation

protocol LeaguesViewProtocol{
    func displayLeagues(leagues:[LeagueDto])
    func showError(_ message: String)
}
