//
//  Sercret.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/16/25.
//

import Foundation

struct SecretKey {
    static var baseUrl: String { Bundle.main.object(forInfoDictionaryKey: "BaseURL") as? String ?? "" }
    static var apiKey: String { Bundle.main.object(forInfoDictionaryKey: "ApiKey") as? String ?? "" }
}
