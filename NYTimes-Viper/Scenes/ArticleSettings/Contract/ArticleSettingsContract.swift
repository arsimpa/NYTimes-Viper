//
//  ArticleSettingsContract.swift
//  NYTimes-Viper
//
//  Created by Arsalan Khan on 05/05/2021.
//  
//

import Foundation

protocol ArticleSettingsView: class {
    func displaySettings(_ settings: SettingsViewModel.ViewModel)
    func display(_ darkMode: Bool)
}

protocol ArticleSettingsPresentation: class {
    func initView()
    func updateSelectedPeriod(_ period: Int)
    func updateDarkMode(_ isDarkModeOn: Bool)
}

protocol ArticleSettingsUseCase: class {
    func getSettings()
    func updateSettings(_ period: Int)
    func updateSettings(_ darkModeOn: Bool)
}

protocol ArticleSettingsInteractorOutput: class {
    func allSetting(_ response: SettingsViewModel.Response)
    func updateUIForDarkMode(_ darkModeOn: Bool)
    func udpateArticles(_ response: SettingsViewModel.Response)
}

protocol ArticleSettingsWireframe: class {
    // TODO: Declare wireframe methods
}
