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
                    Text("welcome_title", tableName: Constant.stringTableName)
                        .font(.headingH3)
                        .foregroundStyle(.textPrimary)
                        .multilineTextAlignment(.center)
                    Text("welcome_description", tableName: Constant.stringTableName)
                        .font(.body1Regular)
                        .foregroundStyle(.textSecondary)
                        .multilineTextAlignment(.center)
                    Spacer()
                        .frame(height: 20)
                    Button {
                        isTabBar = true
                    } label: {
                        HStack {
                            Text("welcome_button", tableName: Constant.stringTableName)
                                .font(.headline)
                                .foregroundStyle(.white)
                            Image(systemName: Constant.Images.arrowRight)
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

