//
//  LaskNewsApp.swift
//  LaskNews
//
//  Created by Akshat Gandhi on 19/09/24.
//

import SwiftUI
import SwiftData

@main
struct LaskNewsApp: App {
    var body: some Scene {
        WindowGroup {
            SpalshScreenView()
        }
        .modelContainer(for: ArticleDataModel.self)
    }
}
