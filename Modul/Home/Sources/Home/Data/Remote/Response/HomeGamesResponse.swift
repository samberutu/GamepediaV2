//
//  File.swift
//  
//
//  Created by Samlo Berutu on 08/12/21.
//

import SwiftUI
public struct HomeGamesResponse: Decodable {
    let count: Int
    let games: [HomeGameResponse]
    enum CodingKeys: String, CodingKey {
        case count
        case games = "results"
    }
}

public struct HomeGameResponse: Decodable {
    let id: Int?
    let name, released: String?
    let backgroundImage: String?
    let rating: Double?
    let ratingTop: Int?
    let reviewsCount: Int?
    var image = UIImage(systemName: "photo")
    let shortScreenshots: [HomeShortScreenshotsResponse]?
    enum CodingKeys: String, CodingKey {
        case id, name, released
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
        case reviewsCount = "reviews_count"
        case shortScreenshots = "short_screenshots"
    }
}

public struct HomeShortScreenshotsResponse: Codable {
    let id: Int
    let image: String
}
