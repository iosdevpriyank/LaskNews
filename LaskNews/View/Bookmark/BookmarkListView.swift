//
//  BookmarkListView.swift
//  LaskNews
//
//  Created by Akshat Gandhi on 22/09/24.
//

import SwiftUI
import SwiftData

struct BookmarkListView: View {

    @Environment(\.modelContext) private var modelContext
    @Query private var articlesData: [ArticleDataModel]
    @State private var articles: [Article] = []
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(articles, id: \.id) { article in
                            NavigationLink(destination: ArticleDetailView(article: article)) {
                                NewsCardView(article: article, geometry: geometry)
                                    .frame(height: (200))
                                    .cornerRadius(15)
                                    .shadow(radius: 10)
                                    .padding(.horizontal)
                            }
                        }
                    }
                }
                .navigationTitle("Saved Articles")
                .onAppear() {
                    self.loadArticles()
                }
            }
        }
        
    }
    
    private func loadArticles() {
        articles = articlesData.map({ article in
            return Article(id: article.id, source: SourceData(id: "", name: ""), author: article.author, title: article.title, description: article.descriptions, url: article.url, urlToImage: article.urlToImage, publishedAt: article.publishedAt, content: article.content)
        })
    }
                                    
}

#Preview {
    BookmarkListView()
}
