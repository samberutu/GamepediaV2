//
//  File.swift
//  
//
//  Created by Samlo Berutu on 10/12/21.
//

import Combine
import Core
// 1
public struct DetailRepository<
    DataSource: CoreRemoteDataSource,
    Mapper: CoreMapper> : CoreRepository
where
// 2
    DataSource.Request == String,
    DataSource.Response == DetailResponse,
    Mapper.Request == DetailResponse,
    Mapper.Domain == DetailModel {
    // 3
    public typealias Request = String
    public typealias Response = DetailModel
    
    private let _remoteDataSource: DataSource
    private let _mapper: Mapper
    public init(remoteDataSource: DataSource, mapper: Mapper) {
        self._remoteDataSource =  remoteDataSource
        self._mapper = mapper
    }
    // 4
    public func execute(request: Request?) -> AnyPublisher<Response, Error> {
        return _remoteDataSource.execute(request: request)
            .map { _mapper.transformResponseToDomain(request: $0) }
            .eraseToAnyPublisher()
    }
}
