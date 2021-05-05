//
//  SideMenuViewController.swift
//  NYTimes-Viper
//
//  Created by Arsalan Khan on 05/05/2021.
//

import UIKit

protocol SideMenuViewControllerDelegate {
    func selectedCell(_ row: Int)
}

class SideMenuViewController: UIViewController {
    
    @IBOutlet var sideMenuTableView: UITableView!
    
    var menu: [SideMenuModel] = [SideMenuModel(title: "Home"),
                                 SideMenuModel(title: "Second Tab")
    ]
    
    var defaultHighlightedCell: Int = 0
    
    var delegate: SideMenuViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sideMenuTableView.delegate = self
        self.sideMenuTableView.dataSource = self
        self.sideMenuTableView.backgroundColor = #colorLiteral(red: 0.737254902, green: 0.1294117647, blue: 0.2941176471, alpha: 1)
        self.sideMenuTableView.separatorStyle = .none
        
        // Register TableView Cell
        self.sideMenuTableView.register(SideMenuCell.nib, forCellReuseIdentifier: SideMenuCell.identifier)
        
        // Update TableView with the data
        self.sideMenuTableView.reloadData()
        
        // Set Highlighted Cell
        DispatchQueue.main.async {
            let defaultRow = IndexPath(row: self.defaultHighlightedCell, section: 0)
            self.sideMenuTableView.selectRow(at: defaultRow, animated: false, scrollPosition: .none)
        }
    }
    
}

// MARK: - UITableViewDelegate
extension SideMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.selectedCell(indexPath.row)
    }
}

// MARK: - UITableViewDataSource
extension SideMenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuCell.identifier, for: indexPath) as? SideMenuCell else { fatalError("xib doesn't exist") }
        
        cell.textLabel?.text = self.menu[indexPath.row].title
        
        // Highlighted color
        let myCustomSelectionColorView = UIView()
        myCustomSelectionColorView.backgroundColor = #colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1)
        cell.selectedBackgroundView = myCustomSelectionColorView
        
        return cell
    }
}
