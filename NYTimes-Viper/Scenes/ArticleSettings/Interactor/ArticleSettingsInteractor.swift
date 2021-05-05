//
//  ArticleSettingsInteractor.swift
//  NYTimes-Viper
//
//  Created by Arsalan Khan on 05/05/2021.
//  
//

import Foundation

class ArticleSettingsInteractor {

    // MARK: Properties

    weak var output: ArticleSettingsInteractorOutput?
}

extension ArticleSettingsInteractor: ArticleSettingsUseCase {
    
    func getSettings() {
        let allPeriods = ArticlePeriod.allPeriods
        let selectedPeriod = SettingsManager.shared.settings.selectedPeriod
        let darkModeOn = SettingsManager.shared.settings.darkModeOn
        
        output?.allSetting(SettingsViewModel.Response(allPeriods: allPeriods, darkMode: darkModeOn, selectedPeriod: selectedPeriod))
    }

    func updateSettings(_ period: Int) {
        
        if let articlePeriod = ArticlePeriod.allPeriods.filter ({ $0.rawValue == period }).first {
            
            SettingsManager.shared.settings.selectedPeriod = articlePeriod
            SettingsManager.shared.save()
            
            let allPeriods = ArticlePeriod.allPeriods
            let selectedPeriod = articlePeriod
            let darkModeOn = SettingsManager.shared.settings.darkModeOn
            
            output?.udpateArticles(SettingsViewModel.Response(allPeriods: allPeriods, darkMode: darkModeOn, selectedPeriod: selectedPeriod))
        }
    }
    
    func updateSettings(_ darkModeOn: Bool) {
        SettingsManager.shared.settings.darkModeOn = darkModeOn
        SettingsManager.shared.save()
        
        output?.updateUIForDarkMode(darkModeOn)
    }
    
}
