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
                Group {
                    if articles.isEmpty {
                        VStack(spacing: 10, content: {
                            Image(systemName: "bookmark.slash")
                                .font(.headingH2)
                                .foregroundStyle(.systemError, .brandBlue)
                                .padding(.bottom, 10)
                            Text("No Articels Bookmarked")
                                .font(.body1SemiBold)
                                .foregroundStyle(.textPrimary)
                                .padding(.bottom, 5)
                            Text("You can save articles to bookmarks for later reading.")
                                .font(.body2Regular)
                                .foregroundStyle(.textPrimary)
                        })
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 20) {
                                ForEach(articles, id: \.id) { article in
                                    NavigationLink(destination: ArticleDetailView(article: article)) {
                                        NewsCardView(article: article, geometry: geometry)
                                            .cornerRadius(15)
                                            .shadow(radius: 10)
                                            .padding(.horizontal)
                                    }
                                }
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
