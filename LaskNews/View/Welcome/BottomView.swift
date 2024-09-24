//
//  BottomView.swift
//  LaskNews
//
//  Created by Akshat Gandhi on 20/09/24.
//

import SwiftUI

struct BottomView: View {
    @State private var isTabBar: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 10) {
                VStack(spacing:20) {
                    Text("Get The Latest News And Updates")
                        .font(.headingH3)
                        .foregroundStyle(.textPrimary)
                        .multilineTextAlignment(.center)
                    Text("From Politics to Entertainment: Your One-Stop Source for Comprehensive Coverage of the Latest News and Developments Across the Glob will be right on your hand.")
                        .font(.body1Regular)
                        .foregroundStyle(.textSecondary)
                        .multilineTextAlignment(.center)
                    Spacer()
                        .frame(height: 20)
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
                        .padding([.top,.bottom], 15)
                        .padding([.trailing,.leading], 20)
                    }
                    .background(.brandBlue)
                    .clipShape(.capsule)
                    .fullScreenCover(isPresented: $isTabBar) {
                        TabbarMenuView()
                    }
                }
                Spacer()
            }
            .padding()
            .frame(width: geometry.size.width)
            .background(.white)
            .clipShape(.rect(
                topLeadingRadius: 50.0,
                topTrailingRadius: 50.0
            ))
        }
    }
}

