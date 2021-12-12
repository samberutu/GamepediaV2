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
    static func mapSSHomeModuleToDomain(ss: [HomeShortScreenshotModel]) -> [ShortScreenshotModel] {
        return ss.map { ss in
            return ShortScreenshotModel(id: ss.id, image: ss.image)
        }
    }
    static func mapSSSearchModuleToDomain(ss: [SearchShortScreenshotModel]) -> [ShortScreenshotModel] {
        return ss.map { ss in
            return ShortScreenshotModel(id: ss.id, image: ss.image)
        }
    }
    static func mapShortSSModelToFavoriteSSModel(ss: [ShortScreenshotModel]) -> [DetailScreenshotsModel] {
        return ss.map { ss in
            return DetailScreenshotsModel(id: ss.id, image: ss.image)
        }
    }
    static func mapFavoriteSsToShortSsModel(ss: [FavoriteScreenshotsModel]) -> [ShortScreenshotModel] {
        return ss.map { ss in
            return ShortScreenshotModel(id: Int(ss.id) ?? 0, image: ss.image)
        }
    }
    static func mapFavoriteModuleModelToHomeGameModel(favorite: FavoriteModuleModel) -> HomeGameModel {
        
        return HomeGameModel(
            id: Int(favorite.id) ?? 0,
            name: favorite.name,
            released: favorite.released,
            backgroundImage: favorite.backgroundImange,
            rating: Double(favorite.rating) ?? 0,
            ratingTop: Int(favorite.ratingTop) ?? 0,
            reviewsCount: Int(favorite.reviewCount) ?? 0,
            shortScreenshots: favorite.shortScreenshots.map { ss in
                return HomeShortScreenshotModel(id: Int(ss.id) ?? 0, image: ss.image)
            })
    }
}
