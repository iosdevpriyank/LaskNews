//
//  ArticleDataModel.swift
//  LaskNews
//
//  Created by Akshat Gandhi on 23/09/24.
//

import SwiftData
import Foundation

@Model
class ArticleDataModel: Identifiable {
    @Attribute(.unique) var id: String
    var author: String
    var title: String
    var descriptions: String
    var url: String
    var urlToImage: String
    var publishedAt: Date
    var content: String
    
    init(id: String, author: String, title: String, description: String, url: String, urlToImage: String, publishedAt: Date, content: String) {
        self.id = id
        self.author = author
        self.title = title
        self.descriptions = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
}

