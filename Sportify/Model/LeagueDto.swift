//
//  LeagueDto.swift
//  Sportify
//
//  Created by Macos on 16/05/2025.
//

import Foundation

struct LeagueDto : Codable{
    
    let LeagueKey : Int?
    let leagueName : String?
    let leagueLogo : String?
    
    enum CodingKeys: String, CodingKey {
        case LeagueKey = "league_key"
        case leagueName = "league_name"
        case leagueLogo = "league_logo"
    }
}

struct LeagueResponse : Codable{
    let success:Int?
    let result:[LeagueDto]?
}
