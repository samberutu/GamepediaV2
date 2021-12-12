//
//  RouteToDetailview.swift
//  GamepediaV2
//
//  Created by Samlo Berutu on 15/11/21.
//

import SwiftUI
import Core
import Detail
class RouteToDetailview {
    func makeDetailView(_ gameId: String, screenshots: [ShortScreenshotModel]) -> some View {
        let favoriteUsecase: CoreFavoriteInteractor<[DetailScreenshotsModel], FavoriteModuleModel, DetailModel, FavoriteGameEntity, GameFavoriteRepository<FavoriteModuleDataSource, FavoriteTransformer>> = Injection.init().provideFavoriteModule()
        let detailUsecase: CoreInteractor<String, DetailModel, DetailRepository<DetailDataSource, DetailTransformer>> = Injection.init().provideDetailModule()
        let detailPresenter = ModuleDetailPresenter(detail: DetailModel.detailModelSeeder, useCase: detailUsecase)
        let favoritePresenter = FavoriteModulPresenter(usecase: favoriteUsecase)
        return GameDetailView(presenter: detailPresenter, favoritePresenter: favoritePresenter, screenshot: screenshots, gameId: gameId)
    }
}
