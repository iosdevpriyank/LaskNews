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
            return NSLocalizedString("home", tableName: Constant.stringTableName, comment: "Home tab label")
        case .bookmarks:
            return NSLocalizedString("bookmark", tableName: Constant.stringTableName, comment: "Bookmark tab label")
        }
    }
    
    var systemIconName: String {
        switch self {
        case .home:
            return Constant.Images.house
        case .bookmarks:
            return Constant.Images.bookmark
        }
    }
}
