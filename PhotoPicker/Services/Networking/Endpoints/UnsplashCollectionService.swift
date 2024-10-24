//
//  UnsplashCollectionService.swift
//  PhotoPicker
//
//  Created by daria.suprun on 15.10.2024.
//

import Foundation
import Combine

protocol UnsplashServiceProtocol {
    func getCollection(collectionId: String, page: Int) -> AnyPublisher<[UnsplashPhoto], Error>
    func getPhotos(searchString: String, page: Int) -> AnyPublisher<[UnsplashPhoto], Error>
}

class UnsplashService: UnsplashServiceProtocol {
    let apiClient = URLSessionAPIClient<UnsplashPhotosEndpoint>()
    
    func getCollection(collectionId: String, page: Int) -> AnyPublisher<[UnsplashPhoto], Error> {
        return apiClient.request(.getCollection(collectionId: collectionId), page: page)
    }
    
    func getPhotos(searchString: String, page: Int) -> AnyPublisher<[UnsplashPhoto], Error> {
        apiClient.request(.getPhotosBy(searchString: searchString), page: page)
    }
}
