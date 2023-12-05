//
//  DetailModel.swift
//  UIKitVIPStudy
//
//  Created by Marcelo de Araújo on 05/12/2023.
//

import Foundation

struct DetailModel {

    struct DisplayUserInfoDetails {
        struct Request {
            let data: UserInfo?
        }
        struct ViewModel {
            let tableViewData: [(String, String)]
        }
    }
}
