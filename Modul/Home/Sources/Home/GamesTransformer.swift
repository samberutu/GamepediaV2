//
//  File.swift
//  
//
//  Created by Samlo Berutu on 08/12/21.
//

import Foundation
import Core
public struct GamesTransformer: CoreMapper {
    public typealias Request = [HomeGameResponse]
    public typealias Domain = [HomeGameModel]
    public init() {}
    public func transformResponseToDomain(request: [HomeGameResponse]) -> [HomeGameModel] {
        return request.map { result in
            return HomeGameModel(
                id: result.id ?? 0,
                name: result.name ?? "Unknow",
                released: result.released ?? "Unknow",
                backgroundImage: result.backgroundImage ?? "",
                rating: result.rating ?? 0,
                ratingTop: result.ratingTop ?? 0,
                reviewsCount: result.reviewsCount ?? 0,
                shortScreenshots: result.shortScreenshots.map({ ssResponse in
                    return ssResponse.map { ss in
                        return HomeShortScreenshotModel(id: ss.id, image: ss.image)
                    }
                }) ?? [])
        }
    }
}
