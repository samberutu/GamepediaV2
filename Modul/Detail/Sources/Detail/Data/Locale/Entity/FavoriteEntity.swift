//
//  File.swift
//  
//
//  Created by Samlo Berutu on 11/12/21.
//

import Foundation
import RealmSwift
public class FavoriteGameEntity: Object {
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var backgroundImage = ""
    @objc dynamic var rating = ""
    @objc dynamic var ratingTop = ""
    @objc dynamic var released = ""
    @objc dynamic var reviewsCount = ""
    var shortScreenshots = List<FavoriteScreenshotsEntity>()
    public override static func primaryKey() -> String? {
        return "id"
    }
}

public class FavoriteScreenshotsEntity: Object {
    @objc dynamic var id = ""
    @objc dynamic var image = ""
}
