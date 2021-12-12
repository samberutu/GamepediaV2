//
//  File.swift
//  
//
//  Created by Samlo Berutu on 12/12/21.
//

import Foundation
import Combine
import Core
public class FavoriteModulPresenter<
        Request,
        Response,
        Domain,
        Entity,
        Interactor: CoreFavoriteUseCase>: ObservableObject
where
Interactor.Request == Request,
Interactor.Response == Response,
Interactor.Domain == Domain,
Interactor.Entity == Entity {
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let _useCase: Interactor
    @Published public var favorite: [Response] = []
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    @Published public var isFavorite: Bool = false
    public init(usecase: Interactor) {
        self._useCase = usecase
    }
    public func getGamesFavorite() {
        isLoading = true
        _useCase.getGamesFavorite()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.isLoading = false
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { favorite in
                self.favorite = favorite
            })
            .store(in: &cancellables)
    }
    public func addGameFavorite(game: Domain, screenshot: Request) {
        _useCase.addGameFavorite(game: game, screenshot: screenshot)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { favorite in
                print("add favorite: ", favorite)
            })
            .store(in: &cancellables)
    }
    public func deleteGameFavorite(id: String) {
        _useCase.deleteGameFavorite(id: id)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { favorite in
                print("delete: ", favorite)
            })
            .store(in: &cancellables)
    }
    public func isFavoriteGame(id: String) {
        _useCase.isFavoriteGame(id: id)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.isFavorite = false
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { favorite in
                self.isFavorite = favorite
            })
            .store(in: &cancellables)
    }
    
}
