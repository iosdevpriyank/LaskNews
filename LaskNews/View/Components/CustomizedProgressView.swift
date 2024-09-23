//
//  CustomizedProgressView.swift
//  LaskNews
//
//  Created by Akshat Gandhi on 23/09/24.
//

import SwiftUI

struct CustomizedProgressView: View {
    var body: some View {
        HStack {
            Spacer()
            VStack(spacing: 10) {
                CustomizedProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .brandBlue))
                    .scaleEffect(2.5)
                    .frame(height: 200)
                Text("Loading...")
            }
            Spacer()
        }
    }
}

#Preview {
    CustomizedProgressView()
}
