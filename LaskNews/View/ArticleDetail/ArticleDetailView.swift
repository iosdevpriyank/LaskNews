//
//  ArticleDetailView.swift
//  LaskNews
//
//  Created by Akshat Gandhi on 22/09/24.
//

import SwiftUI
import SwiftData
import CryptoKit

struct ArticleDetailView: View {
    let article: Article
    @State private var isBookmarked: Bool = false
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ZStack(alignment: .bottomTrailing) {
                    ImageLoader(imageURL: URL(string: article.urlToImage ?? "")!)
                }
                VStack(alignment: .leading) {
                    Text(article.title ?? "")
                        .font(.headingH3)
                        .foregroundStyle(.textPrimary)
                    
                    Text(article.content ?? "")
                        .font(.body1Regular)
                        .foregroundStyle(.textSecondary)
                    Text(" Read More")
                        .foregroundStyle(.brandBlue)
                        .font(.body1SemiBold)
                        .onTapGesture {
                            if let url = URL(string: article.url ?? "") {
                                UIApplication.shared.open(url)
                            }
                            
                        }
                }
                .padding(.horizontal, 10)
            }
            .padding(.horizontal, 5)
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    toggleBookmark()
                } label: {
                    Image(systemName: isBookmarked ? "bookmark.fill": "bookmark")
                        .foregroundStyle(.textPrimary)
                }

            }
        }
        .onAppear {
            isBookmarked = fetchSavedArticles().filter({$0.id == self.article.id}).count > 0
        }
    }
    
    private func toggleBookmark() {
        if isBookmarked {
            removeBookmark()
        } else {
            addBookmark()
        }
        isBookmarked.toggle()
    }
    
    private func removeBookmark() {
        guard let article = fetchSavedArticles().first(where: {$0.id == self.article.id }) else { return }
        modelContext.delete(article)
        try? modelContext.save()
    }
    
    private func fetchSavedArticles() -> [ArticleDataModel] {
        let fetchDescriptor = FetchDescriptor<ArticleDataModel>()
        do {
            return try modelContext.fetch(fetchDescriptor)
        } catch {
            return []
        }
    }
    
    private func addBookmark() {
        let articleModel = ArticleDataModel(id: article.id, author: article.author ?? "", title: article.title ?? "", description: article.description ?? "", url: article.url ?? "", urlToImage: article.urlToImage ?? "", publishedAt: article.publishedAt, content: article.content ?? "")
        modelContext.insert(articleModel)
        try? modelContext.save()
    }
    
    
}

#Preview {
    ArticleDetailView(article: Article(source: SourceData(id: "techcrunch", name: "TechCrunch"), author: "Rebecca Bellan", title: "Pedego’s Cargo e-bike: Sporty, stylish and powerful for $4,000", description: "The Pedego’s Cargo e-bike is marketed as a powerful and sporty ride that’s geared towards parents toting kids around town and anyone who needs to schlep", url: "https://techcrunch.com/2024/09/22/pedegos-cargo-e-bike-sporty-stylish-and-powerful-for-4000/", urlToImage: "https://techcrunch.com/wp-content/uploads/2024/09/FSM_CARGO_8813.jpg?resize=1200,801", publishedAt: Date(), content: "The Pedegos Cargo e-bike is marketed as a powerful and sporty ride thats geared towards parents toting kids around town and anyone who needs to schlep heavy gear. \r\nI spent the summer testing out thi…"))
}
