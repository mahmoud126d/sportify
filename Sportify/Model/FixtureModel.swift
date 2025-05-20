//
//  FixtureModel.swift
//  Sportify
//
//  Created by Macos on 16/05/2025.
//

import Foundation

struct FixtureDto : Decodable{
    
    let eventDate:String?
    let eventTime:String?
    let eventHomeTeam:String?
    let eventAwayTeam:String?
    let eventFinalResult:String?
    let homeTeamLogo:String?
    let awayTeamLogo:String?
    
    
    enum CodingKeys: String, CodingKey {
        case eventDate = "event_date"
        case eventTime = "event_time"
        case eventHomeTeam = "event_home_team"
        case eventAwayTeam = "event_away_team"
        case eventFinalResult = "event_final_result"
        case homeTeamLogo = "home_team_logo"
        case awayTeamLogo = "away_team_logo"
    }
    
    
    
}
