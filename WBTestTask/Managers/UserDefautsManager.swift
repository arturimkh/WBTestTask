//
//  UserDefautsManager.swift
//  WBTestTask
//
//  Created by Artur Imanbaev on 03.09.2023.
//

import Foundation
final class MyUserDefaultsManager {
    static let shared = MyUserDefaultsManager()

    private init() {}

    public func saveData(key: String, value: Bool) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    public func getData(forKey key: String) -> Bool{
        guard let data = UserDefaults.standard.value(forKey: key) as? Bool else {return false}
        return data
    }
}
