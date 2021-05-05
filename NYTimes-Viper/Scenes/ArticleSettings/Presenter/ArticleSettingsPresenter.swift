//
//  ArticleSettingsPresenter.swift
//  NYTimes-Viper
//
//  Created by Arsalan Khan on 05/05/2021.
//  
//

import Foundation

class ArticleSettingsPresenter {

    // MARK: Properties

    weak var view: ArticleSettingsView?
    var router: ArticleSettingsWireframe?
    var interactor: ArticleSettingsUseCase?
}

extension ArticleSettingsPresenter: ArticleSettingsPresentation {
    
    func initView() {
        interactor?.getSettings()
    }
    
    func updateSelectedPeriod(_ period: Int) {
        interactor?.updateSettings(period)
    }
    
    func updateDarkMode(_ isDarkModeOn: Bool) {
        interactor?.updateSettings(isDarkModeOn)
    }
    
}

extension ArticleSettingsPresenter: ArticleSettingsInteractorOutput {
    
    func allSetting(_ response: SettingsViewModel.Response) {
        
        let selectedPeriod = response.selectedPeriod
        let darkMode = response.darkMode
        
        var periodViewModels = [SettingsViewModel.ViewModel.PeriodsViewModel]()
        
        response.allPeriods.forEach { period in
            let selected = period == selectedPeriod
            periodViewModels.append(SettingsViewModel.ViewModel.PeriodsViewModel(rawValue: period.rawValue, name: period.title, selected: selected))
        }
        
        view?.displaySettings(SettingsViewModel.ViewModel(periodSettings: periodViewModels, darkMode: darkMode))
    }
    
    func updateUIForDarkMode(_ darkModeOn: Bool) {
        view?.display(darkModeOn)
    }
    
    func udpateArticles(_ response: SettingsViewModel.Response) {
        
        var periodViewModels = [SettingsViewModel.ViewModel.PeriodsViewModel]()
        let darkMode = response.darkMode
        
        response.allPeriods.forEach { period in
            let selected = period == response.selectedPeriod
            periodViewModels.append(SettingsViewModel.ViewModel.PeriodsViewModel(rawValue: period.rawValue, name: period.title, selected: selected))
        }
        
        view?.displaySettings(SettingsViewModel.ViewModel(periodSettings: periodViewModels, darkMode: darkMode))
    }

}
