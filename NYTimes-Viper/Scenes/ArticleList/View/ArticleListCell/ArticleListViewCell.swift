//
//  ArticleListViewCell.swift
//  NYTimes-Viper
//
//  Created by Arsalan Khan on 04/05/2021.
//

import UIKit

class ArticleListViewCell: UICollectionViewCell {

    static let identifier = "ArticleListViewCell"
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var imgView: RoundedImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .clear
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 12.0
        contentView.layer.masksToBounds = true
        
        imgView.contentMode = .scaleAspectFill
    }
    
    func configureCell(_ model: ArticleViewModel.ViewModel) {
        
        if let url = URL(string: model.thumbnailImage) {
            imgView.setImage(url)
        }
        
        lblTitle.text = model.title
        lblAuthor.text = model.author
        lblDate.text = model.date
        lblDesc.text = model.abstract
        
    }

}
