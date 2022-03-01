//
//  ArtistResponse.swift
//  MusicByLocation
//
//  Created by Compton-Burnett, Peter (PGW) on 28/02/2022.
//

import Foundation

struct ArtistResponse: Codable {
    var count: Int
    var results: [Artist]
    
    private enum CodingKeys: String, CodingKey {
        case count = "resultCount"
        case results
    }
}
