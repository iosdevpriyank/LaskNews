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
    
    @Environment(\.isSearching) private var isSearching
    
    
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                VStack(alignment: .leading, spacing: 10) {
                    if !isSearching {
                        ScrollView(.horizontal, showsIndicators: false) {
                            // news category
                            HStack {
                                ForEach(NewsCategory.allCases, id: \.self) { category in
                                    Text("\(category)".capitalized)
                                        .font(.body2Regular)
                                        .padding()
                                        .background(selectCategory == category ? .textPrimary : .textSecondary)
                                        .foregroundStyle(.backgroundPrimary)
                                        .cornerRadius(10)
                                        .onTapGesture {
                                            selectCategory(category: category)
                                        }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    ZStack {
                        if newsVM.isLoading {
                            VStack(spacing:0) {
                                Image(systemName: "newspaper")
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
                            ScrollView {
                                LazyVStack(spacing: 20) {
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
                            .padding(.horizontal)
                        }
                    }
                    .padding(.top, 16)
                }
                .searchable(text: $searchText)
                .navigationTitle("Latest News")
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
