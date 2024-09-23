//
//  NewsServiceProtocol.swift
//  LaskNews
//
//  Created by Akshat Gandhi on 22/09/24.
//

import Foundation
import Combine

protocol NewsServiceProtocol {
    func getTopHeadlinesServiceData(category: NewsCategory) -> AnyPublisher<NewsResponse,NetworkErrors>
    func getEverythingServiceData(searchText: String) -> AnyPublisher<NewsResponse,NetworkErrors>
}
