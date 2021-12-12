//
//  File.swift
//  
//
//  Created by Samlo Berutu on 10/12/21.
//

import Foundation
public struct DetailModel: Identifiable {
    public let id: Int
    public let name: String
    public let website: String
    public let backgroundImage: String
    public let reviewsCount: Int
    public let released: String
    public let rating: Double
    public let ratingTop: Int
    public let metacriticURL: String
    public let genres: [DetatailDeveloperModel]
    public let welcomeDescription: String
    public let parentPlatforms: [DetailParentPlatformModel]
    public let esrbRating: DetailEsrbRatingModel
    
    public static let detailModelSeeder = DetailModel(id: 0, name: "", website: "", backgroundImage: "", reviewsCount: 0, released: "", rating: 0, ratingTop: 0, metacriticURL: "", genres: [], welcomeDescription: "", parentPlatforms: [], esrbRating: DetailEsrbRatingModel(id: 0, name: "", slug: ""))
}

public struct DetatailDeveloperModel: Identifiable {
    public let id: Int
    public let name, slug: String
}

public struct DetailParentPlatformModel {
    public let platform: DetailEsrbRatingModel
}

public struct DetailEsrbRatingModel: Identifiable {
    public let id: Int
    public let name, slug: String
}
public struct DetailScreenshotsModel {
    public init(id: Int, image: String) {
        self.id = id
        self.image = image
    }
    
    public let id: Int
    public let image: String
}
