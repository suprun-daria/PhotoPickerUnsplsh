//
//  URLSessionAPIClient.swift
//  PhotoPicker
//
//  Created by daria.suprun on 15.10.2024.
//

import Foundation
import Combine

class URLSessionAPIClient<EndpointType: APIEndpoint>: APIClient {
    
    func request<T: Decodable>(_ endpoint: EndpointType, page: Int) -> AnyPublisher<T, Error> {
        
        var urlComponents = URLComponents(string:endpoint.baseURL.absoluteString)
        urlComponents?.path = endpoint.path
        
        var queries = endpoint.parameters
        queries?.append(URLQueryItem(name: "page", value: String(page)))
        queries?.append(URLQueryItem(name: "per_page", value: String(page*AppConfig.photoCountPerPage)))
        urlComponents?.queryItems = queries

        var request = URLRequest(url: (urlComponents?.url)!)
        request.httpMethod = endpoint.method.rawValue
        
        endpoint.headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { data, response -> Data in
                if let httpResponse = response as? HTTPURLResponse,
                      (300...505).contains(httpResponse.statusCode) {
                    throw APIError.init(from: httpResponse.statusCode)
                }
                if endpoint.shouldBeProceedAsList {
                    let photos = try JSONDecoder().decode(ListOfUnsplashPhoto.self, from: data)
                    return try JSONEncoder().encode(photos.results)
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
