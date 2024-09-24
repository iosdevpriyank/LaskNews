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
            VStack() {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .brandBlue))
                    .scaleEffect(2.5)
                    .padding(.bottom, 10)
                Text("Loading...")
            }
        }
    }
}

#Preview {
    CustomizedProgressView()
}
