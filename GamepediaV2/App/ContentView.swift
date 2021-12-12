//
//  ContentView.swift
//  GamepediaV2
//
//  Created by Samlo Berutu on 20/11/21.
//

import SwiftUI
import Core
import Home
import SearchGames
import Detail

struct ContentView: View {
    // after implement Module
    @EnvironmentObject var moduleHomePresenter: GetGamesPresenter
    <String,
     HomeGameModel,
     CoreInteractor<String,
                    [HomeGameModel],
                    HomeGamesRepository<HomeGamesDataSource,
                                        GamesTransformer>>>
    @EnvironmentObject var moduleSearchPresenter: GetGamesPresenter
    <String,
     SearchModel,
     CoreInteractor<String,
                    [SearchModel],
                    SearchRepository<SearchDataSource,
                                     SearchTransformer>>>
    @EnvironmentObject var moduleDetailPresenter: ModuleDetailPresenter
    <String,
     DetailModel,
     CoreInteractor<String,
                    DetailModel,
                    DetailRepository<DetailDataSource,
                                     DetailTransformer>>>
    @EnvironmentObject var moduleFavoritePresenter: FavoriteModulPresenter
    <[DetailScreenshotsModel],
     FavoriteModuleModel,
     DetailModel,
     FavoriteGameEntity,
     CoreFavoriteInteractor<[DetailScreenshotsModel],
                            FavoriteModuleModel,
                            DetailModel,
                            FavoriteGameEntity,
                            GameFavoriteRepository<FavoriteModuleDataSource,
                                                   FavoriteTransformer>>>
    var body: some View {
        TabView {
            HomeView(presenter: moduleHomePresenter)
                .tabItem {
                    Image(systemName: "house")
                    Text("Beranda")
                }
            SearchGameView(searchPresenter: moduleSearchPresenter)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Cari")
                }
            FavoriteView(presenter: moduleFavoritePresenter)
                .tabItem {
                    Image(systemName: "suit.heart")
                    Text("Favorit")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profil")
                }
        }
    }
}
