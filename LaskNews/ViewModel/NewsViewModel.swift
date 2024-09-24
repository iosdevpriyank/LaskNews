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
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String = ""
    @Environment(\.modelContext) private var modelContext
    

    init(dataManager: NewsServiceProtocol = NetworkManager.shared) {
        self.dataManager = dataManager
    }
    
    func getNewsByCategory(category: NewsCategory) {
        if category != .all {
            self.loadingValues(isLoading: true)
            dataManager.getTopHeadlinesServiceData(category: category)
                .sink {[weak self] completion in
                    self?.loadingValues(isLoading: false)
                    switch completion {
                    case .finished:
                        print("Finished")
                    case .failure(let error):
                        self?.errorMessage(message: "Error \(error)")
                    }
                } receiveValue: { [weak self] newsResponse in
                    self?.loadingValues(isLoading: false)
                    self?.getArticles(from: newsResponse)
                }
                .store(in: &cancellableSet)
        } else {
            getEverything()
        }
    }
    
    func getEverything(searchText text: String = "latest") {
        loadingValues(isLoading: true)
        dataManager.getEverythingServiceData(searchText: text).sink { [weak self] completion in
            self?.loadingValues(isLoading: false)
            switch completion {
            case .finished:
                print("Finished")
            case .failure(let error):
                self?.errorMessage(message: "Error \(error)")
            }
        } receiveValue: { [weak self] newsResponse in
            self?.loadingValues(isLoading: false)
            self?.getArticles(from: newsResponse)
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
    
    private func loadingValues(isLoading: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.isLoading = isLoading
        }
    }
    
    private func errorMessage(message: String) {
        DispatchQueue.main.async { [weak self] in
            self?.errorMessage = message
        }
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
