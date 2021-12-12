//
//  File.swift
//  
//
//  Created by Samlo Berutu on 12/12/21.
//

import Foundation
public struct FavoriteModuleModel: Identifiable {
    public var id: String
    public var name, backgroundImange, rating, ratingTop, released, reviewCount: String
    public var shortScreenshots: [FavoriteScreenshotsModel]
}
public struct FavoriteScreenshotsModel: Identifiable {
    
    public let id: String
    public let image: String

    public init(id: String, image: String) {
        self.id = id
        self.image = image
    }
}
