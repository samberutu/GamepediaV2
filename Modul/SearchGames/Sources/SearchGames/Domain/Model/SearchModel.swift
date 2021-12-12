//
//  File.swift
//  
//
//  Created by Samlo Berutu on 10/12/21.
//

import Foundation
public struct SearchModel: Identifiable {
    public let id: Int
    public let name: String
    public let backgroundImage: String
    public let shortScreenshots: [SearchShortScreenshotModel]
}

public struct SearchShortScreenshotModel: Identifiable {
    public let id: Int
    public let image: String
}
