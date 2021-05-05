//
//  ArticleListViewController.swift
//  NYTimes-Viper
//
//  Created by Arsalan Khan on 03/05/2021.
//  
//

import Foundation
import UIKit

class ArticleListViewController: UIViewController, StoryboardLoadable {

    // MARK: Properties
    
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    
    @IBOutlet weak var cvArticles: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var datasource = [ArticleViewModel.ViewModel]()
    var listPresenter: ArticleListPresentation?
    
    /// Search controller to help us with filtering items in the table view.
    var searchController: UISearchController!
    
    /// Search results table view.
    private var resultsViewController: SearchViewController!


    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViper()
        
        listPresenter?.initView()
        listPresenter?.loadArticlesFor(period: SettingsManager.shared.settings.selectedPeriod)
    }
    
    func initViper() {
        
        // Article List Router
        let presenter = ArticleListPresenter()
        let router = ArticleListRouter()
        let interactor = ArticleListInteractor()

        self.listPresenter =  presenter

        presenter.view = self
        presenter.router = router
        presenter.interactor = interactor

        router.view = self

        interactor.output = presenter
    }
    
    @IBAction func btnSettingTapped(_ sender: UIBarButtonItem) {
        let settingsVC = ArticleSettingsRouter.setupModule()
        settingsVC.delegate = self
        self.present(settingsVC, animated: true, completion: nil)
    }
    
    func addSearchVC() {
        
        let storyboard = UIStoryboard(name: "Search", bundle: nil)
        resultsViewController =
            storyboard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.delegate = self

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
}

extension ArticleListViewController: ArticleListView {
    
    func initView() {
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .medium
        
        view.window?.overrideUserInterfaceStyle = SettingsManager.shared.settings.darkModeOn ? .dark : .light
        
        configureCollectionView()
        
        addSearchVC()
        
        // Side Menu Configuration
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
    }
    
    func showLoading() {
        
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
            
            UIView.animate(withDuration: 0.1) {
                self.cvArticles.alpha = 0.0
            }
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            
            UIView.animate(withDuration: 0.1) {
                self.cvArticles.alpha = 1.0
            }
        }
    }
    
    func displayError(_ err: ArticleViewModel.FetchError) {
        print("\(err.title): \(err.message)")
    }
    
    func displayArticles(_ articles: [ArticleViewModel.ViewModel]) {
        
        DispatchQueue.main.async {
            
            self.datasource = articles
            
            self.cvArticles.reloadData()
        }
    }
    
}

// MARK: - ArticleSettingsViewControllerDelegate

extension ArticleListViewController : ArticleSettingsViewControllerDelegate {
    func settingsDidChanged(_ settings: Settings) {
        listPresenter?.loadArticlesFor(period: settings.selectedPeriod)
    }
}


// MARK: - UICollectionViewDataSource

extension ArticleListViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleListViewCell.identifier, for: indexPath) as! ArticleListViewCell
        
        let model = datasource[indexPath.row]
        
        cell.configureCell(model)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ArticleListViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

// MARK: - Helpers

extension ArticleListViewController {
    
    func configureCollectionView() {
        
        cvArticles.alpha = 0.0
        
        cvArticles.register(UINib(nibName: "ArticleListViewCell", bundle: nil), forCellWithReuseIdentifier: ArticleListViewCell.identifier)
        
        cvArticles.collectionViewLayout  = MainCollectionLayoutHelper().generateLayout()
        
        cvArticles.dataSource = self
    }
    
}

// MARK: - UISearchBarDelegate

extension ArticleListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        updateSearchResults(for: searchController)
    }
    
}
