//
//  GamepediaV2App.swift
//  GamepediaV2
//
//  Created by Samlo Berutu on 15/11/21.
//

import SwiftUI
import Core
import Home
import SearchGames
import Detail

@main
struct GamepediaV2App: App {
    let homeUsecase: CoreInteractor<String, [HomeGameModel], HomeGamesRepository<HomeGamesDataSource, GamesTransformer>> = Injection.init().provideHomeModule()
    let searchUsecase: CoreInteractor<String, [SearchModel], SearchRepository<SearchDataSource, SearchTransformer>> = Injection.init().provideSearchModule()
    let detailUsecase: CoreInteractor<String, DetailModel, DetailRepository<DetailDataSource, DetailTransformer>> = Injection.init().provideDetailModule()
    let favoriteUsecase: CoreFavoriteInteractor<[DetailScreenshotsModel], FavoriteModuleModel, DetailModel, FavoriteGameEntity, GameFavoriteRepository<FavoriteModuleDataSource, FavoriteTransformer>> = Injection.init().provideFavoriteModule()
    var body: some Scene {
        WindowGroup {
            let homePresenter = GetGamesPresenter(useCase: homeUsecase)
            let searchPresenter = GetGamesPresenter(useCase: searchUsecase)
            let detailPresenter = ModuleDetailPresenter(detail: DetailModel.detailModelSeeder, useCase: detailUsecase)
            let favoritePresenter = FavoriteModulPresenter(usecase: favoriteUsecase)
            ContentView()
                .environmentObject(searchPresenter)
                .environmentObject(homePresenter)
                .environmentObject(detailPresenter)
                .environmentObject(favoritePresenter)
        }
    }
}
