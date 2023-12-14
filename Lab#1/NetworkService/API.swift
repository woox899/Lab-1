//
//  API.swift
//  Lab#1
//
//  Created by Андрей Бабкин on 01.12.2023.
//

import Foundation
import Moya

enum GetMusick {
    case tracks(String)
}

extension GetMusick: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.jamendo.com/v3.0") else { fatalError() }
        return url
    }
    
    var path: String {
        switch self {
        case .tracks:
            return "/tracks"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        switch self {
        case .tracks(let clientId):
            return .requestParameters(parameters: ["client_id" : clientId, "limit" : "30", "vocalinstrumental" : "instrumental"], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
