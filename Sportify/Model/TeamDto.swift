//
//  TeamDto.swift
//  Sportify
//
//  Created by Macos on 16/05/2025.
//

import Foundation

struct TeamDto : Codable{
    let teamKey:Int?
    let teamName:String?
    let teamLogo:String?
    
    enum CodingKeys: String, CodingKey {
        case teamKey = "team_key"
        case teamName = "team_name"
        case teamLogo = "team_logo"
    }
}

struct TeamResponse : Codable{
    let success:Int?
    let result:[TeamDto]?
}
