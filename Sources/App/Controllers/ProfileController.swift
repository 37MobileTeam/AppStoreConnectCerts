//
//  ProfileController.swift
//  
//
//  Created by lory on 2023/9/19.
//

import Vapor
import AppStoreConnect_Swift_SDK

struct ProfileController: RouteCollection {
    
    /// Go to https://appstoreconnect.apple.com/access/api and create your own key. This is also the page to find the private key ID and the issuer ID.
    /// Download the private key and open it in a text editor. Remove the enters and copy the contents over to the private key parameter.
    static let configuration = try? APIConfiguration(issuerID: issuerID, privateKeyID: privateKeyID, privateKey: privateKey)
    let provider: APIProvider = APIProvider(configuration: configuration!)
    
    func boot(routes: RoutesBuilder) throws {
        let profilesRoute = routes.grouped("profiles")
        profilesRoute.get(use: profile)
    }
    
    func profile(req: Vapor.Request) async throws -> [Profile] {
        let request = APIEndpoint
            .v1
            .profiles
            .get(parameters: .init())

        do {
            let profiles = try await provider.request(request).data
            return profiles
        } catch {
            print("Something went wrong fetching the apps: \(error.localizedDescription)")
            throw error
        }
    }
}
