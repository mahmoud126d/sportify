//
//  FixtureModel.swift
//  Sportify
//
//  Created by Macos on 16/05/2025.
//

import Foundation

class FixtureDto : Decodable{
    
    let eventDate:String?
    let eventTime:String?
    let eventHome:String?
    let eventAway:String?
    let eventFinalResult:String?
    let homeLogo:String?
    let awayLogo:String?
    init(eventDate: String?, eventTime: String?, eventHome: String?, eventAway: String?, eventFinalResult: String?, homeLogo: String?, awayLogo: String?) {
        self.eventDate = eventDate
        self.eventTime = eventTime
        self.eventHome = eventHome
        self.eventAway = eventAway
        self.eventFinalResult = eventFinalResult
        self.homeLogo = homeLogo
        self.awayLogo = awayLogo
    }
}
