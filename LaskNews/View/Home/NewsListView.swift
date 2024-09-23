//
//  NewsListView.swift
//  LaskNews
//
//  Created by Akshat Gandhi on 22/09/24.
//

import SwiftUI

struct NewsListView: View {
    @State private var searchText: String = ""
    @State private var selectCategory: String = "all"
    @StateObject var newsVM = NewsViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                VStack(alignment: .leading) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        // news category
                        HStack {
                            ForEach(NewsCategory.allCases, id: \.self) { category in
                                Text("\(category)".capitalized)
                                    .font(.body2Regular)
                                    .padding()
                                    .background(selectCategory == category.rawValue ? .textPrimary : .textSecondary)
                                    .foregroundStyle(.backgroundPrimary)
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        selectCategory = category.rawValue
                                    }
                                
                            }
                        }
                        .padding(.horizontal)
                    }
                    // Display News cards
                    ScrollView {
                        LazyVStack(spacing: 20) {
                            ForEach(newsVM.articles, id: \.id) { article in
                                NavigationLink(destination: ArticleDetailView(article: article)) {
                                    NewsCardView(article: article, geometry: geometry)
                                        .cornerRadius(15)
                                        
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .navigationTitle("Latest News")
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: Text("Search News")) {
                    
                }
                .onChange(of: searchText) { oldValue, newValue in
                    newsVM.getEverything(searchText: newValue)
                }
                .onSubmit({
                    
                })
                .onAppear() {
                    newsVM.getEverything()
                }
            }
            
        }
        }
        
}

#Preview {
    NewsListView()
}
