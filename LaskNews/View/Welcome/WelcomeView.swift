//
//  WelcomeView.swift
//  LaskNews
//
//  Created by Akshat Gandhi on 19/09/24.
//

import SwiftUI
import Combine

struct WelcomeView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                TopView()
                BottomView()
                    .frame(height: geometry.size.height / 2)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    WelcomeView()
}
