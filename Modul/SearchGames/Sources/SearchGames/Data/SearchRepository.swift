//
//  File.swift
//  
//
//  Created by Samlo Berutu on 10/12/21.
//

import Combine
import Core
// 1
public struct SearchRepository<
    DataSource: CoreRemoteDataSource,
    Mapper: CoreMapper> : CoreRepository
where
// 2
    DataSource.Request == String,
    DataSource.Response == [SearchGameResult],
    Mapper.Request == [SearchGameResult],
    Mapper.Domain == [SearchModel] {
    // 3
    public typealias Request = String
    public typealias Response = [SearchModel]
    
    private let _remoteDataSource: DataSource
    private let _mapper: Mapper
    public init(remoteDataSource: DataSource, mapper: Mapper) {
        self._remoteDataSource =  remoteDataSource
        self._mapper = mapper
    }
    // 4
    public func execute(request: String?) -> AnyPublisher<Response, Error> {
        return _remoteDataSource.execute(request: request)
            .map { _mapper.transformResponseToDomain(request: $0) }
            .eraseToAnyPublisher()
    }
}
