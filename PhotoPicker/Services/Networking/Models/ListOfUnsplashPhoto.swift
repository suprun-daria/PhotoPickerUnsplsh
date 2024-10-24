//
//  ListOfUnsplashPhoto.swift
//  PhotoPicker
//
//  Created by daria.suprun on 21.10.2024.
//

import Foundation

struct ListOfUnsplashPhoto: Codable {
    
    let total: Int
    let totalPages: Int
    let results: [UnsplashPhoto]
    
    private enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}
