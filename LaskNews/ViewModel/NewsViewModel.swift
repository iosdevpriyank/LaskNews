//
//  NewsViewModel.swift
//  LaskNews
//
//  Created by Akshat Gandhi on 22/09/24.
//
import SwiftUI
import Combine
import CryptoKit
import SwiftData

class NewsViewModel: ObservableObject {
    
    private var cancellableSet : Set<AnyCancellable> = []
    var dataManager: NewsServiceProtocol
    var cancellation: AnyCancellable?
    
    @Published private(set) var articles: [Article] = []
    @Published private(set) var articlesData: [Article] = []
    @Environment(\.modelContext) private var modelContext
    

    init(dataManager: NewsServiceProtocol = NetworkManager.shared) {
        self.dataManager = dataManager
    }
    
    func getNewsByCategory(category: NewsCategory) {
        if category != .all {
            dataManager.getTopHeadlinesServiceData(category: category)
                .sink { completion in
                    switch completion {
                    case .finished:
                        print("Finished")
                    case .failure(let error):
                        print("Errors \(error)")
                    }
                } receiveValue: { newsResponse in
                    self.getArticles(from: newsResponse)
                }
                .store(in: &cancellableSet)

        }
    }
    
    func getEverything(searchText text: String = "latest") {
        dataManager.getEverythingServiceData(searchText: text).sink { completion in
            switch completion {
            case .finished:
                print("Finished")
            case .failure(let error):
                print("Errors \(error)")
            }
        } receiveValue: { newsResponse in
            self.getArticles(from: newsResponse)
        }
        .store(in: &self.cancellableSet)
    }
    
    private func getArticles(from response: NewsResponse) {
        self.articles = []
        let filterdNews = response.articles.filter { article in
            guard let articleURL = article.url, !articleURL.isEmpty else { return false }
            guard let imageUrl = article.urlToImage, !imageUrl.isEmpty else { return false }
            return true
        }
        self.articles = filterdNews
    }
    
    func getSavedArticles(using modelContext: ModelContext) {
        let fetchRequest = FetchDescriptor<ArticleDataModel>()
        do {
            let fetchArticles = try modelContext.fetch(fetchRequest)
            var articles: [Article] = []
            for article in fetchArticles {
                let newArticle = Article(id: article.id, source: SourceData(id: "", name: ""), author: article.author, title: article.title, description: article.descriptions, url: article.url, urlToImage: article.urlToImage, publishedAt: article.publishedAt, content: article.content)
                articles.append(newArticle)
            }
            self.articlesData = articles
        } catch {
            print("failed to fetch saved articles")
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
    
    
}
