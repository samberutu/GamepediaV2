//
//  File.swift
//  
//
//  Created by Samlo Berutu on 10/12/21.
//

import Foundation
import Combine
import Core
import Alamofire
public struct SearchDataSource: CoreRemoteDataSource {
    public typealias Request = String
    public typealias Response = [SearchGameResult]
    private let _endpoint: String
    private let _key: String
    public init(endpoint: String, key: String) {
        _endpoint = endpoint
        _key = key
    }
    public func execute(request: Request?) -> AnyPublisher<Response, Error> {
        return Future<Response, Error> { completion in
            guard let request = request else { return completion(.failure(URLError.invalidRequest)) }
            var component = URLComponents(string: _endpoint)
            component?.queryItems = [
                URLQueryItem(name: "key", value: _key),
                URLQueryItem(name: "search", value: request )
            ]
            if let url = component?.url {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: SearchResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.results))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
}
