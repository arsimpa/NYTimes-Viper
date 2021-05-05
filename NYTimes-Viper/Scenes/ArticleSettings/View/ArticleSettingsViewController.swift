//
//  ArticleSettingsViewController.swift
//  NYTimes-Viper
//
//  Created by Arsalan Khan on 05/05/2021.
//  
//

import Foundation
import UIKit

protocol ArticleSettingsViewControllerDelegate: class {
    func settingsDidChanged(_ settings: Settings)
}

class ArticleSettingsViewController: UIViewController, StoryboardLoadable {

    // MARK: Properties
    static let cellIdentider = "periodCell"
    
    @IBOutlet weak var settingsTbl: UITableView!
    
    weak var delegate: ArticleSettingsViewControllerDelegate? = nil
    
    var allPeriods = [SettingsViewModel.ViewModel.PeriodsViewModel]()
    var isDarkModeSelected = false

    var presenter: ArticleSettingsPresentation?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.initView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        delegate?.settingsDidChanged(SettingsManager.shared.settings)
    }
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        isDarkModeSelected = sender.isOn
        presenter?.updateDarkMode(isDarkModeSelected)
    }
}

extension ArticleSettingsViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return allPeriods.count
        }else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Select Period"
        }else{
            return "Display"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: ArticleSettingsViewController.cellIdentider)! as UITableViewCell
            
            let period = allPeriods[indexPath.row]
            
            cell.textLabel?.text = period.name
            cell.accessoryType = period.selected ? .checkmark : .none
            cell.selectionStyle = .default
            
            return cell

        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: DarkModeTVC.identifer) as! DarkModeTVC
                        
            cell.darkModeSwitch.isOn = isDarkModeSelected
            cell.selectionStyle = .none
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.updateSelectedPeriod(allPeriods[indexPath.row].rawValue)
    }
    
}

extension ArticleSettingsViewController: ArticleSettingsView {
    
    func displaySettings(_ settings: SettingsViewModel.ViewModel) {
        
        allPeriods = settings.periodSettings
        isDarkModeSelected = settings.darkMode
        
        DispatchQueue.main.async {
            self.settingsTbl.reloadData()
        }
        
    }
    
    func display(_ darkMode: Bool) {
        view.window?.overrideUserInterfaceStyle = darkMode ? .dark : .light
    }
    
}
