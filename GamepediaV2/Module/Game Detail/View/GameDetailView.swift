//
//  GameDetailView.swift
//  GamepediaV2
//
//  Created by Samlo Berutu on 16/11/21.
//

import SwiftUI
import Core
import Detail

struct GameDetailView: View {
    @ObservedObject var presenter: ModuleDetailPresenter
    <String,
     DetailModel,
     CoreInteractor<String,
                    DetailModel,
                    DetailRepository<DetailDataSource,
                                     DetailTransformer>>>
    @ObservedObject var favoritePresenter: FavoriteModulPresenter
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
    let screenshot: [ShortScreenshotModel]
    let gameId: String
    var body: some View {
        ScrollView {
            if !presenter.isComplete {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .black))
                    .scaleEffect(2)
                    .frame(width: 200, height: 200, alignment: .center)
                    .onAppear {
                        presenter.getList(request: gameId)
                        favoritePresenter.isFavoriteGame(id: gameId)
                    }
            } else {
                VStack {
                    // MARK: - header
                    ZStack(alignment: .bottomTrailing) {
                        ScreenShotCard(screenShotURL: presenter.detail.backgroundImage, width: UIScreen.screenWidth)
                        HStack {
                            Spacer()
                            Spacer()
                            if favoritePresenter.isFavorite {
                                Button {
                                    favoritePresenter.deleteGameFavorite(id: gameId)
                                    favoritePresenter.isFavoriteGame(id: gameId)
                                } label: {
                                    Image(systemName: "suit.heart.fill" )
                                        .foregroundColor(.red)
                                        .imageScale(.large)
                                        .shadow(color: .white, radius: 1)
                                }
                            } else {
                                Button {
                                    favoritePresenter.addGameFavorite(game: presenter.detail, screenshot: GameMapper.mapDomainScreenshotsToDetailScreenshotsModel(domainScreenshots: screenshot))
                                    favoritePresenter.isFavoriteGame(id: gameId)
                                } label: {
                                    Image(systemName: "suit.heart" )
                                        .foregroundColor(.white)
                                        .imageScale(.large)
                                        .shadow(color: .black, radius: 1)
                                }
                            }
                            
                        }
                        .frame(width: 40, height: 40, alignment: .leading)
                        .padding(.trailing, 8)
                        .padding(.bottom, 8)
                    }
                    .frame(width: UIScreen.screenWidth, height: UIScreen.screenWidth/2)
                    // MARK: - paltform
                    HStack(spacing: 10) {
                        VStack(alignment: .leading, spacing: 10) {
                            PlatformLogo(parentPlarform: presenter.detail.parentPlatforms )
                            Text(presenter.detail.name )
                                .font(.headline)
                                .lineLimit(2)
                            Text(presenter.detail.released )
                                .font(.caption)
                                .lineLimit(1)
                            Link(destination: URL(string: presenter.detail.website ) ?? URL(string: "https://rawg.io/")!) {
                                Text(presenter.detail.website )
                                    .font(.caption)
                                    .lineLimit(1)
                                    .foregroundColor(.blue)
                            }
                        }
                        Spacer()
                        VStack(alignment: .center, spacing: 10) {
                            Spacer()
                            HStack(spacing: 5) {
                                Image(systemName: "star.fill")
                                    .accentColor(.yellow)
                                    .foregroundColor(.yellow)
                                Text("\(String(format: "%.1f", presenter.detail.rating ))/5")
                                    .font(.subheadline)
                                    .bold()
                                    .lineLimit(1)
                            }
                            Text("\(presenter.detail.reviewsCount ) Reviewers")
                                .font(.caption)
                            Link(destination: URL(string: presenter.detail.metacriticURL ) ?? URL(string: "https://rawg.io/")!) {
                                HStack {
                                    if presenter.detail.metacriticURL == "" {
                                        Text("RAWG")
                                            .font(.footnote)
                                            .foregroundColor(.white)
                                            .bold()
                                    } else {
                                        Image("metacritic")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 30, height: 30, alignment: .center)
                                        Text("Metacritic")
                                            .font(.footnote)
                                            .foregroundColor(.white)
                                            .bold()
                                    }
                                }
                                .padding(5)
                                .frame(height: 35, alignment: .leading)
                                .background(Color.black)
                                .cornerRadius(10)
                                .accentColor(.black)
                            }
                            Spacer()
                            
                        }
                    }
                    .frame(width: UIScreen.screenWidth - 40, height: 140, alignment: .leading)
                    // MARK: - Genre
                    HStack {
                        Text("Genre")
                            .bold()
                            .font(.subheadline)
                            .accentColor(Color.gray)
                            .opacity(0.5)
                        Spacer()
                    }
                    .frame(width: UIScreen.screenWidth - 32, height: 18)
                    GenreView(developerModel: presenter.detail.genres )
                    // MARK: - screenshoot preview
                    HStack {
                        Text("Screenshots")
                            .bold()
                            .font(.subheadline)
                            .accentColor(Color.gray)
                            .opacity(0.5)
                        Spacer()
                    }
                    .frame(width: UIScreen.screenWidth - 32, height: 18)
                    ScreenShootPreview(screenshot: screenshot)
                        .frame(height: (UIScreen.screenWidth-64)/2)
                    // MARK: - description
                    HStack {
                        Text("About")
                            .bold()
                            .font(.subheadline)
                            .accentColor(Color.gray)
                            .opacity(0.5)
                        Spacer()
                    }
                    .frame(width: UIScreen.screenWidth - 32, height: 18)
                    DescriptionText(presenter.detail.welcomeDescription, lineLimit: 4)
                        .frame(width: UIScreen.screenWidth - 32)
                    
                }
                
            }
        }
        .navigationBarTitle("Detail", displayMode: .inline)
    }
}
struct TabBarAccessor: UIViewControllerRepresentable {
    var callback: (UITabBar) -> Void
    private let proxyController = ViewController()

    func makeUIViewController(context: UIViewControllerRepresentableContext<TabBarAccessor>) ->
                              UIViewController {
        proxyController.callback = callback
        return proxyController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<TabBarAccessor>) {
    }

    typealias UIViewControllerType = UIViewController

    private class ViewController: UIViewController {
        var callback: (UITabBar) -> Void = { _ in }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            if let tabBar = self.tabBarController {
                self.callback(tabBar.tabBar)
            }
        }
    }
}
