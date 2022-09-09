//
//  InitEntity.swift
//  TheMoviewDBapp
//
//  Created by pablo luis velazquez zamudio on 07/09/22.
//

import Foundation

struct RequesTokenResponse: Codable {
    var success: Bool?
    var expires_at: String?
    var request_token: String?
}

