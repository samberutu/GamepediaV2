//
//  SearchGameView.swift
//  GamepediaV2
//
//  Created by Samlo Berutu on 20/11/21.
//

import SwiftUI
import Core
import SearchGames

struct SearchGameView: View {
    @ObservedObject var searchPresenter: GetGamesPresenter
    <String,
     SearchModel,
     CoreInteractor<String,
                    [SearchModel],
                    SearchRepository<SearchDataSource,
                                     SearchTransformer>>>
    @State var query = ""
    var body: some View {
        NavigationView {
            VStack {
                searchBar
                searchResultView
            }
            .navigationBarHidden(true)
        }
        .onAppear(perform: {
            searchPresenter.getList(request: query)
        })
        .accentColor(.black)
    }
}
extension SearchGameView {
    var searchBar: some View {
        HStack {
            HStack {
                if query == ""{
                    Image(systemName: "magnifyingglass")
                        .imageScale(.medium)
                        .accentColor(.gray)
                        .opacity(0.3)
                }
                TextField("Cari Game", text: $query)
                    .disableAutocorrection(true)
            }
            .padding()
            .background(Color(.systemGray5))
            .cornerRadius(6)
            Button(action: {
                self.searchPresenter.list.removeAll()
                self.searchPresenter.getList(request: query)
            }, label: {
                Text("Cari")
            })
        }
        .padding(.horizontal)
    }
    
    var searchResultView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .foregroundColor(.white)
            if !searchPresenter.list.isEmpty {
                List {
                    ForEach(searchPresenter.list, id: \.id) { game in
                        let domainSs = GameMapper.mapSearchScreenshotsModelToDomainScreenshots(searchScreenshotsModel: game.shortScreenshots)
                        self.linkBuilder(for: String(game.id), screenShots: domainSs) {
                            Text(game.name)
                                .lineLimit(1)
                        }
                    }
                }
            } else {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .black))
                    .scaleEffect(2)
            }
        }
        .listStyle(InsetListStyle())
        .padding(.top, 8)
    }
    func linkBuilder<Content: View>( for gameId: String, screenShots: [ShortScreenshotModel], @ViewBuilder content: () -> Content ) -> some View {
        HStack {
            NavigationLink {
                RouteToDetailview.init().makeDetailView(gameId, screenshots: screenShots)
            } label: {
                content()
            }
        }
    }
}
