//
//  TennisFixtureDto.swift
//  Sportify
//
//  Created by Macos on 21/05/2025.
//

import Foundation

struct TennisFixtureDto : Decodable{
    let eventDate:String?
    let eventTime:String?
    let eventFirstPlayer:String?
    let eventSecondPlayer:String?
    let eventFinalResult:String?
    let eventFirstPlayerLogo:String?
    let eventSecondPlayerLogo:String?
    
    
    enum CodingKeys: String, CodingKey {
        case eventDate = "event_date"
        case eventTime = "event_time"
        case eventFirstPlayer = "event_first_player"
        case eventSecondPlayer = "event_second_player"
        case eventFinalResult = "event_final_result"
        case eventFirstPlayerLogo = "event_first_player_logo"
        case eventSecondPlayerLogo = "event_second_player_logo"
    }
}

extension Array where Element == TennisFixtureDto {
    func toFixtureModels() -> [FixtureDto] {
        return self.map { tennisFixture in
            FixtureDto(
                eventDate: tennisFixture.eventDate,
                eventTime: tennisFixture.eventTime,
                eventHome: tennisFixture.eventFirstPlayer,
                eventAway: tennisFixture.eventSecondPlayer,
                eventFinalResult: tennisFixture.eventFinalResult,
                homeLogo: tennisFixture.eventFirstPlayerLogo,
                awayLogo: tennisFixture.eventSecondPlayerLogo
            )
        }
    }
}
