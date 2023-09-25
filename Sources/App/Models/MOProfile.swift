//
//  MOProfile.swift
//
//
//  Created by lory on 2023/9/23.
//

import Fluent
import Vapor

final class MOProfile: Model, Content {
    static var schema: String = "profiles"
    
    init() { }
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "uuid")
    var uuid: String
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "team_id")
    var teamId: String
    
    @Field(key: "create_date")
    var createDate: Date
    
    @Field(key: "expiration_date")
    var expirationDate: Date
    
    @Field(key: "application_identifier")
    var applicationIdentifier: String
    
    @Field(key: "certs")
    var certs: [X509]
    
    @Field(key: "entitlements")
    var entitlements: [String: String]
    
    @Field(key: "provisioned_devices")
    var provisionedDevices: [String]?
    
    @Field(key: "export_type")
    var exportType: String
    
    var description: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return "[\(certs.first?.commonName ?? "")] \(name) (\(applicationIdentifier)) - Expired: \(dateFormatter.string(from: expirationDate))"
    }
    
    
    static func getProfiles() -> [MOProfile] {
        let fileManager = FileManager()
        var profiles = [MOProfile]()
        guard let libraryDirectory = fileManager.urls(for: .libraryDirectory, in: .userDomainMask).first else {
            return profiles
        }
        guard let profileURLs = try? fileManager.contentsOfDirectory(at: libraryDirectory.appendingPathComponent("MobileDevice/Provisioning Profiles"), includingPropertiesForKeys: nil, options: []) else {
            return profiles
        }
        for profileURL in profileURLs {
            if profileURL.pathExtension == "mobileprovision", let profile = MOProfile(profilePath: profileURL) {
                profiles.append(profile)
            }
        }
        profiles = profiles.sorted(by: {
            $0.createDate.timeIntervalSince1970 > $1.createDate.timeIntervalSince1970
        })
        return profiles
    }
    
    init?(profilePath: URL){
        let data = [String: Any]()
        self.name = data["Name"] as? String ?? ""
        self.uuid = data["UUID"] as? String ?? ""
        self.teamId = (data["TeamIdentifier"] as? [String])?.first ?? ""
        self.createDate = data["CreationDate"] as! Date
        self.expirationDate = data["ExpirationDate"] as! Date
        let certs = data["DeveloperCertificates"] as! [Data]
        self.certs = certs.compactMap { X509(data: $0, type: .der) }
        
        let entitlements = data["Entitlements"] as? [String: String] ?? [:]
        let fullApplicationIdentifier = entitlements["application-identifier"] ?? ""
        if let periodIndex = fullApplicationIdentifier.firstIndex(of: ".") {
            self.applicationIdentifier = String(fullApplicationIdentifier[fullApplicationIdentifier.index(after: periodIndex)...])
        } else {
            self.applicationIdentifier = fullApplicationIdentifier
        }
        self.entitlements = entitlements
        self.provisionedDevices = data["ProvisionedDevices"] as? [String]
    }
}

extension MOProfile {
    
    /// 导入描述文件
    /// - Parameter profile: 描述文件URL
    /// - Parameter uuid: 描述文件的 UUID
    /// 通过拷贝描述文件到"~/Library/MobileDevice/Provisioning\ Profiles", 将其导入到Xcode
    static func `import`(profile: URL, uuid: String) throws {
        
    }
}
