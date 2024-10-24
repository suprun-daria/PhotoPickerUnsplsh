//
//  UnsplashPhotosEndpoint.swift
//  PhotoPicker
//
//  Created by daria.suprun on 15.10.2024.
//

import Foundation

enum UnsplashPhotosEndpoint: APIEndpoint {
    case getCollection(collectionId: String)
    case getPhotosBy(searchString: String)
    
    var baseURL: URL {
        return URL(string: AppConfig.unsplshShared.apiURL)!
    }
    
    var path: String {
        switch self {
        case .getCollection(collectionId: let collectionId):
            return "/collections/\(collectionId)/photos"
        case .getPhotosBy:
            return "/search/photos"
        }
    }
    
    var shouldBeProceedAsList: Bool {
        switch self {
        case .getCollection:
            return false
        case .getPhotosBy:
            return true
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getCollection:
            return .get
        case .getPhotosBy:
            return .get
        }
    }
    
    var headers: [String: String]? {
        return ["Authorization": "Client-ID \(AppConfig.unsplshShared.accessKey)"]
    }
    
    var parameters: [URLQueryItem]? {
        switch self {
        case .getCollection(collectionId: let collectionId):
            return [
                URLQueryItem(name: "id", value: collectionId)
            ]
        case .getPhotosBy(searchString: let searchString):
            return [
                URLQueryItem(name: "query", value: searchString),
                URLQueryItem(name: "content_filter", value: AppConfig.unsplshShared.contentFilterLevel.rawValue)
            ]
        }
    }
}
