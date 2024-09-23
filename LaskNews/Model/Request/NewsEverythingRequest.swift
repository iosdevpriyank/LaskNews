//
//  NewsEverythingRequest.swift
//  LaskNews
//
//  Created by Akshat Gandhi on 20/09/24.
//

import Foundation

struct NewsEverythingRequest: Encodable {
    let apiKey: String
    let query: String
    
    enum CodingKeys: String, CodingKey {
        case apiKey = "apiKey"
        case query = "q"
    }
}
