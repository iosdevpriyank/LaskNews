//
//  Constant.swift
//  LaskNews
//
//  Created by Akshat Gandhi on 19/09/24.
//
import Foundation

struct Constant {
    static let newsAPIKEY = "24a3c46b329e4133adef1bbb009264a6"
    static let newsAPIBASEURL = "https://newsapi.org/v2/"
    
    static let mockArticles = [Article(id: "1TF", source: SourceData(id: "bbc-news", name: "BBC News"), author: "BBC News", title: "Singapore: Ex-minister Iswaran's corruption trial set to begin", description: "More than 30,000 Boeing workers went on strike earlier this month after rejecting a 25% pay rise offer.", url: "https://www.bbc.co.uk/news/articles/ckg92528y51o", urlToImage: "https://ichef.bbci.co.uk/news/1024/branded_news/c3aa/live/bb07a730-7a09-11ef-970d-cba90a04d0a0.jpg", publishedAt: Date.now, content: "Boeing workers voted to strike on September 13 after rejecting a new contract deal, which included a 25% pay rise over four years.\r\nThe union had initially aimed for a number of improvements to worke… [+856 chars]"), Article(id: "2TF", source: SourceData(id: "bbc-news", name: "BBC News"), author: "BBC News", title: "Subramaniam Iswaran faces 35 counts in a rare case of graft for the small island nation.", description: "Subramaniam Iswaran faces 35 counts in a rare case of graft for the small island nation.", url: "https://www.bbc.co.uk/news/articles/c8rdk4m82n6o", urlToImage: "https://ichef.bbci.co.uk/news/1024/branded_news/9343/live/aa1fbb90-7a0b-11ef-809f-674c8286048e.jpg", publishedAt: Date.now, content: "The case against Iswaran is one of a series of political scandals that have rocked the ruling People's Action Party (PAP), which has long touted its strong stance against corruption and amoral behavi… [+809 chars]")]
    
    static let stringTableName = "AppStrings"
    struct Images {
        static let bookmarkFill = "bookmark.fill"
        static let bookmark = "bookmark"
        static let welcomeBuilding = "welcome_building"
        static let newspaper = "newspaper"
        static let arrowRight = "arrow.right"
        static let house = "house"
    }
}
