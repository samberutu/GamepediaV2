//
//  File.swift
//  
//
//  Created by Samlo Berutu on 10/12/21.
//

import Foundation
public struct SearchResponse: Decodable {
    public let count: Int
    public let results: [SearchGameResult]

    enum CodingKeys: String, CodingKey {
        case count, results
    }
}
public struct SearchGameResult: Decodable, Identifiable {
    public let id: Int?
    public let name: String?
    public let backgroundImage: String?
    public let shortScreenshots: [SearchShortScreenshotsResponse]?

    enum CodingKeys: String, CodingKey {
        case name, id
        case backgroundImage = "background_image"
        case shortScreenshots = "short_screenshots"
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try? container.decode(Int.self, forKey: .id)
        name = try? container.decode(String.self, forKey: .name)
        backgroundImage = try? container.decode(String.self, forKey: .backgroundImage)
        shortScreenshots = try? container.decode([SearchShortScreenshotsResponse].self, forKey: .shortScreenshots)
    }
}
public struct SearchShortScreenshotsResponse: Codable {
    public let id: Int
    public let image: String
}
