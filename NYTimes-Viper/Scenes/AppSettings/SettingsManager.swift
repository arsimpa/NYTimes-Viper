//
//  SettingsManager.swift
//  NYTimes-Viper
//
//  Created by Arsalan Khan on 05/05/2021.
//

import Foundation

class SettingsManager: NSObject {
    
    static let shared = SettingsManager()
    
    var settings: Settings
    
    private override init() {
        settings = SettingsManager.loadFromDefaultsifExist() ?? Settings()
    }
}

// Save In UserDefaults
extension SettingsManager {
    
    func save() {
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(settings) {
            
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "settings")

        }
    }
    
    static func loadFromDefaultsifExist() -> Settings? {
        
        let defaults = UserDefaults.standard
        
        if let settings = defaults.object(forKey: "settings") as? Data {
            let decoder = JSONDecoder()
            if let loadedSettings = try? decoder.decode(Settings.self, from: settings) {
                return loadedSettings
            }
        }
        
        return nil
    }
}
