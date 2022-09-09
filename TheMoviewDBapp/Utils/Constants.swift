//
//  Constants.swift
//  TheMoviewDBapp
//
//  Created by pablo luis velazquez zamudio on 08/09/22.
//

import Foundation

class Constats {
    static let apiKey = "5e0b2dc76d63f8540e0808751de8b5b4"
    static let pathAPI = "new?api_key="
    static let oldPathAPI = "?api_key="
}

enum Categories: String  {
    case popular = "popular/"
    case topRated = "top_rated/"
    case nowPlaying = "now_playing/"
}
