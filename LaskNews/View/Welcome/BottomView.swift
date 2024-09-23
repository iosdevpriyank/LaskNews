//
//  BottomView.swift
//  LaskNews
//
//  Created by Akshat Gandhi on 20/09/24.
//

import SwiftUI

struct BottomView: View {
    var geometry: GeometryProxy
    @State private var isTabBar: Bool = false
    
    var body: some View {
        VStack {
            VStack {
                Text("Get The Latest News And Updates")
                    .font(.headingH3)
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.center)
                Text("From Politics to Entertainment: Your One-Stop Source for Comprehensive Coverage of the Latest News and Developments Across the Glob will be right on your hand.")
                    .font(.body1Regular)
                    .foregroundStyle(.textSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.vertical,10)
            }
            .padding()
            
            Button {
                isTabBar = true
            } label: {
                HStack {
                    Text("Explore")
                        .font(.headline)
                        .foregroundStyle(.white)
                    Image(systemName: "arrow.right")
                        .foregroundStyle(.white)
                }
                .padding(.horizontal, 20)
            }
            .padding()
            .background(.brandBlue)
            .clipShape(.capsule)
            .fullScreenCover(isPresented: $isTabBar) {
                TabbarMenuView()
            }
            Spacer()
        }
        .padding()
        .frame(width: geometry.size.width) .background(.white)
        .clipShape(.rect(
            topLeadingRadius: 50.0,
            topTrailingRadius: 50.0
        ))
    }
}

