//
//  NetworkMangerProtocol.swift
//  Sportify
//
//  Created by Macos on 16/05/2025.
//

import Foundation
import Alamofire
protocol NetworkMangerProtocol{
    
    typealias LeagueComplition = (Result<[LeagueDto],Error>) -> Void
    typealias UpcommingEventsComplition = (Result<[FixtureDto],Error>) -> Void
    typealias UpcommingLatestComplition = (Result<[FixtureDto],Error>) -> Void
    typealias teamsComplition = (Result<[TeamDto],Error>) -> Void
    typealias TeamDetailsCompletion = (Result<[TeamDetailDto], Error>) -> Void
    
    func fetchLeagues(sport:String,completion: @escaping LeagueComplition)
    
    func fetchUpCommingEvents(sport:String,leagueId:Int,completion: @escaping UpcommingEventsComplition)
    
    func fetchLatestEvents(sport:String,leagueId:Int,completion: @escaping UpcommingEventsComplition)
    
    func fetchTeams(sport:String,leagueId:Int,completion: @escaping teamsComplition)
    
    func fetchTeamDetails(sport: String, teamId: Int, completion: @escaping TeamDetailsCompletion)

    func fetchData<T : Decodable>(
        from url : String,
        parameters : Parameters?,
        complition : @escaping (Result<T,Error>)->Void
    )
}
