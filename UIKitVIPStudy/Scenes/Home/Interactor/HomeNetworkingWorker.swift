//
//  HomeSceneNetworkingWorker.swift
//  UIKitVIPStudy
//
//  Created by Marcelo de Araújo on 05/12/2023.
//

import Foundation

// https://api.github.com/users/

enum NetworkingError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

final class HomeNetworkingWorker {}

extension HomeNetworkingWorker: HomeNetworkingLogic {

    func startFetching(with request: HomeModel.FetchUserInfo.Request) async throws -> HomeModel.FetchUserInfo.Response {

#if DEBUG
        sleep(1)
#endif

        let id = request.id
        let urlString = "https://api.github.com/users/\(id)"
        guard let url = URL(string: urlString) else { throw NetworkingError.invalidURL }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkingError.invalidResponse
        }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(HomeModel.FetchUserInfo.Response.self, from: data)

        } catch {
            throw NetworkingError.invalidData
        }
    }
}
