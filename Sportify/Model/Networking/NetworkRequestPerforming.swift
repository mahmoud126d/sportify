//
//  NetworkRequestPerforming.swift
//  Sportify
//
//  Created by Macos on 20/05/2025.
//

import Foundation
import Alamofire
protocol NetworkRequestPerforming {
    func request<T: Decodable>(
        _ url: String,
        parameters: Parameters,
        completion: @escaping (Result<T, Error>) -> Void
    )
}

class AlamofireNetworkRequester: NetworkRequestPerforming {
    func request<T: Decodable>(
        _ url: String,
        parameters: Parameters,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        AF.request(url, parameters: parameters)
            .validate()
            .responseDecodable(of: ApiResponse<T>.self) { response in
                switch response.result {
                case .success(let apiResponse):
                    completion(.success(apiResponse.result))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
