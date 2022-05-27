//
//  SearchViewController.swift
//  PodcastApp
//
//  Created by Makwana Bhavin on 26/03/22.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    let searchController : UISearchController = {
        let vc = UISearchController(searchResultsController: SearchResultViewController())
        vc.searchBar.placeholder = "All Podcasts"
        vc.searchBar.searchBarStyle = .minimal
        vc.definesPresentationContext = true

        return vc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.searchBar.text = "voong"
    }
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let query = searchController.searchBar.text, !query.trimmingCharacters(in: .whitespaces).isEmpty else{
            return
        }
        
        guard let resultController = searchController.searchResultsController as? SearchResultViewController else{
            return
        }
        
        resultController.delegate = self
        
        APICaller.shared.getSearchResult(for: query) { result in
            
            DispatchQueue.main.async {
                switch result{
                case .success(let mdoel):
                    resultController.update(with: mdoel)
                    
                case .failure( _): break
                }
            }
        }
        
    }
}

extension SearchViewController: SearchResultsViewControllerDelegate{
    func showResults(_ controller: UIViewController) {
        
        controller.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(controller, animated: true)
    }
}
