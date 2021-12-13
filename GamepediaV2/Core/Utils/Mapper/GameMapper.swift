//
//  GameMapper.swift
//  GamepediaV2
//
//  Created by Samlo Berutu on 15/11/21.
//

import Foundation
import Home
import SearchGames
import Detail

final class GameMapper {
    
    // MARK: - After add Module
    static func mapHomeScreenshotsModelToDomainScreenshots(homeScreenshotsModel: [HomeShortScreenshotModel]) -> [ShortScreenshotModel] {
        return homeScreenshotsModel.map { screenshot in
            return ShortScreenshotModel(id: screenshot.id, image: screenshot.image)
        }
    }
    static func mapSearchScreenshotsModelToDomainScreenshots(searchScreenshotsModel: [SearchShortScreenshotModel]) -> [ShortScreenshotModel] {
        return searchScreenshotsModel.map { screenshot in
            return ShortScreenshotModel(id: screenshot.id, image: screenshot.image)
        }
    }
    static func mapDomainScreenshotsToDetailScreenshotsModel(domainScreenshots: [ShortScreenshotModel]) -> [DetailScreenshotsModel] {
        return domainScreenshots.map { screenshot in
            return DetailScreenshotsModel(id: screenshot.id, image: screenshot.image)
        }
    }
    static func mapFavoriteScreenshotsModelToDomainScreenshots(favoriteScreenshotsModel: [FavoriteScreenshotsModel]) -> [ShortScreenshotModel] {
        return favoriteScreenshotsModel.map { screenshot in
            return ShortScreenshotModel(id: Int(screenshot.id) ?? 0, image: screenshot.image)
        }
    }
    static func mapFavoriteModelToHomeModel(favorite: FavoriteModuleModel) -> HomeGameModel {
        
        return HomeGameModel(
            id: Int(favorite.id) ?? 0,
            name: favorite.name,
            released: favorite.released,
            backgroundImage: favorite.backgroundImange,
            rating: Double(favorite.rating) ?? 0,
            ratingTop: Int(favorite.ratingTop) ?? 0,
            reviewsCount: Int(favorite.reviewCount) ?? 0,
            shortScreenshots: favorite.shortScreenshots.map { screenshot in
                return HomeShortScreenshotModel(id: Int(screenshot.id) ?? 0, image: screenshot.image)
            })
    }
}
