//
//  NewsCardView.swift
//  LaskNews
//
//  Created by Akshat Gandhi on 22/09/24.
//

import SwiftUI

struct NewsCardView: View {
    let article: Article
    let geometry: GeometryProxy?
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            AsyncImage(url: URL(string: article.urlToImage ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: (geometry?.size.width ?? 0) - 50, height: 200)
                    .clipped()
                    .cornerRadius(10)
            } placeholder: {
                CustomizedProgressView()
            }
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
            .padding(.horizontal, 5)
        }
        .padding()
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
    NewsCardView(article: Article(source: SourceData(id: "techcrunch", name: "TechCrunch"), author: "Rebecca Bellan", title: "Pedego’s Cargo e-bike: Sporty, stylish and powerful for $4,000", description: "The Pedego’s Cargo e-bike is marketed as a powerful and sporty ride that’s geared towards parents toting kids around town and anyone who needs to schlep", url: "https://techcrunch.com/2024/09/22/pedegos-cargo-e-bike-sporty-stylish-and-powerful-for-4000/", urlToImage: "https://techcrunch.com/wp-content/uploads/2024/09/FSM_CARGO_8813.jpg?resize=1200,801", publishedAt: Date(), content: "The Pedegos Cargo e-bike is marketed as a powerful and sporty ride thats geared towards parents toting kids around town and anyone who needs to schlep heavy gear. \r\nI spent the summer testing out thi…"), geometry: nil)
}
