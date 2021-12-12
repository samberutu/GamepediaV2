//
//  GamepediaInjection.swift
//  GamepediaV2
//
//  Created by Samlo Berutu on 15/11/21.
//

import Foundation
import Core
import Home
import SearchGames
import Detail
import RealmSwift

final class Injection: NSObject {
    // after using module
    func provideHomeModule<U: CoreUseCase>() -> U where U.Request == String, U.Response == [HomeGameModel] {
        let remote = HomeGamesDataSource(endpoint: ConstantUtils.baseURL, key: ConstantUtils.apiKey, page_size: ConstantUtils.pageSize)
        let mapper = GamesTransformer()
        let repository = HomeGamesRepository(remoteDataSource: remote, mapper: mapper)
        return CoreInteractor(repository: repository) as! U
    }
    func provideSearchModule<U: CoreUseCase>() -> U where U.Request == String, U.Response == [SearchModel] {
        let remote = SearchDataSource(endpoint: ConstantUtils.baseURL, key: ConstantUtils.apiKey)
        let mapper = SearchTransformer()
        let repository = SearchRepository(remoteDataSource: remote, mapper: mapper)
        
        return CoreInteractor(repository: repository) as! U
    }
    func provideDetailModule<U: CoreUseCase>() -> U where U.Request == String, U.Response == DetailModel {
        let remote = DetailDataSource(endpoint: ConstantUtils.baseURL, key: ConstantUtils.apiKey)
        let mapper = DetailTransformer()
        let repository = DetailRepository(remoteDataSource: remote, mapper: mapper)
        return CoreInteractor(repository: repository) as! U
    }
    func provideFavoriteModule<U: CoreFavoriteUseCase>() -> U where U.Request == [DetailScreenshotsModel], U.Response == FavoriteModuleModel, U.Domain == DetailModel, U.Entity == FavoriteGameEntity {
        let realm = try! Realm()
        let locale = FavoriteModuleDataSource(realm: realm)
        let mapper = FavoriteTransformer()
        let repository = GameFavoriteRepository(localeDataSource: locale, mapper: mapper)
        return CoreFavoriteInteractor(repository: repository) as! U
    }
}
