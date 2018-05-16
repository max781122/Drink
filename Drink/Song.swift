//
//  Song.swift
//  Drink
//
//  Created by sourceinn on 2018/5/15.
//  Copyright © 2018年 sourceinn. All rights reserved.
//

import Foundation
struct Song: Codable {
    var artistName: String
    var trackName: String
    var collectionName: String?
    var previewUrl: URL
    var artworkUrl100: URL
    var trackPrice: Double?
    var releaseDate: Date
    var isStreamable: Bool?
}

struct SongResults: Codable {
    var resultCount: Int
    var results: [Song]
}
