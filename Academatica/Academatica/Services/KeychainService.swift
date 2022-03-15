//
//  KeychainService.swift
//  Academatica
//
//  Created by Vladislav on 10.03.2022.
//

import Foundation

final class KeychainService {
    static let shared = KeychainService()
    
    private init() { }
    
    func save(_ data: Data, service: String, account: String) {
        // Creating the query.
        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ] as CFDictionary
        
        // Adding data in query to the keychain.
        let status = SecItemAdd(query, nil)
        
        if status == errSecDuplicateItem {
            // Item already exists, thus it needs to be updated.
            let query = [
                kSecAttrService: service,
                kSecAttrAccount: account,
                kSecClass: kSecClassGenericPassword,
            ] as CFDictionary

            let attributesToUpdate = [kSecValueData: data] as CFDictionary

            // Updating the existing item.
            SecItemUpdate(query, attributesToUpdate)
        } else if status != errSecSuccess {
            // Printing out the error.
            print("Error: \(status)")
        }
    }
    
    func read(service: String, account: String) -> Data? {
        // Creating the query.
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        
        return (result as? Data)
    }
    
    func delete(service: String, account: String) {
        // Creating the query.
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            ] as CFDictionary
        
        // Deleting the item from the keychain.
        SecItemDelete(query)
    }
    
    func save<T>(_ item: T, service: String, account: String) where T : Codable {
        do {
            // Encoding data as a JSON and saving it in the keychain.
            let data = try JSONEncoder().encode(item)
            save(data, service: service, account: account)
        } catch {
            print("Fail to encode item for keychain: \(error)")
        }
    }
    
    func read<T>(service: String, account: String, type: T.Type) -> T? where T : Codable {
        // Reading item data from the keychain.
        guard let data = read(service: service, account: account) else {
            return nil
        }
        
        // Decoding the JSON data to an object.
        do {
            let item = try JSONDecoder().decode(type, from: data)
            return item
        } catch {
            print("Fail to decode item for keychain: \(error)")
            return nil
        }
    }
}
