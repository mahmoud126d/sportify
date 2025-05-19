//
//  TeamDetails.swift
//  Sportify
//
//  Created by Aya Emam on 17/05/2025.
//

import Foundation

struct TeamDetailResponse: Codable {
    let success: Int?
    let result: [TeamDetailDto]?
}

struct TeamDetailDto: Codable {
    let teamKey: Int?
    let teamName: String?
    let teamLogo: String?
    let players: [PlayerDto]?
    let coaches: [CoachDto]?

    enum CodingKeys: String, CodingKey {
        case teamKey = "team_key"
        case teamName = "team_name"
        case teamLogo = "team_logo"
        case players
        case coaches
    }
}

struct PlayerDto: Codable {
    let playerKey: Int?
    let playerName: String?
    let playerType: String?
    let playerImage: String?

    enum CodingKeys: String, CodingKey {
        case playerKey = "player_key"
        case playerName = "player_name"
        case playerType = "player_type"
        case playerImage = "player_image"
    }
}


struct CoachDto: Codable {
    let coachName: String?
    let coachCountry: String?
    let coachAge: String?
    
    enum CodingKeys: String, CodingKey {
        case coachName = "coach_name"
        case coachCountry = "coach_country"
        case coachAge = "coach_age"

    }
}

