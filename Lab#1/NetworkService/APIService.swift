//
//  APIService.swift
//  Lab#1
//
//  Created by Андрей Бабкин on 10.12.2023.
//

import Foundation
import Moya

final class APIService {
    private let target = MoyaProvider<GetMusick>()
    private let clientID = "4c7ca959"

    func getTracks(completion: @escaping (Result<[TracksModel], Error>) -> Void) {
        target.request(.tracks(clientID)) { result in
            switch result {
            case .success(let response):
                let mapped = try? response.map(TracksResponse.self)
                completion(.success(mapped?.results ?? []))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
