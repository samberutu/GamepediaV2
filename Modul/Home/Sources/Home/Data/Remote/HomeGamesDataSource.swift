//
//  File.swift
//  
//
//  Created by Samlo Berutu on 08/12/21.
//

import Foundation
import Alamofire
import Combine
import Core

public struct HomeGamesDataSource: CoreRemoteDataSource {
    public typealias Request = String
    public typealias Response = [HomeGameResponse]
    private let _endpoint: String
    private let _key: String
    private let _page_size: String
    public init(endpoint: String, key: String, page_size: String) {
        _endpoint = endpoint
        _key = key
        _page_size = page_size
    }
    public func execute(request: Request?) -> AnyPublisher<[HomeGameResponse], Error> {
        return Future<[HomeGameResponse], Error> { completion in
            guard let request = request else { return completion(.failure(URLError.invalidRequest)) }
            var component = URLComponents(string: _endpoint)
            component?.queryItems = [
                URLQueryItem(name: "key", value: _key),
                URLQueryItem(name: "page", value: request ),
                URLQueryItem(name: "page_size", value: _page_size)
            ]
            if let url = component?.url {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: HomeGamesResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.games))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
}
