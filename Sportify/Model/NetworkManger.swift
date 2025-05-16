//
//  NetworkManger.swift
//  Sportify
//
//  Created by Macos on 16/05/2025.
//

import Foundation
import Alamofire

class NetworkManger : NetworkMangerProtocol{
    
    static var shared:NetworkManger = NetworkManger()
    
    private init(){}
    
    func fetchLeagues(sport: String, completion: @escaping (Result<[LeagueDto], Error>) -> Void) {
        AF.request("https://apiv2.allsportsapi.com/\(sport)/?met=Leagues&APIkey=e99630517917638f1996e33140a36e0e599db1539710fd3e53a2ca3175417718")
            .validate()
            .responseDecodable(of: LeagueResponse.self) { response in
                switch response.result {
                case .success(let data):
                    guard let result = data.result else {
                        return
                    }
                    completion(.success(result))
                case .failure(let error):
                    completion(.failure(error))
                }
                
            }
        
    }
    func fetchUpCommingEvents(sport: String, completion: @escaping UpcommingEventsComplition) {
        AF.request("https://apiv2.allsportsapi.com/(sport)/?met=Fixtures&APIkey=e99630517917638f1996e33140a36e0e599db1539710fd3e53a2ca3175417718&from=2025-05-15&to=2025-05-30")
            .validate()
            .responseDecodable(of: FixtureResponse.self) { response in
                switch response.result {
                case .success(let data):
                    guard let result = data.result else {
                        return
                    }
                    completion(.success(result))
                case .failure(let error):
                    completion(.failure(error))
                }
                
            }
    }
}
