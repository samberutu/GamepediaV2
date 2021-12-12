//
//  GameDetailUseCase.swift
//  GamepediaV2Tests
//
//  Created by Samlo Berutu on 24/11/21.
//

import XCTest
import RxSwift

@testable import GamepediaV2
class GameDetailUseCaseTests: XCTest {
    var remoteRepository = Injection.init().provideRepositoryForTesting()
    var localeRepository = Injection.init().provideFavorite()
    private let disposeBag = DisposeBag()
    static var gameId: String = "3498" // gameID GTA V
    static var gameName = "Grand Theft Auto V"
    func testGameDetailFromUseCase() throws {
        // given
        let usecase = DetailInteractorMoc(repository: remoteRepository, localeRepository: FavoriteRepository())
        // when
        var result = GameDetailModel.detailModelSeeder
        usecase.getGameDetail(gameId: GameDetailUseCaseTests.gameId)
            .observe(on: MainScheduler.instance)
            .subscribe { myResult in
                result = myResult
            }onError: { error in
                print(error)
            } onCompleted: {
                print("sukses")
            }
            .disposed(by: disposeBag)
        XCTAssert(usecase.verify())
        // then
        DispatchQueue.main.asyncAfter(deadline: .now()+5) {
            XCTAssert(result.name == GameDetailUseCaseTests.gameName)
        }
    }
}

extension GameDetailUseCaseTests {
    class DetailInteractorMoc: DetailUseCase {
        private let remoterRepository: GameRepositoryProtocol
        private let localeRepository: FavoriteRepositoryProtocol
        required init (repository: GameRepositoryProtocol, localeRepository: FavoriteRepositoryProtocol) {
            self.remoterRepository = repository
            self.localeRepository = localeRepository
        }
        // another test variable
        var getGameDetailfunctionWasCalled = false
        
        // remote
        func getGameDetail(gameId: String) -> Observable<GameDetailModel> {
            getGameDetailfunctionWasCalled = true
            return remoterRepository.getGameDetail(gameId: gameId)
        }
        // MARK: - Locale Data
        func saveToLocale() {
            localeRepository.save()
        }
        
        func getGamesFromLocale() -> [FavoriteModel] {
            return localeRepository.getGames()
        }
        
        func getScreenshotToLocale() -> [ShortScreenshots] {
            return localeRepository.getScreenshot()
        }
        
        func addGameFavoritetoLocale(game: GameModel, dateSelected: Date, gameId: String) -> Bool {
            return localeRepository.addGameFavorite(game: game, dateSelected: dateSelected, gameId: gameId)
        }
        
        func addScreenshotsFromLocale(screenshots: [ShortScreenshots]) {
            localeRepository.addScreenshots(screenshots: screenshots)
        }
        
        func deleteGameFavorite(id: Int) {
            localeRepository.deleteGameFavorite(id: id)
        }
        
        func isFavoriteGame(id: Int) -> Bool {
            return localeRepository.isFavoriteGame(id: id)
        }
        
        func verify() -> Bool {
            return getGameDetailfunctionWasCalled
        }
    }
}
