//
//  TopView.swift
//  LaskNews
//
//  Created by Akshat Gandhi on 20/09/24.
//

import SwiftUI

struct TopView: View {
    var geometry: GeometryProxy
    var body: some View {
        Image("welcome_building")
            .background(LinearGradient(colors: [.brandBlue, .brandBlue10], startPoint: .top, endPoint: .bottom))
            .frame(width: geometry.size.width, height: geometry.size.height * 0.5)
    }
}
