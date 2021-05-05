//
//  ArticleListViewController+Updating.swift
//  NYTimes-Viper
//
//  Created by Arsalan Khan on 05/05/2021.
//

import UIKit

extension ArticleListViewController: UISearchResultsUpdating {
    
    private func findMatches(searchString: String) -> NSCompoundPredicate {
        
        var searchItemsPredicate = [NSPredicate]()
        
        // Article title matching.
        let titleExpression = NSExpression(forKeyPath: \Article.title)
        let searchStringExpression = NSExpression(forConstantValue: searchString)
        
        let titleSearchComparisonPredicate =
        NSComparisonPredicate(leftExpression: titleExpression,
                              rightExpression: searchStringExpression,
                              modifier: .direct,
                              type: .contains,
                              options: [.caseInsensitive, .diacriticInsensitive])
        
        searchItemsPredicate.append(titleSearchComparisonPredicate)
        
        
        // The `abstract` field matching.
        let abstractExpression = NSExpression(forKeyPath: \Article.abstract)
        let abstractExpressionPredicate =
            NSComparisonPredicate(leftExpression: abstractExpression,
                                  rightExpression: searchStringExpression,
                                  modifier: .direct,
                                  type: .contains,
                                  options: [.caseInsensitive, .diacriticInsensitive])
        
        searchItemsPredicate.append(abstractExpressionPredicate)
                
        var finalCompoundPredicate: NSCompoundPredicate!
    
        finalCompoundPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: searchItemsPredicate)
        
        return finalCompoundPredicate
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        // Update the filtered array based on the search text.
        if let presenter = (listPresenter as? ArticleListPresenter),
           let dataStore = (presenter.interactor as? ArticleDataStore)?.datasource {
            
            let searchResults = dataStore

            // Strip out all the leading and trailing spaces.
            let whitespaceCharacterSet = CharacterSet.whitespaces
            let strippedString =
                searchController.searchBar.text!.trimmingCharacters(in: whitespaceCharacterSet)
            let searchItems = strippedString.components(separatedBy: " ") as [String]

            // Build all the "AND" expressions for each value in searchString.
            let andMatchPredicates: [NSPredicate] = searchItems.map { searchString in
                findMatches(searchString: searchString)
            }

            // Match up the fields of the Artcile object.
            let finalCompoundPredicate =
                NSCompoundPredicate(andPredicateWithSubpredicates: andMatchPredicates)

            let filteredResults = searchResults.filter { finalCompoundPredicate.evaluate(with: $0) }

            // Apply the filtered results to the search results table.
            if let resultsController = searchController.searchResultsController as? SearchViewController {
                resultsController.datasource = presenter.convertArtilesToViewModel(articles: filteredResults)
                resultsController.cvSearchVC.reloadData()
            }
        }
    }
    
}
