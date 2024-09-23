//
//  SpalshScreenView.swift
//  LaskNews
//
//  Created by Akshat Gandhi on 19/09/24.
//

import SwiftUI

struct SpalshScreenView: View {
    @State private var isLanding: Bool = false
    
    var body: some View {
        Group {
            if isLanding {
                WelcomeView()
            } else {
                ZStack {
                    Color.brandBlue10
                    Text("Lask")
                        .foregroundStyle(.brandBlue)
                        .font(.headingH1)
                }
                .edgesIgnoringSafeArea(.all)
                .onAppear() {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation {
                            isLanding = true
                        }
                    }
                }
            }
        }
        
    }
}

#Preview {
    SpalshScreenView()
}
