//
//  MOCertificate.swift
//
//
//  Created by lory on 2023/9/23.
//

import Fluent
import Vapor
import Security

final class MOCertificate: Model, Content {
    
    static var schema: String = "certificates"
    
    init() {
        
    }
    
    @ID(key: .id)
    var id:UUID?
    
    @Field(key: "uuid")
    var uuid: String
    
    @Field(key: "sha1")
    var sha1: String
    
    @Field(key: "name")
    var name: String
    
    var description: String {
        name + " - SHA1: " + sha1
    }
    
    /// 获取本地已安装的证书
    static func getCertificates() -> [MOCertificate] {
        return []
    }
    
}

extension MOCertificate {
    
    /// 导入证书
    /// - Parameters:
    ///   - p12: 证书文件
    ///   - p12passwd: 导入密码
    static func `import`(p12: URL, p12passwd: String) throws {
//        var keychain: SecKeychain?
//        SecKeychainCopyDomainDefault(.user, &keychain)
//        guard let keychain = keychain else {
//            throw NSError(domain: "SecurityError", code: -1, userInfo: [NSLocalizedDescriptionKey: "KeyChain失败"])
//        }
//        
//        let data = try Data(contentsOf: p12) as CFData
//        var inputFormat: SecExternalFormat = .formatPKCS12
//        var itemType: SecExternalItemType = .itemTypeUnknown
//        var params = SecItemImportExportKeyParameters()
//        params.version = UInt32(SEC_KEY_IMPORT_EXPORT_PARAMS_VERSION)
//        params.passphrase = Unmanaged.passUnretained(p12passwd as CFString)
//        let status = SecItemImport(data, nil, &inputFormat, &itemType, SecItemImportExportFlags(rawValue: 0), &params, keychain, nil)
//        if status != errSecSuccess {
//            throw NSError(domain: "SecurityError", code: -2, userInfo: [NSLocalizedDescriptionKey: "导入p12到KeyChain失败"])
//        }
    }
}
