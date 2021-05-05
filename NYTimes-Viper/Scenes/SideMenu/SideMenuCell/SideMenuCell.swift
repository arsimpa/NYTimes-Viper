//
//  SideMenuCell.swift
//  NYTimes-Viper
//
//  Created by Arsalan Khan on 05/05/2021.
//

import UIKit

class SideMenuCell: UITableViewCell {
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .clear
    }
    
}
