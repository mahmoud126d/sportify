//
//  TeamDetailsViewProtocol.swift
//  Sportify
//
//  Created by Aya Emam on 16/05/2025.
//

import Foundation

protocol TeamDetailsViewProtocol {
    func displayTeamDetails(team: [TeamDetailDto])
    func displayplayers(players: [PlayerDto])
    func displaycoach(coach: [CoachDto])
}
