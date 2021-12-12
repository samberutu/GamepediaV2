//
//  FavoriteVie.swift
//  GamepediaV2
//
//  Created by Samlo Berutu on 22/11/21.
//

import SwiftUI
import Detail
import Core

struct FavoriteView: View {
    @ObservedObject var presenter: FavoriteModulPresenter
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
        NavigationView {
            VStack {
                if presenter.favorite.isEmpty {
                    VStack {
                        Image(systemName: "heart.slash.fill")
                            .resizable()
                            .frame(width: 100, height: 100, alignment: .center)
                        Text("Kosong")
                            .font(.subheadline)
                            .bold()
                    }
                } else {
                    List {
                        ForEach(presenter.favorite, id: \.id) { game in
                            let domainModel = GameMapper.mapFavoriteModuleModelToHomeGameModel(favorite: game)
                            self.linkBuilder(for: game.id, screenShots: GameMapper.mapFavoriteSsToShortSsModel(ss: game.shortScreenshots)) {
                                GameCard(game: domainModel)
                            }
                        }
                    }
                }
            }
            .onAppear {
                presenter.getGamesFavorite()
            }
            .listStyle(InsetListStyle())
            .navigationTitle("Favorite")
            .navigationBarTitleDisplayMode(.large)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .accentColor(.black)
    }
    
    func linkBuilder<Content: View>( for gameId: String, screenShots: [ShortScreenshotModel], @ViewBuilder content: () -> Content ) -> some View {
        ZStack {
            content()
            NavigationLink {
                RouteToDetailview.init().makeDetailView(gameId, screenshots: screenShots)
            } label: {
                EmptyView()
            }
            .frame(width: 0, height: 0).opacity(0.0)
        }
    }
}
