//
//  APIClient.swift
//  PhotoPicker
//
//  Created by daria.suprun on 15.10.2024.
//

import Foundation
import Combine

protocol APIClient {
    associatedtype EndpointType: APIEndpoint
    func request<T: Decodable>(_ endpoint: EndpointType, page: Int) -> AnyPublisher<T, Error>
}
