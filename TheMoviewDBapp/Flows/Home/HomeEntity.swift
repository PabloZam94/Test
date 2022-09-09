//
//  HomeEntity.swift
//  TheMoviewDBapp
//
//  Created by pablo luis velazquez zamudio on 07/09/22.
//

import Foundation

struct MoviesResponse: Codable {
    var page: Int?
    var results: [MoviesResults]?
    var total_pages: Int?
    var total_results: Int?
}

struct MoviesResults: Codable {
    var adult: Bool?
    var backdrop_path: String?
    var id: Int?
    var original_language: String?
    var original_title: String?
    var overview: String?
    var popularity: Double?
    var poster_path: String?
    var release_date: String?
    var title: String?
    var video: Bool?
    var vote_average: Double?
    var vote_count: Int?
}
