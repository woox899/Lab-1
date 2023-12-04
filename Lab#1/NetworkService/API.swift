//
//  API.swift
//  Lab#1
//
//  Created by Андрей Бабкин on 01.12.2023.
//

import Foundation
import Moya

enum API {
    case musick
}

extension API: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "http://api.jamendo.com/v3.0/") else { fatalError() }
        return url
    }
    
    var path: String {
        switch self {
        case .musick:
            return
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        <#code#>
    }
    
    var headers: [String : String]? {
        <#code#>
    }
}
