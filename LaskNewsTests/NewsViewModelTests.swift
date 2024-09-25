//
//  NewsViewModelTests.swift
//  LaskNewsTests
//
//  Created by Akshat Gandhi on 24/09/24.
//

import XCTest
@testable import LaskNews
import Testing

final class NewsViewModelTests: XCTestCase {

    var newsViewModel: NewsViewModel!
    var mockNewsService: MockNewsService!
    let mockNewsResponse: NewsResponse = .init(status: "ok", totalResults: 200, articles: Constant.mockArticles)
    
    override func setUp() {
        super.setUp()
        mockNewsService = MockNewsService()
        newsViewModel = NewsViewModel(dataManager: mockNewsService)
    }
    
    override func tearDown() {
        mockNewsService = nil
        newsViewModel = nil
        super.tearDown()
    }
    
    func testGetNewsByCategorySuccess() {
        
        mockNewsService.testResponse = mockNewsResponse
        
        newsViewModel.getNewsByCategory(category: .business)
        
        XCTAssertEqual(newsViewModel.articles.count, 2)
        XCTAssertEqual(newsViewModel.articles.first?.title, "Singapore: Ex-minister Iswaran's corruption trial set to begin")
    }
    
    func testGetNewsWithCategoryAllSuccess() {
        
        mockNewsService.testResponse = mockNewsResponse
        
        newsViewModel.getNewsByCategory(category: .all)
        
        XCTAssertEqual(newsViewModel.articles.count, 2)
        XCTAssertEqual(newsViewModel.articles.first?.title, "Singapore: Ex-minister Iswaran's corruption trial set to begin")
    }
    
    func testGetNewsByCategoryFailure() {
        
        mockNewsService.isReturnError = true
        
        newsViewModel.getNewsByCategory(category: .business)
        
        XCTAssertTrue(newsViewModel.articles.isEmpty, "The articles should be empty")
    }
    
    func testGetEverythingBySearchSuccess() {
        
        mockNewsService.testResponse = mockNewsResponse
        
        newsViewModel.getEverything(searchText: "test")
        
        XCTAssertEqual(newsViewModel.articles.count, 2)
        XCTAssertEqual(newsViewModel.articles.first?.title, "Singapore: Ex-minister Iswaran's corruption trial set to begin")
    }
    
    
    func testGetEverythingBySearchFailure() {
        
        mockNewsService.isReturnError = true
        
        newsViewModel.getEverything(searchText: "test")
        
        XCTAssertTrue(newsViewModel.articles.isEmpty, "The articles should be empty")
    }
    
    func testGetEverythingWithoutSearchSuccess() {
        
        mockNewsService.testResponse = mockNewsResponse
        
        newsViewModel.getEverything()
        
        XCTAssertEqual(newsViewModel.articles.count, 2)
        XCTAssertEqual(newsViewModel.articles.first?.title, "Singapore: Ex-minister Iswaran's corruption trial set to begin")
    }
    
    func testGetEverythingWithoutSearchFailure() {
        
        mockNewsService.isReturnError = true
        
        newsViewModel.getEverything()
        
        XCTAssertTrue(newsViewModel.articles.isEmpty, "The articles should be empty")
    }

}
