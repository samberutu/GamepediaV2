//
//  ContentView.swift
//  GamepediaV2
//
//  Created by Samlo Berutu on 15/11/21.
//

import SwiftUI
import Core
import Home

struct HomeView: View {
    @ObservedObject var presenter: GetGamesPresenter
    <String,
     HomeGameModel,
     CoreInteractor<String,
                    [HomeGameModel],
                    HomeGamesRepository<HomeGamesDataSource,
                                        GamesTransformer>>>
    @State var pageNubmber = 1
    var body: some View {
        NavigationView {
            VStack {
                if presenter.list.isEmpty {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .black))
                        .scaleEffect(2)
                } else {
                    List {
                        ForEach(presenter.list, id: \.id) { game in
                            let domainSs = GameMapper.mapSSHomeModuleToDomain(ss: game.shortScreenshots)
                            self.linkBuilder(for: String(game.id), screenShots: domainSs) {
                                GameCard(game: game)
                            }
                        }
                        // MARK: - pages
                        HStack(alignment: .center) {
                            Spacer()
                            Button(action: {
                                if pageNubmber > 1 {
                                    presenter.list.removeAll()
                                    self.pageNubmber -= 1
                                    DispatchQueue.main.async {
                                        presenter.getList(request: String(pageNubmber))
                                    }
                                }
                            }, label: {
                                Image(systemName: "chevron.left")
                                    .imageScale(.large)
                                    .foregroundColor(pageNubmber > 1 ? .black : .white)
                            })
                                .disabled(pageNubmber <= 1 ? true : false)
                                .buttonStyle(PlainButtonStyle())
                            Text("Page \(pageNubmber)")
                                .font(.headline)
                                .padding(.horizontal, 5)
                            Button(action: {
                                presenter.list.removeAll()
                                self.pageNubmber += 1
                                DispatchQueue.main.async {
                                    presenter.getList(request: String(pageNubmber))
                                }
                            }, label: {
                                Image(systemName: "chevron.right")
                                    .imageScale(.large)
                            })
                                .buttonStyle(PlainButtonStyle())
                            Spacer()
                        }
                        .padding(.vertical, 8)
                        .background(Color.clear)
                    }
                }
            }
            .listStyle(InsetListStyle())
            .navigationBarTitle(
                Text("Gamepedia"),
                displayMode: .large
            )
        }
        .onAppear {
            presenter.getList(request: String(pageNubmber))
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
