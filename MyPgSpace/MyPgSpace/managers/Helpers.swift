//
//  Helpers.swift
//  MyPgSpace
//
//  Created by Johnson Liu on 3/12/22.
//

import UIKit
import Security

class Helpers: NSObject {
    private var service: String = String()
    
    func savePasswordForKey(userName: String, password: String) -> String {
        
        let attributes = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: self.service,
            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock,
            kSecAttrAccount as String: userName,
            kSecValueData as String : password.data(using: .utf8)
        ] as CFDictionary
        
        var isSuccess = ""
        let status = SecItemAdd(attributes, nil)
        
        if status == noErr {
            isSuccess = "Success!"
        } else {
            isSuccess = "Failed : \(status.description)"
        }
        
        return isSuccess
    }
    
    func retrivePasswordForKey(userName: String) -> String {
        
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: userName,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true
        ] as CFDictionary
        
        var item: CFTypeRef?
        var results = ""
        
        if SecItemCopyMatching(query, &item) == noErr {
            if let existingItem = item as? [String: Any],
               let username = existingItem[kSecAttrAccount as String] as? String,
               let passwordData = existingItem[kSecValueData as String] as? Data,
               let password = String(data: passwordData, encoding: .utf8)
            {
                results = "user name : \(username), password : \(password)"
            }
        } else {
            results = "Error!"
        }
        
        return results
    }
    
    func updatePasswordForKey(userName: String, password: String) -> String {
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: userName
        ]
        
        let attributes: [String: Any] = [kSecValueData as String: password.data(using: .utf8)]
        
        var isSuccess = ""
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        
        if status == noErr {
            isSuccess = "Success!"
        } else {
            isSuccess = "Faliled, error: \(status.description)"
        }
        
        return isSuccess
    }
    
    func deletePasswordForKey(userName: String) -> String {
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: userName
        ]
        
        var isSuccess = ""
        let status = SecItemDelete(query as CFDictionary)
        
        if status == noErr {
            isSuccess = "Success!"
        } else {
            isSuccess = "Failed, error = \(status.description)"
        }
        
        return isSuccess
    }
    
}
