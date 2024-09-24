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
            VStack(alignment: .leading) {
                ImageLoader(imageURL: URL(string: article.urlToImage ?? "")!)
                VStack(alignment: .leading) {
                    Text(article.title ?? "")
                        .font(.headingH3)
                        .foregroundStyle(.textPrimary)
                    Text(article.content ?? "")
                        .font(.body1Regular)
                        .foregroundStyle(.textSecondary)
                    Text("Read More")
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
    ArticleDetailView(article: Constant.mockArticles.last!)
}
