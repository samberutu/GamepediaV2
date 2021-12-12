//
//  File.swift
//  
//
//  Created by Samlo Berutu on 11/12/21.
//

import Foundation
import Core
public struct FavoriteTransformer: CoreFavoriteMapper {
    
    public typealias Request = [DetailScreenshotsModel]
    
    public typealias Response = FavoriteModuleModel
    
    public typealias Domain = DetailModel
    
    public typealias Entity = FavoriteGameEntity
    public init() {}
    public func transformDomainToEntity(request: [DetailScreenshotsModel], domain: DetailModel) -> FavoriteGameEntity {
        let newFavorite = FavoriteGameEntity()
        newFavorite.id = String(domain.id)
        newFavorite.name = domain.name
        newFavorite.backgroundImage = domain.backgroundImage
        newFavorite.rating = String(domain.rating)
        newFavorite.ratingTop = String(domain.ratingTop)
        newFavorite.released = domain.released
        newFavorite.reviewsCount = String(domain.reviewsCount)
        for ss in request {
            let newSS = FavoriteScreenshotsEntity()
            newSS.id = String(ss.id)
            newSS.image = ss.image
            newFavorite.shortScreenshots.append(newSS)
        }
        return newFavorite
    }
    public func transformEntityToDomain(entity: [FavoriteGameEntity]) -> [FavoriteModuleModel] {
        return entity.map { entity in
            return FavoriteModuleModel(
                id: entity.id,
                name: entity.name,
                backgroundImange: entity.backgroundImage,
                rating: entity.rating,
                ratingTop: entity.ratingTop,
                released: entity.released,
                reviewCount: entity.reviewsCount,
                shortScreenshots: entity.shortScreenshots.map { ss in
                    return FavoriteScreenshotsModel(id: ss.id, image: ss.image)
                })
        }
    }
}
