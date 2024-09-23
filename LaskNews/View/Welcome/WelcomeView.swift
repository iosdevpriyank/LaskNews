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
            VStack {
                TopView(geometry: geometry)
                Spacer()
                BottomView(geometry: geometry)
            }
        }
    }
}

#Preview {
    WelcomeView()
}
