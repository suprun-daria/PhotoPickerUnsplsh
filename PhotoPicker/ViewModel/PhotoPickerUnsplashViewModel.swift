//
//  File.swift
//  PhotoPicker
//
//  Created by daria.suprun on 8.10.2024.
//

import Foundation
import SwiftUI
import Combine

class PhotoPickerUnsplashViewModel: ObservableObject {
    
    @Published var items: [UnsplashPhoto] = []
    @Published var isError: Bool = false
    var errorMessage: String = ""
    
    private var pageCount = 0
    private var cancellables = Set<AnyCancellable>()
    let unsplashService: UnsplashServiceProtocol

    init(with unsplashService: UnsplashServiceProtocol) {
        self.unsplashService = unsplashService
    }
    
    private func prepareForFetchPage() {
        errorMessage = ""
        isError = false
        
        pageCount += 1
    }
    
    subscript(index: Int) -> UnsplashPhoto? {
        get {
            guard index < items.count else {
                return nil
            }
            return items[index]
        }
    }
    
    func resetModel() {
        errorMessage = ""
        isError = false
        pageCount = 0
    }
    
    func fetchPhotoBy(collectionId: String) {
        prepareForFetchPage()
        
        if collectionId.count == 0 {
            self.errorMessage = String(localized: "error_empty_collection_identification")
            self.isError = true
            return
        }
        
        unsplashService.getCollection(collectionId: collectionId, page: pageCount)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] status in
                switch status {
                case .failure(let error):
                    self?.errorMessage = (error as! APIError).errorMessage
                    self?.isError = true
                    break
                case .finished:
                    self?.isError = false
                    break
                }
             }, receiveValue: { [weak self] data in
                 self?.items.append(contentsOf: data)
                 self?.isError = false
             }).store(in: &cancellables)
    }
    
    func fetchPhotosBy(string: String) {
        prepareForFetchPage()
        
        if string.count == 0 {
            self.errorMessage = String(localized: "error_empty_search_string")
            self.isError = true
            return
        }
        
        unsplashService.getPhotos(searchString: string, page: pageCount)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] status in
                switch status {
                case .failure(let error):
                    self?.errorMessage = (error as! APIError).errorMessage
                    self?.isError = true
                    break
                case .finished:
                    self?.isError = false
                    break
                }
             }, receiveValue: { [weak self] data in
                 self?.items.append(contentsOf: data)
                 self?.isError = false
             }).store(in: &cancellables)
    }
}
