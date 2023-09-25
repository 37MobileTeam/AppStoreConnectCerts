//
//  DownloadController.swift
//  
//
//  Created by lory on 2023/9/19.
//

import Vapor
import AppStoreConnect_Swift_SDK

struct DownloadController: RouteCollection {
    
    /// Go to https://appstoreconnect.apple.com/access/api and create your own key. This is also the page to find the private key ID and the issuer ID.
    /// Download the private key and open it in a text editor. Remove the enters and copy the contents over to the private key parameter.
    static let configuration = try? APIConfiguration(issuerID: issuerID, privateKeyID: privateKeyID, privateKey: privateKey)
    let provider: APIProvider = APIProvider(configuration: configuration!)
    
    func boot(routes: RoutesBuilder) throws {
        let downloadRoute = routes.grouped("download")
        downloadRoute.get("certificate", use: downloadCertificate)
        downloadRoute.get("mobileprovision", use: downloadMobileprovision)
        downloadRoute.get("p12", use: downloadP12)
        downloadRoute.get("cert-signing-request", use: downloadCertSigningRequest)
        downloadRoute.get("p8", use: downloadP8)
    }
    
    func downloadCertificate(req: Vapor.Request) async throws -> Vapor.Response {
        /// https://api.appstoreconnect.apple.com/v1/certificates/DU58668ZT6
        let fileManager = FileManager.default
        let directory = fileManager.temporaryDirectory
        let filename = UUID().uuidString
        let tempURL = directory.appendingPathComponent(filename)
        let data = try Data(contentsOf: tempURL)
        try FileManager.default.removeItem(at: tempURL)
        let headers: [(String, String)] = [("Content-Type", "application/pkix-cert")]
        let response = Response(status: .ok, headers: HTTPHeaders(headers), body: Response.Body(data: data))
        return response
    }
    
    func downloadMobileprovision(req: Vapor.Request) async throws -> Vapor.Response {
        /// https://api.appstoreconnect.apple.com/v1/profiles/3TA256CUXK
        let fileManager = FileManager.default
        let directory = fileManager.temporaryDirectory
        let filename = UUID().uuidString
        let tempURL = directory.appendingPathComponent(filename)
        let data = try Data(contentsOf: tempURL)
        try FileManager.default.removeItem(at: tempURL)
        let headers: [(String, String)] = [("Content-Type", "application/x-apple-aspen-config")]
        let response = Response(status: .ok, headers: HTTPHeaders(headers), body: Response.Body(data: data))
        return response
    }
    
    func downloadP12(req: Vapor.Request) async throws -> Vapor.Response {
        let fileManager = FileManager.default
        let directory = fileManager.temporaryDirectory
        let filename = UUID().uuidString
        let tempURL = directory.appendingPathComponent(filename)
        let data = try Data(contentsOf: tempURL)
        try FileManager.default.removeItem(at: tempURL)
        let headers: [(String, String)] = [("Content-Type", "application/x-pkcs12")]
        let response = Response(status: .ok, headers: HTTPHeaders(headers), body: Response.Body(data: data))
        return response
    }
    
    func downloadCertSigningRequest(req: Vapor.Request) async throws -> Vapor.Response {
        let fileManager = FileManager.default
        let directory = fileManager.temporaryDirectory
        let filename = UUID().uuidString
        let tempURL = directory.appendingPathComponent(filename)
        let data = try Data(contentsOf: tempURL)
        try FileManager.default.removeItem(at: tempURL)
        let headers: [(String, String)] = [("Content-Type", "application/pkcs10")]
        let response = Response(status: .ok, headers: HTTPHeaders(headers), body: Response.Body(data: data))
        return response
    }
    
    func downloadP8(req: Vapor.Request) async throws -> Vapor.Response {
        let fileManager = FileManager.default
        let directory = fileManager.temporaryDirectory
        let filename = UUID().uuidString
        let tempURL = directory.appendingPathComponent(filename)
        let data = try Data(contentsOf: tempURL)
        try FileManager.default.removeItem(at: tempURL)
        let headers: [(String, String)] = [("Content-Type", "application/pkcs8")]
        let response = Response(status: .ok, headers: HTTPHeaders(headers), body: Response.Body(data: data))
        return response
    }
}
