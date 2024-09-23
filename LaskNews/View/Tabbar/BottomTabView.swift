//
//  BottomTabView.swift
//  LaskNews
//
//  Created by Akshat Gandhi on 22/09/24.
//

import SwiftUI

struct BottomTabView: View {
    @Binding var selectedTab: Int {
        didSet {
            print("Selected tab: \(selectedTab)")
        }
    }
    var geometry: GeometryProxy?
    var bottomSafeAreaPadding: CGFloat?
    
    init(selectedTab: Binding<Int>, geometry: GeometryProxy? = nil) {
        self._selectedTab = selectedTab
        self.geometry = geometry
        self.bottomSafeAreaPadding = UIApplication.shared.connectedScenes
            .compactMap {($0 as? UIWindowScene)?.keyWindow}
            .last?.safeAreaInsets.bottom
    }
    
    var body: some View {
        ZStack {
            HStack(spacing: 40) {
                ForEach(AppTab.allCases, id:\.self) { index in
                    Button {
                        withAnimation(.spring()) {
                            selectedTab = index.rawValue
                        }
                    } label: {
                        TabbarItemView(iconName: index.systemIconName, label: index.label, isSelected: selectedTab == index.rawValue)
                    }
                }
            }
            .padding(10)
        }
        .frame(width: geometry?.size.width, height: 50 + (bottomSafeAreaPadding ?? 0))
        .background(.backgroundPrimary.opacity(0.7))
        .overlay(content: {
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color.textPrimary)
        })
    }
    
    func TabbarItemView(iconName: String,label: String, isSelected: Bool) -> some View {
        HStack {
            Image(systemName: isSelected ? iconName + ".fill" : iconName)
                .resizable()
                .renderingMode(.template)
                .foregroundStyle(isSelected ? .backgroundPrimary : .textPrimary)
                .scaledToFit()
                .frame(width: 20, height: 20)
            if isSelected {
                Text(label)
                    .font(.footNoteSemiBold)
                    .foregroundStyle(.backgroundPrimary)
                    .transition(.opacity)
            }
        }
        .padding(12)
        .background(isSelected ? .textPrimary : .clear)
        .cornerRadius(20)
    }
}

#Preview {
    BottomTabView(selectedTab: .constant(0))
}
