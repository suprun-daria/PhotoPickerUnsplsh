//
//  APIEndpoint.swift
//  PhotoPicker
//
//  Created by daria.suprun on 15.10.2024.
//

import Foundation

protocol APIEndpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var shouldBeProceedAsList: Bool { get }
    var headers: [String: String]? { get }
    var parameters: [URLQueryItem]? { get }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum APIError: Error {
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case serverUnreachable
    case serverUnavailable
    
    init(from statusCode: Int) {
        switch statusCode {
        case 400:
            self = APIError.badRequest
        case 401:
            self = APIError.unauthorized
        case 403:
            self = APIError.forbidden
        case 404:
            self = APIError.notFound
        case 500:
            self = APIError.serverUnreachable
        default:
            self = APIError.serverUnavailable
        }
    }
    
    var errorMessage: String {
        switch self {
        case .badRequest:
            return String(localized:"api_error_bad_request")
        case .unauthorized:
            return String(localized:"api_error_unauthorized")
        case .forbidden:
            return String(localized:"api_error_forbidden")
        case .notFound:
            return String(localized:"api_error_not_found")
        case .serverUnreachable:
            return String(localized:"api_error_server_unreachable")
        case .serverUnavailable:
            return String(localized:"api_error_server_unavailable")
        }
    }
}
