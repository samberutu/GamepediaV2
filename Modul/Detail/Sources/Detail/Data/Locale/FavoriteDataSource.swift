//
//  File.swift
//  
//
//  Created by Samlo Berutu on 12/12/21.
//

import Foundation
import RealmSwift
import Combine
import Core
public struct FavoriteModuleDataSource: CoreLocaleDataSource {
    
    public typealias Request = [DetailScreenshotsModel]

    public typealias Response = FavoriteModuleModel
    
    public typealias Domain = DetailModel
    
    public typealias Entity = FavoriteGameEntity
    
    private let _realm: Realm
    
    public init(realm: Realm) {
        _realm = realm
    }
    
    public func getGamesFavorite() -> AnyPublisher<[FavoriteGameEntity], Error> {
        return Future<[FavoriteGameEntity], Error> { completion in
            let favorites: Results<FavoriteGameEntity> = {
                _realm.objects(FavoriteGameEntity.self)
            }()
            completion(.success(favorites.toArray(ofType: FavoriteGameEntity.self)))
        }
        .eraseToAnyPublisher()
    }
    
    public func addGameFavorite(game: Domain, screenshot: Request) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            let newFavorite = FavoriteTransformer.init().transformDomainToEntity(request: screenshot, domain: game)
            do {
                try _realm.write {
                    _realm.add(newFavorite, update: .all)
                    completion(.success(true))
                }
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }
    
    public func deleteGameFavorite(id: String) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let favorited = {
                _realm.objects(FavoriteGameEntity.self).filter("id = '\(id)'")
            }().first {
                do {
                    try _realm.write({
                        _realm.delete(favorited)
                    })
                    completion(.success(true))
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }
    
    public func isFavoriteGame(id: String) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let _ = {
                _realm.objects(FavoriteGameEntity.self).filter("id = '\(id)'")
            }().first {
                completion(.success(true))
            } else {
                completion(.failure(DatabaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }
}
