//
//  MainCollectionLayoutHelper.swift
//  NYTimes-Viper
//
//  Created by Arsalan Khan on 05/05/2021.
//

import UIKit

struct MainCollectionLayoutHelper {
    
    func generateLayout() -> UICollectionViewLayout {
        
        let layout  = UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
                        
            return self.generateArticleSection()
        }
        
        return layout
    }

    
    func commonPadding() -> NSDirectionalEdgeInsets {
        return NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0)
    }
    
    func generateArticleSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(220))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        
        group.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = commonPadding()
        
        return section
    }
}
