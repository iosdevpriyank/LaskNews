//
//  NetworkErrors.swift
//  LaskNews
//
//  Created by Akshat Gandhi on 22/09/24.
//

import Foundation
import Alamofire

enum NetworkErrors: Error{
    case urlError
    case responseError
    case decoderError
    case unknownError
}
struct NetworkError: Error {
  let initialError: AFError
  let backendError: BackendError?
}

struct BackendError: Codable, Error {
    var status: String
    var message: String
}
