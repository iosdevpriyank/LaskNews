//
//  AppTab.swift
//  LaskNews
//
//  Created by Akshat Gandhi on 22/09/24.
//

import Foundation

enum AppTab: Int, CaseIterable {
    case home
    case bookmarks
    
    var label: String {
        switch self {
        case .home:
            return "Home"
        case .bookmarks:
            return "Bookmarks"
        }
    }
    
    var systemIconName: String {
        switch self {
        case .home:
            return "house"
        case .bookmarks:
            return "bookmark"
        }
    }
}
