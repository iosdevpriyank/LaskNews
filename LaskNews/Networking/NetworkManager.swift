//
//  NetworkManager.swift
//  LaskNews
//
//  Created by Akshat Gandhi on 22/09/24.
//

import Foundation
import Combine
import Alamofire

class NetworkManager: NewsServiceProtocol {
    
    private let apiKey: String = Constant.newsAPIKEY
    private let baseURL: String = Constant.newsAPIBASEURL
   
    static let shared = NetworkManager()
    private init(){}

    
    func getTopHeadlinesServiceData(category: NewsCategory) -> AnyPublisher<NewsResponse, NetworkErrors> {
        let url = baseURL + "top-headlines?category=\(category.rawValue)&apiKey=\(apiKey)"
        return AF.request(url, method: .get)
            .publishDecodable(type: NewsResponse.self, decoder: customJSONDecoder())
            .value()
            .mapError {_ in NetworkErrors.decoderError}
            .eraseToAnyPublisher()
    }
    
    func getEverythingServiceData(searchText q: String) -> AnyPublisher<NewsResponse, NetworkErrors> {
        let url = baseURL + "everything?q=\(q)&searchIn=title,content&sortBy=relevancy&apiKey=\(apiKey)"
        return AF.request(url, method: .get)
            .validate()
            .responseData(completionHandler: { response in
                if let statusCode = response.response?.statusCode {
                    print("Status Code: \(statusCode)")
                }
                if let data = response.data, let jsonString = String(data: data, encoding: .utf8) {
                    print("Response JSON: \(jsonString)")
                } else {
                    print("No data or unable to decode response to string.")
                }
            })
            .publishDecodable(type: NewsResponse.self, decoder: customJSONDecoder())
            .value()
            .mapError { error in
                if case let .responseSerializationFailed(reason) = error {
                    switch reason {
                    case .decodingFailed(let decodingError):
                        if let decodingError = decodingError as? DecodingError {
                            switch decodingError {
                            case .keyNotFound(let key, let context):
                                print("Key '\(key)' not found:", context.debugDescription)
                            case .typeMismatch(let type, let context):
                                print("Type mismatch for type '\(type)':", context.debugDescription)
                            case .valueNotFound(let value, let context):
                                print("Value '\(value)' not found:", context.debugDescription)
                            case .dataCorrupted(let context):
                                print("Data corrupted:", context.debugDescription)
                            @unknown default:
                                print("Unknown decoding error:", decodingError.localizedDescription)
                            }
                        } else {
                            print("Decoding failed for unknown reason: \(decodingError.localizedDescription)")
                        }
                    default:
                        print("Other serialization error:", error)
                    }
                } else {
                    print("General error: \(error.localizedDescription)")
                }
                return NetworkErrors.decoderError
            }
            .eraseToAnyPublisher()
    }
    
    private func customJSONDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }

}

