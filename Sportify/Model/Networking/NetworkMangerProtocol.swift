//
//  NetworkMangerProtocol.swift
//  Sportify
//
//  Created by Macos on 16/05/2025.
//

import Foundation
import Alamofire
protocol NetworkMangerProtocol{

    func fetchData<T : Decodable>(
        sport:String,
        requestType:String,
        leagueId:Int,
        complition : @escaping (Result<T,Error>)->Void
    )
}
