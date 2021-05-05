//
//  RoundImageView.swift
//  NYTimes-Viper
//
//  Created by Arsalan Khan on 05/05/2021.
//

import UIKit

@IBDesignable
class RoundedImageView: UIImageView {
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override class func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
}
