//
//  CategoryView.swift
//  LaskNews
//
//  Created by Akshat Gandhi on 25/09/24.
//

import SwiftUI

struct CategoryView: View {
    var selectCategory: NewsCategory
    @Environment(\.isSearching) private var isSearching
    var onTapped: (NewsCategory) -> Void
    var body: some View {
        if !isSearching {
            ScrollView(.horizontal, showsIndicators: false) {
                // news category
                HStack {
                    ForEach(NewsCategory.allCases, id: \.self) { category in
                        Text("\(category)".capitalized)
                            .font(.body2Regular)
                            .padding([.top, .bottom], 8)
                            .padding(.horizontal, 16)
                            .background(selectCategory == category ? .textPrimary : .textSecondary)
                            .foregroundStyle(.backgroundPrimary)
                            .clipShape(.capsule)
                            .onTapGesture {
                                onTapped(category)
                            }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    CategoryView(selectCategory: .all) { category in
        print("Category \(category)")
    }
}
