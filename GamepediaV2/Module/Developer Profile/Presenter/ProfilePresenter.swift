//
//  ProfilePresenter.swift
//  GamepediaV2
//
//  Created by Samlo Berutu on 18/11/21.
//

import Foundation

public class ProfilePresenter {
    init() {
        ProfileModel.synchronize()
    }
    func getImage() -> Data {
        return ProfileModel.image
    }
    func getName() -> String {
        return ProfileModel.name
    }
    func getEmail() -> String {
        return ProfileModel.email
    }
    func saveAllData(name: String, email: String, image: Data) {
        ProfileModel.name = name
        ProfileModel.email = email
        ProfileModel.image = image
    }
    func deleteAllData() -> Bool {
        return ProfileModel.deleteAll()
    }
    func synchronize() {
        ProfileModel.synchronize()
    }
}
