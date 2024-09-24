//
//  TopView.swift
//  LaskNews
//
//  Created by Akshat Gandhi on 20/09/24.
//

import SwiftUI

struct TopView: View {
    var body: some View {
        GeometryReader { geometry in
            Image("welcome_building")
                .resizable()
                .ignoresSafeArea()
                .background(LinearGradient(colors: [.brandBlue, .brandBlue10], startPoint: .top, endPoint: .bottom))
                .frame(width: geometry.size.width, height: geometry.size.height * 0.7)
        }
    }
}
