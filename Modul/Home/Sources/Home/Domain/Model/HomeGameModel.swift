//
//  File.swift
//  
//
//  Created by Samlo Berutu on 08/12/21.
//

import Foundation
import SwiftUI
public struct HomeGameModel: Identifiable {
    public let id: Int
    public let name, released: String
    public let backgroundImage: String
    public let rating: Double
    public let ratingTop: Int
    public let reviewsCount: Int
    public var image = UIImage(systemName: "photo")
    public let shortScreenshots: [HomeShortScreenshotModel]
    public init(id: Int, name: String, released: String, backgroundImage: String, rating: Double, ratingTop: Int, reviewsCount: Int, shortScreenshots: [HomeShortScreenshotModel]) {
        self.id = id
        self.name = name
        self.released = released
        self.backgroundImage = backgroundImage
        self.rating = rating
        self.ratingTop = ratingTop
        self.reviewsCount = reviewsCount
        self.shortScreenshots = shortScreenshots
    }
}

public struct HomeShortScreenshotModel: Identifiable {
    
    public let id: Int
    public let image: String

    public init(id: Int, image: String) {
        self.id = id
        self.image = image
    }
}
