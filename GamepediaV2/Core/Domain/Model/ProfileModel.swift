//
//  ProfileModel.swift
//  GamepediaV2
//
//  Created by Samlo Berutu on 18/11/21.
//

import Foundation
struct ProfileModel {
    static let nameKey = "name"
    static let emailKey = "email"
    static let imageKey = "image"
    static var image: Data {
        get {
            return UserDefaults.standard.data(forKey: imageKey) ?? Data()
        }
        set {
            UserDefaults.standard.set(newValue, forKey: imageKey)
        }
    }
    static var name: String {
        get {
            return UserDefaults.standard.string(forKey: nameKey) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: nameKey)
        }
    }
    static var email: String {
        get {
            return UserDefaults.standard.string(forKey: emailKey) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: emailKey)
        }
    }
    static func deleteAll() -> Bool {
        if let domain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: domain)
            synchronize()
            return true
        } else { return false}
    }
    static func synchronize() {
        UserDefaults.standard.synchronize()
    }
}
