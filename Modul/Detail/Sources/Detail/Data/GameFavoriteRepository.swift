//
//  File.swift
//  
//
//  Created by Samlo Berutu on 12/12/21.
//

import Combine
import Core
public struct GameFavoriteRepository<
    DataSource: CoreLocaleDataSource,
    Mapper: CoreFavoriteMapper> : LocaleRepository
where
DataSource.Request == [DetailScreenshotsModel],
DataSource.Response == FavoriteModuleModel,
DataSource.Domain == DetailModel ,
DataSource.Entity == FavoriteGameEntity,
Mapper.Request == [DetailScreenshotsModel],
Mapper.Response == FavoriteModuleModel,
Mapper.Domain == DetailModel,
Mapper.Entity == FavoriteGameEntity {
    
    public typealias Request = [DetailScreenshotsModel]
    public typealias Response = FavoriteModuleModel
    public typealias Domain = DetailModel
    public typealias Entity = FavoriteGameEntity
    
    private let _localeDataSource: DataSource
    private let _mapper: Mapper
    public init(localeDataSource: DataSource, mapper: Mapper) {
        _localeDataSource = localeDataSource
        _mapper = mapper
    }
    public func getGamesFavorite() -> AnyPublisher<[FavoriteModuleModel], Error> {
        return _localeDataSource.getGamesFavorite()
            .map { _mapper.transformEntityToDomain(entity: $0) }
            .eraseToAnyPublisher()
    }
    public func addGameFavorite(game: DetailModel, screenshot: [DetailScreenshotsModel]) -> AnyPublisher<Bool, Error> {
        return _localeDataSource.addGameFavorite(game: game, screenshot: screenshot)
            .eraseToAnyPublisher()
    }
    
    public func deleteGameFavorite(id: String) -> AnyPublisher<Bool, Error> {
        return _localeDataSource.deleteGameFavorite(id: id)
            .eraseToAnyPublisher()
    }
    
    public func isFavoriteGame(id: String) -> AnyPublisher<Bool, Error> {
        return _localeDataSource.isFavoriteGame(id: id)
            .eraseToAnyPublisher()
    }
}
