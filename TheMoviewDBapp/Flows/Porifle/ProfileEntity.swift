//
//  ProfileEntity.swift
//  TheMoviewDBapp
//
//  Created by pablo luis velazquez zamudio on 08/09/22.
//

import Foundation

struct AccountResponse: Codable {
    var avatar: Avatar?
    var id: Int?
    var iso_639_1: String?
    var name: String?
    var include_adult: Bool?
    var username: String?
}

struct Avatar: Codable {
    var gravatar: Gravatar?
    var tmdb: TMDB?
}

struct Gravatar: Codable {
    var hash: String?
}

struct TMDB: Codable {
    var avatar_path: String?
}

