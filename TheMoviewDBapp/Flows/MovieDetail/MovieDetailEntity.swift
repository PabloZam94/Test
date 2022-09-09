//
//  MovieDetailEntity.swift
//  TheMoviewDBapp
//
//  Created by pablo luis velazquez zamudio on 08/09/22.
//

import Foundation

struct MovieDetailResponse: Codable {
    var adult: Bool?
    var backdrop_path: String?
    var budget: Int?
    var genres: [Genres]?
    var homepage: String?
    var id: Int?
    var imdb_id: String?
    var original_language: String?
    var original_title: String?
    var overview: String?
    var popularity: Double?
    var poster_path: String?
    var release_date: String?
    var runtime: Int?
    var status: String?
    var title: String?
    var video: Bool?
    var vote_average: Double?
    var vote_count: Int?
    
}

struct Genres: Codable {
    var id: Int?
    var name: String?
}
