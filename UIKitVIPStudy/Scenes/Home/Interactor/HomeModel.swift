//
//  HomeModel.swift
//  UIKitVIPStudy
//
//  Created by Marcelo de Araújo on 05/12/2023.
//

import UIKit

struct HomeModel {

    struct FetchUserInfo {

        struct Request {
            let id: String
        }

        struct Response: Decodable {
            let avatarUrl: String
            let login: String
            let name: String
            let bio: String
            let location: String
            let publicRepos: Int
            let publicGists: Int
            let followers: Int
            let following: Int
        }

        struct ViewModel {
            let imageURL: String
            let id: String
        }
    }
}
