//
//  File.swift
//  
//
//  Created by lory on 2023/9/20.
//

import Foundation
import AppStoreConnect_Swift_SDK
import URLQueryEncoder

extension APIEndpoint.V1.Certificates {
    public func delete(id: String) -> Request<AppStoreConnect_Swift_SDK.CertificatesResponse> {
        // TODO: delete Certificate
        .delete(id)
    }
}

extension APIEndpoint.V1.Profiles {
    public func delete(id: String) -> Request<AppStoreConnect_Swift_SDK.ProfileResponse> {
        // TODO: delete Profile
        .delete(id)
    }
}
