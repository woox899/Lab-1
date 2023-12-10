//
//  TracksModel.swift
//  Lab#1
//
//  Created by Андрей Бабкин on 06.12.2023.
//

import Foundation

// MARK: - TracksModel
struct TracksResponse: Decodable {
    let results: [TracksModel]
}

struct TracksModel: Decodable {
    let name: String?
    let artistName: String?
    let image: String?
    let audio: String?
    let duration: Int?
    
    enum CodingKeys: String, CodingKey {
        case name
        case artistName = "artist_name"
        case image
        case audio
        case duration
    }
}

