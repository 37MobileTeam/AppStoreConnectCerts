//
//  AppsController.swift
//  
//
//  Created by lory on 2023/9/19.
//

import Vapor
import AppStoreConnect_Swift_SDK

struct AppsController: RouteCollection {
    
    /// Go to https://appstoreconnect.apple.com/access/api and create your own key. This is also the page to find the private key ID and the issuer ID.
    /// Download the private key and open it in a text editor. Remove the enters and copy the contents over to the private key parameter.
    static let configuration = try? APIConfiguration(issuerID: issuerID, privateKeyID: privateKeyID, privateKey: privateKey)
    let provider: APIProvider = APIProvider(configuration: configuration!)
    
    func boot(routes: RoutesBuilder) throws {
        let appsRoute = routes.grouped("apps")
        appsRoute.get(use: apps)
    }
    
    func apps(req: Vapor.Request) async throws -> [App] {
        let request = APIEndpoint
            .v1
            .apps
            .get(parameters: .init(
                sort: [.bundleID],
                fieldsApps: [.appInfos, .name, .bundleID],
                limit: 5
            ))

        do {
            let apps = try await provider.request(request).data
            return apps
        } catch {
            print("Something went wrong fetching the apps: \(error.localizedDescription)")
            throw error
        }
    }
}
