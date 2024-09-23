//
//  TabbarMenuView.swift
//  LaskNews
//
//  Created by Akshat Gandhi on 20/09/24.
//

import SwiftUI

struct TabbarMenuView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                TabView(selection: $selectedTab) {
                    NewsListView()
                        .tag(0)
                    BookmarkListView()
                        .tag(1)
                }
                BottomTabView(selectedTab: $selectedTab, geometry: geometry)
                    .animation(.easeInOut, value: selectedTab)
            }.ignoresSafeArea()
        }
    }
}

#Preview {
    TabbarMenuView()
}
