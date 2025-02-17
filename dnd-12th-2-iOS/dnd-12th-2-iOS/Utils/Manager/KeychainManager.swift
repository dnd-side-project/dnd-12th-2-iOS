//
//  KeychainManager.swift
//  dnd-12th-2-iOS
//
//  Created by 권석기 on 2/18/25.
//

import Foundation

struct KeyChainManager {
    
    // KeyChainName을 enum으로 정의
    enum KeyChainName: String {
        case accessToken = "accessToken"
        case refreshToken = "refreshToken"
    }
    
    static let service = Bundle.main.bundleIdentifier ?? "com.teamHY2.HongikYeolgong2"
    
    static func addItem(key: KeyChainName, value: String) {
        
        let valueData = value.data(using: .utf8)!
        
        let query: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                kSecAttrService: service,
                                kSecAttrAccount: key.rawValue,
                                  kSecValueData: valueData]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status == errSecSuccess {
            print("keyName: \(key.rawValue) add success")
        } else if status == errSecDuplicateItem {
            updateItem(key: key, value: value)
        } else {
            print("add failed")
        }
    }
    
    static func readItem(key: KeyChainName) -> String? {
        
        let query: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                kSecAttrService: service,
                                kSecAttrAccount: key.rawValue,
                           kSecReturnAttributes: true,
                                 kSecReturnData: true]
        
        var item: CFTypeRef?
        if SecItemCopyMatching(query as CFDictionary, &item) != errSecSuccess {
            print("read failed")
            return nil
        }
        
        guard let existItem = item as? [String:Any],
              let data = existItem[kSecValueData as String] as? Data,
              let returnValue = String(data: data, encoding: .utf8) else {
            return nil
        }
        
        return returnValue
    }
    
    static func updateItem(key: KeyChainName, value: String) {
        
        let valueData = value.data(using: .utf8)!
        
        let previousQuery: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                        kSecAttrService: service,
                                        kSecAttrAccount: key.rawValue]
        
        let updateQuery: [CFString: Any] = [kSecValueData: valueData]
        
        let status = SecItemUpdate(previousQuery as CFDictionary, updateQuery as CFDictionary)
        
        if status == errSecSuccess {
            print("keyName: \(key.rawValue) update complete")
        } else {
            print("not finished update")
        }
    }
    
    static func deleteItem(key: KeyChainName) {
        
        let deleteQuery: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                      kSecAttrService: service,
                                      kSecAttrAccount: key.rawValue]
        
        let status = SecItemDelete(deleteQuery as CFDictionary)
        if status == errSecSuccess {
            print("Remove keyName: \(key.rawValue)")
        } else {
            print("remove key-value data failed")
        }
    }
}
