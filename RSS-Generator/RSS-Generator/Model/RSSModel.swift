//
//  RSSModel.swift
//  RSS-Generator
//
//  Created by zijia on 1/29/20.
//  Copyright © 2020 zijia. All rights reserved.
//

import Foundation

struct RSSModel: Codable {
    let feed: RSSFeed
}

struct RSSFeed: Codable {
    let results: [RSSResult]
}

struct RSSResult: Codable {
    let artistName: String
    let id: String
    let releaseDate: String
    let name: String
    let kind: String
    let artistId: String
    let artworkUrl100: String
    let copyright: String
    let artistUrl: String
    let genres: [RSSGenre]
    let url: String
}

struct RSSGenre: Codable {
    let genreId: String
    let name: String
    let url: String
}
