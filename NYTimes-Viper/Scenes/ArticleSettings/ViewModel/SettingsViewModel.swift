//
//  SettingsViewModel.swift
//  NYTimes-Viper
//
//  Created by Arsalan Khan on 05/05/2021.
//

import Foundation

struct SettingsViewModel {
    
    struct Response {
        let allPeriods: [ArticlePeriod]
        let darkMode: Bool
        let selectedPeriod: ArticlePeriod
    }

    struct ViewModel {
        
        struct PeriodsViewModel {
            let rawValue: Int
            let name: String
            let selected: Bool
        }
        
        let periodSettings: [PeriodsViewModel]
        let darkMode: Bool
    
    }
}
