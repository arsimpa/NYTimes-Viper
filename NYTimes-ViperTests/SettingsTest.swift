//
//  Settings.swift
//  NYTimes-ViperTests
//
//  Created by Arsalan Khan on 05/05/2021.
//

import XCTest
@testable import NYTimes_Viper

class SettingsTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSingleton() {
        
        let sharedSettings1 = SettingsManager.shared
        
        let shasharedSettings2 = SettingsManager.shared
        
        XCTAssertEqual(sharedSettings1, shasharedSettings2)
    }
    
    func testSettingsSave() {
        
        let shared = SettingsManager.shared
        shared.save()
        
        let savedSettings = SettingsManager.loadFromDefaultsifExist()
                
        XCTAssertEqual(savedSettings!.darkModeOn, shared.settings.darkModeOn)
    }
    
    func testUpdateValue() {
        
        let shared = SettingsManager.shared
        shared.settings.darkModeOn = true
        shared.settings.selectedPeriod = .oneDay
        
        XCTAssertEqual(shared.settings.darkModeOn, true)
        XCTAssertNotEqual(shared.settings.selectedPeriod, .sevenDay)
        XCTAssertEqual(shared.settings.selectedPeriod, .oneDay)
        
    }
    
    func testSaveAndLoadFromDefaults() {
        
        let shared = SettingsManager.shared
        shared.settings.darkModeOn = true
        shared.settings.selectedPeriod = .thirtyDays
        
        shared.save()
        
        let newSettings = SettingsManager.loadFromDefaultsifExist()
        
        XCTAssertEqual(shared.settings.darkModeOn, newSettings?.darkModeOn)
        XCTAssertEqual(shared.settings.selectedPeriod, newSettings?.selectedPeriod)
    }
}
