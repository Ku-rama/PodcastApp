//
//  SearchResultViewController.swift
//  PodcastApp
//
//  Created by Makwana Bhavin on 26/03/22.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject{
    func showResults(_ controller: UIViewController)
}

class SearchResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    weak var delegate: SearchResultsViewControllerDelegate?

    private let searchResultTableView : UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.register(SearchResultTableViewCell.self, forCellReuseIdentifier: SearchResultTableViewCell.identifier)
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tv
    }()
    
    var searchResult: SearchResult?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(searchResultTableView)
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        searchResultTableView.isHidden = true
//        searchResultTableView.reloadData()
        
        
    }
    
    func update(with results: SearchResult){
//        searchResultTableView.isHidden = false
        searchResultTableView.isHidden = false
        self.searchResult = results
        searchResultTableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultTableView.frame = view.bounds
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult?.resultCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.identifier, for: indexPath) as? SearchResultTableViewCell else{
            return UITableViewCell()
        }
        cell.configure(with: searchResult?.results[indexPath.row] ?? Podcast(trackName: "", artistName: "", artworkUrl100: ""))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = EpisodesViewController()
        vc.result = searchResult?.results[indexPath.row]
        delegate?.showResults(vc)
    }
}

