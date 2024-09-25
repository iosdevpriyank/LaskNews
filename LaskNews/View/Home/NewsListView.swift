//
//  NewsListView.swift
//  LaskNews
//
//  Created by Akshat Gandhi on 22/09/24.
//

import SwiftUI

struct NewsListView: View {
    @State private var searchText: String = ""
    @State private var selectCategory: NewsCategory = .all
    @StateObject var newsVM = NewsViewModel()
    
    var body: some View {
        
            NavigationStack {
                VStack(alignment: .leading, spacing: 0) {
                    CategoryView(selectCategory: selectCategory) { category in
                        selectCategory(category: category)
                    }
                    ZStack {
                        if newsVM.isLoading {
                            VStack(spacing:0) {
                                Image(systemName: Constant.Images.newspaper)
                                    .font(.title)
                                    .foregroundStyle(.brandBlue)
                                    .padding(.bottom, 30)
                                CustomizedProgressView()
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        } else if !newsVM.errorMessage.isEmpty {
                            // Display error message
                            VStack {
                                Text("\(newsVM.errorMessage)")
                                    .font(.body)
                                    .foregroundStyle(.red)
                                    .padding()
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        } else {
                            // Display News cards
                            GeometryReader { geometry in
                                ScrollView {
                                    LazyVStack(spacing: 8) {
                                        ForEach(newsVM.articles, id: \.id) { article in
                                            NavigationLink(destination: ArticleDetailView(article: article)) {
                                                NewsCardView(article: article, geometry: geometry)
                                                    .cornerRadius(15)
                                                    .shadow(radius: 10)
                                                    .padding(.horizontal)
                                                    .padding(.top, 15)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding(.top, 16)
                }
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
                .navigationTitle(Text("latest_news", tableName: Constant.stringTableName))
                .onSubmit(of: .search, {
                    if selectCategory != .all {
                        selectCategory = .all
                    }
                    newsVM.getEverything(searchText: searchText)
                })
                .onChange(of: searchText) { oldValue, newValue in
                    if newValue.isEmpty {
                        resetFilter()
                        newsVM.getEverything()
                    }
                }
                .onAppear() {
                    newsVM.getEverything()
                }
            }
        
    }
    
    private func resetFilter() {
        selectCategory = .all
        searchText = ""
    }
    
    private func selectCategory(category: NewsCategory) {
        selectCategory = category
        searchText = ""
        newsVM.getNewsByCategory(category: category)
    }
}

#Preview {
    NewsListView()
}
