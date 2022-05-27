//
//  PodcastSearchController.swift
//  PodcastApp
//
//  Created by Makwana Bhavin on 04/02/22.
//

import UIKit
import Alamofire
import Foundation

class podcstSearchController: UITableViewController, UISearchBarDelegate {
    
    
    var podcasts = [Podcast(trackName: "The Weeknd", artistName: "Abel Tesfaye"), Podcast(trackName: "Bruno Mars", artistName: "Doo Woops Holligon")]
    
    let cellId = "cellId"
    
    //Let's implement UISearchController
    let searchConteroller = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        
        //1. Register a cell for our tableview
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    //MARK:- Setup work here
    
    fileprivate func setupSearchBar(){
        
        navigationItem.searchController = searchConteroller
        navigationItem.hidesSearchBarWhenScrolling = false
        searchConteroller.obscuresBackgroundDuringPresentation = false
        searchConteroller.searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        guard let query = searchConteroller.searchBar.text, !query.trimmingCharacters(in: .whitespaces).isEmpty else{
            return
        }

        print(query)

        APICaller.shared.getSearchResult(for: query) { result in
            switch result{
            case .success(let mdoel): break
            case .failure(let mdoel): break
            }
        }
    }
    
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        // Implementing alamofire iTunes search API
//
//       // let url = "https://itunes.apple.com/search?term=\(searchText)"
////
////        let url = "https://itunes.apple.com/search"
//        let parameters = searchText
//        print(parameters)
//
//        APICaller.shared.getSearchResult(for: parameters) { result in
//            switch result{
//            case .success(let model): break
//            case .failure(let model): break
//            }
//        }
////


//
//        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).response { dataResponse in
//            if let err = dataResponse.error{
//                print(err)
//                return
//            }
//
//            guard let data = dataResponse.data else{
//                return
//            }
//
//            do {
//
//                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
//                print(searchResult.resultCount)
//
//                searchResult.results.forEach { podCast in
//
//                }
//
//                self.podcasts = searchResult.results
//                self.tableView.reloadData()
//
//            }catch let decodeError {
//                print("Failed to Decode:", decodeError)
//            }
//        }
//    }
    
    
    struct SearchResult: Decodable{
        let resultCount: Int
        let results: [Podcast]
    }
    
    //MARK:- UItableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let podcasts = self.podcasts[indexPath.row]
        cell.textLabel?.text = "\(podcasts.trackName ?? "")\n\(podcasts.artistName ?? "")"
        cell.textLabel?.numberOfLines = -1
        cell.imageView?.image = UIImage(named: "appicon")
        
        return cell
    }
    
}
