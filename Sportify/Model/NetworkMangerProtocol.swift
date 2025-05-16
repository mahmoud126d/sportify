//
//  NetworkMangerProtocol.swift
//  Sportify
//
//  Created by Macos on 16/05/2025.
//

import Foundation

protocol NetworkMangerProtocol{
    
    typealias LeagueComplition = (Result<[LeagueDto],Error>) -> Void
    
    
    func fetchLeagues(sport:String,completion: @escaping LeagueComplition)
    
    
    
}
