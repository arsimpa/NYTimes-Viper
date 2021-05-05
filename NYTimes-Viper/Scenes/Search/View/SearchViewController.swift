//
//  SearchViewController.swift
//  NYTimes-Viper
//
//  Created by Arsalan Khan on 05/05/2021.
//  
//

import Foundation
import UIKit

class SearchViewController: UIViewController, StoryboardLoadable {

    // MARK: Properties
    @IBOutlet weak var cvSearchVC: UICollectionView!

    var presenter: SearchPresentation?
    
    var datasource = [ArticleViewModel.ViewModel]()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
    }
}

extension SearchViewController: SearchView {
    // TODO: implement view output methods
}


extension SearchViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleListViewCell.identifier, for: indexPath) as! ArticleListViewCell
        
        let model = datasource[indexPath.row]
        
        cell.configureCell(model)
        
        return cell
    }
    
    func configureCollectionView() {
        
        cvSearchVC.alpha = 1.0
        
        cvSearchVC.register(UINib(nibName: "ArticleListViewCell", bundle: nil), forCellWithReuseIdentifier: ArticleListViewCell.identifier)
        
        cvSearchVC.collectionViewLayout  = MainCollectionLayoutHelper().generateLayout()
        
        cvSearchVC.dataSource = self
    }
    
}
