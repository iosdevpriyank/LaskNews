//
//  NewsResponse.swift
//  LaskNews
//
//  Created by Akshat Gandhi on 21/09/24.
//

import Foundation
import CryptoKit

struct NewsResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable, Identifiable {
    var id: String
    let source: SourceData
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: Date
    let content: String?
    
    // Custom initializer for the Article struct
    init(id: String? = nil, source: SourceData, author: String?, title: String, description: String, url: String, urlToImage: String?, publishedAt: Date, content: String?) {
        // If `id` is provided, use it; otherwise, generate the `id`
        self.id = id ?? Article.generateArticleId(title: title, publishedAt: publishedAt, url: url)
        self.source = source
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
    
    private enum CodingKeys: String, CodingKey {
        case source, author, title, description, url, urlToImage, publishedAt, content
    }
    
    static func generateArticleId(title: String, publishedAt: Date, url: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let publishedAtString = dateFormatter.string(from: publishedAt)
        let contentToHash = (title + publishedAtString + url)
        let data = Data(contentToHash.utf8)
        let hash = SHA256.hash(data: data)
        return hash.compactMap { String(format: "%02x", $0) }.joined()
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.source = try container.decode(SourceData.self, forKey: .source)
        self.author = try container.decodeIfPresent(String.self, forKey: .author)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.urlToImage = try container.decodeIfPresent(String.self, forKey: .urlToImage)
        let strDate = try container.decode(Date.self, forKey: .publishedAt)
        self.publishedAt = strDate
        self.content = try container.decodeIfPresent(String.self, forKey: .content)
        
        // Use the generated ID from title, publishedAt, and url
        self.id = Article.generateArticleId(title: title ?? "", publishedAt: publishedAt, url: url ?? "")
    }
    
    // Encoding function for conforming to Encodable
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(source, forKey: .source)
        try container.encodeIfPresent(author, forKey: .author)
        try container.encode(title, forKey: .title)
        try container.encode(description, forKey: .description)
        try container.encode(url, forKey: .url)
        try container.encodeIfPresent(urlToImage, forKey: .urlToImage)
        try container.encode(publishedAt, forKey: .publishedAt)
        try container.encodeIfPresent(content, forKey: .content)
    }
}

// MARK: - Source
struct SourceData: Codable {
    let id: String?
    let name: String
}
