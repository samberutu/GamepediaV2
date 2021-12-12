//
//  File.swift
//  
//
//  Created by Samlo Berutu on 08/12/21.
//

import Combine
import Core
// 1
public struct HomeGamesRepository<
    DataSource: CoreRemoteDataSource,
    MyMapper: CoreMapper> : CoreRepository
where
// 2
    DataSource.Request == String,
    DataSource.Response == [HomeGameResponse],
    MyMapper.Request == [HomeGameResponse],
    MyMapper.Domain == [HomeGameModel] {
    // 3
    public typealias Request = String
    public typealias Response = [HomeGameModel]
    
    private let _remoteDataSource: DataSource
    private let _mapper: MyMapper
    public init(remoteDataSource: DataSource, mapper: MyMapper) {
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
