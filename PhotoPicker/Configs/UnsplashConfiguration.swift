//
//  PhotoPickerConfig.swift
//  PhotoPicker
//
//  Created by daria.suprun on 08.10.2024.
//

import Foundation

public enum ContentFilterLevel: String {
    case low
    case high
}

public struct UnsplashConfiguration {

    public var accessKey = "s3tN2Uij8tX6rRa-ZSu9ugpRs6INbW_RhkptbhTxjOQ"
    public var secretKey = "eUrqdlXjRkzUAoiY3Q5DN9wYySry92ERnY3QyxIoaPw"
    public var query: String?
    public var allowsMultipleSelection = false
    public var contentFilterLevel = defaultContentFilterLevel
    public static let defaultContentFilterLevel: ContentFilterLevel = .low
    let apiURL = "https://api.unsplash.com"
    let editorialCollectionId = "317099" // application id = 665472

    public init(accessKey: String,
                secretKey: String,
                query: String? = nil,
                allowsMultipleSelection: Bool = false,
                contentFilterLevel: ContentFilterLevel = defaultContentFilterLevel
    ) {
        self.accessKey = accessKey
        self.secretKey = secretKey
        self.query = query
        self.allowsMultipleSelection = allowsMultipleSelection
        self.contentFilterLevel = contentFilterLevel
    }

    init() {}

}
