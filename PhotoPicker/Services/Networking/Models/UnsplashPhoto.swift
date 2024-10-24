//
//  UnsplashPhoto.swift
//  PhotoPicker
//
//  Created by daria.suprun on 16.10.2024.
//

import UIKit

struct UnsplashPhoto: Codable, Identifiable {
    
    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case height
        case width
        case hexColor = "color"
        case urls
        case links
        case likesCount = "likes"
    }
    
    public enum URLKind: String, Codable {
        case raw
        case full
        case regular
        case small
        case thumb
    }
    
    public enum LinkKind: String, Codable {
        case own = "self"
        case html
        case download
        case downloadLocation = "download_location"
    }
    
    public let id = UUID()
    
    private let identifier: String
    private let height: Int
    private let width: Int
    private let hexColor: String
    private let urls: [String: String]
    private let links: [String: String]
    private let likesCount: Int
    
    func urlBy(kind: URLKind) -> String? {
        return urls[kind.rawValue];
    }
}

extension UnsplashPhoto: Equatable {
    public static func == (lhs: UnsplashPhoto, rhs: UnsplashPhoto) -> Bool {
        return lhs.id == rhs.id && lhs.id == rhs.id
    }
}
