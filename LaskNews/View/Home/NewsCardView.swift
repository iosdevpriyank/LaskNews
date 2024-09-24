//
//  NewsCardView.swift
//  LaskNews
//
//  Created by Akshat Gandhi on 22/09/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct NewsCardView: View {
    let article: Article
    let geometry: GeometryProxy?
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ImageLoader(imageURL: URL(string: article.urlToImage ?? "")!)
            VStack(alignment: .leading) {
                Text(article.title ?? "")
                    .font(.body1SemiBold)
                    .foregroundStyle(.textPrimary)
                    .shadow(radius: 2)
                    .padding(.top, 5)
                    .multilineTextAlignment(.leading)
                    .minimumScaleFactor(0.8)
                    .fixedSize(horizontal: false, vertical: true)
                HStack {
                    Text(article.author ?? "")
                        .font(.footNoteSemiBold)
                        .foregroundStyle(.textPrimary)
                        .shadow(radius: 2)
                    Spacer()
                    Text(formattedDate(article.publishedAt))
                        .font(.footNoteSemiBold)
                        .foregroundStyle(.textPrimary)
                        .shadow(radius: 2)
                }
                .padding(.top, 5)
            }
            .padding([.leading, .trailing, .bottom], 10)
        }
        .background(.backgroundPrimary)
        .cornerRadius(15)
        .shadow(radius: 10)
    }
    
    private func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
}

#Preview {
    NewsCardView(article: Constant.mockArticles.first!, geometry: nil)
}
