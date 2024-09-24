//
//  MockNewsService.swift
//  LaskNewsTests
//
//  Created by Akshat Gandhi on 24/09/24.
//

import Combine
import XCTest
@testable import LaskNews

class MockNewsService: NewsServiceProtocol {
    
    var isReturnError = false
    var testResponse: NewsResponse?

    func getTopHeadlinesServiceData(category: LaskNews.NewsCategory) -> AnyPublisher<LaskNews.NewsResponse, LaskNews.NetworkErrors> {
        if isReturnError {
            return Fail(error: NetworkErrors.urlError)
                .eraseToAnyPublisher()
        } else {
            return Just(testResponse!)
                .setFailureType(to: NetworkErrors.self)
                .eraseToAnyPublisher()
        }
    }
    
    func getEverythingServiceData(searchText: String) -> AnyPublisher<LaskNews.NewsResponse, LaskNews.NetworkErrors> {
        if isReturnError {
            return Fail(error: NetworkErrors.urlError)
                .eraseToAnyPublisher()
        } else {
            return Just(testResponse!)
                .setFailureType(to: NetworkErrors.self)
                .eraseToAnyPublisher()
        }
    }
}

