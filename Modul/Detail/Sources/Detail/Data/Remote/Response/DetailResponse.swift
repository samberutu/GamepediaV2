//
//  File.swift
//  
//
//  Created by Samlo Berutu on 10/12/21.
//

import Foundation
public struct DetailResponse: Decodable {
    
    public let id: Int?
    public let name: String?
    public let website: String?
    public let backgroundImage: String?
    public let reviewsCount: Int?
    public let released: String?
    public let rating: Double?
    public let ratingTop: Int?
    public let metacriticURL: String?
    public let genres: [DetailDeveloperResponse]?
    public let welcomeDescription: String?
    public let parentPlatforms: [DetailParentPlatformResponse]?
    public let esrbRating: DetailEsrbRatingResponse?
    enum CodingKeys: String, CodingKey {
        case id, name, website, released, genres
        case backgroundImage = "background_image"
        case reviewsCount = "reviews_count"
        case rating
        case ratingTop = "rating_top"
        case metacriticURL = "metacritic_url"
        case welcomeDescription = "description"
        case parentPlatforms = "parent_platforms"
        case esrbRating = "esrb_rating"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try? container.decode(Int.self, forKey: .id)
        name = try? container.decode(String.self, forKey: .name)
        website = try? container.decode(String.self, forKey: .website)
        backgroundImage = try? container.decode(String.self, forKey: .backgroundImage)
        reviewsCount = try? container.decode(Int.self, forKey: .reviewsCount)
        released = try? container.decode(String.self, forKey: .released)
        rating = try? container.decode(Double.self, forKey: .rating)
        metacriticURL = try? container.decode(String.self, forKey: .metacriticURL)
        genres = try? container.decode([DetailDeveloperResponse].self, forKey: .genres)
        welcomeDescription =  try? container.decode(String.self, forKey: .welcomeDescription)
        parentPlatforms = try? container.decode([DetailParentPlatformResponse].self, forKey: .parentPlatforms)
        esrbRating = try? container.decode(DetailEsrbRatingResponse.self, forKey: .esrbRating)
        ratingTop = try? container.decode(Int.self, forKey: .ratingTop)
    }
}

public struct DetailDeveloperResponse: Codable, Identifiable {
    public let id: Int?
    public let name, slug: String?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try? container.decode(Int.self, forKey: .id)
        name = try? container.decode(String.self, forKey: .name)
        slug = try? container.decode(String.self, forKey: .slug)
    }
}

public struct DetailParentPlatformResponse: Codable {
    public let platform: DetailEsrbRatingResponse?
    enum CodingKeys: String, CodingKey {
        case platform
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        platform = try? container.decode(DetailEsrbRatingResponse.self, forKey: .platform)
    }
}

public struct DetailEsrbRatingResponse: Codable, Identifiable {
    public init(id: Int?, name: String?, slug: String?) {
        self.id = id
        self.name = name
        self.slug = slug
    }
    
    public let id: Int?
    public let name, slug: String?
    enum CodingKeys: String, CodingKey {
        case id, name, slug
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try? container.decode(Int.self, forKey: .id)
        name = try? container.decode(String.self, forKey: .name)
        slug = try? container.decode(String.self, forKey: .slug)
    }

}
