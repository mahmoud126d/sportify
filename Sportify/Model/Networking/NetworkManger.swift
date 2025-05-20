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
    
    func fetchData<T : Decodable>(
        sport:String,
        requestType:String,
        leagueId:Int = 0,
        complition : @escaping (Result<T,Error>)->Void
    ){
        let endpoint = ApiEndpoint(sport: sport)?.url
        var parameters: Parameters?
        switch requestType {
        case "Leagues":
            parameters = [
                "APIkey": ApiKey.apiKey.rawValue,
                "met": ApiCallType.leagues.rawValue,
            ]
            
        case "Teams":
            parameters = [
                "APIkey": ApiKey.apiKey.rawValue,
                "met" : ApiCallType.teams.rawValue,
                "leagueId" : leagueId
            ]
            
        case "Fixtures":
            parameters = [
                "APIkey": ApiKey.apiKey.rawValue,
                "met" : ApiCallType.fixture.rawValue,
                "leagueId" : leagueId,
                "from" : DateManger.getPreviousWeekDate(),
                "to" : DateManger.getNextWeekDate()
            ]
        case "TeamsDetails":
            parameters = [
                "APIkey": ApiKey.apiKey.rawValue,
                "met" : ApiCallType.teams.rawValue,
                "teamId" : leagueId,
            ]
        default:
            print()
        }
        
        AF.request(endpoint!,parameters: parameters!)
            .validate()
            .responseDecodable(of:ApiResponse<T>.self){
                response in
                switch response.result{
                case .success(let apiReponse):
                    print(apiReponse.result)
                    complition(.success(apiReponse.result))
                case .failure(let error):
                    print(error)
                }
            }
        
        
    }
    
    
}
struct  ApiResponse<T : Decodable> : Decodable{
    let success:Int?
    let result : T
}

enum ApiEndpoint: String {
    case football
    case tennis
    case cricket
    case basketball
    
    var url: String {
        return "https://apiv2.allsportsapi.com/\(self.rawValue)/"
    }
    
    init?(sport: String) {
        self.init(rawValue: sport.lowercased())
    }
}

enum ApiCallType : String{
    case fixture = "Fixtures"
    case leagues = "Leagues"
    case teams = "Teams"
    case teamsDetails = "TeamsDetails"
}

enum ApiKey : String{
    case apiKey = "e99630517917638f1996e33140a36e0e599db1539710fd3e53a2ca3175417718"
}
