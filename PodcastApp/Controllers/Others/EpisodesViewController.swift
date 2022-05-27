//
//  EpisodesViewController.swift
//  PodcastApp
//
//  Created by Makwana Bhavin on 28/03/22.
//

import UIKit
import FeedKit

class EpisodesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private var episodeFeedback = [Episode]()
    private var episodeViewHeader = EpisodeHeaderViewModel?.self
    
    var result : Podcast?{
        didSet{
            navigationItem.title = result?.trackName
            fetchEpisode()
        }
    }
    
    private var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout{sectionIndex, _ -> NSCollectionLayoutSection? in
        return createSectionLayout(section: sectionIndex)
    })
    
    private static func createSectionLayout(section: Int) -> NSCollectionLayoutSection{
        
        let supplementaryViews = [NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(330)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)]
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(190)), subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = supplementaryViews
        return section
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(EpisodeHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: EpisodeHeaderCollectionReusableView.identifier)
        collectionView.register(EpisodeCollectionViewCell.self, forCellWithReuseIdentifier: EpisodeCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
}

extension EpisodesViewController{
    
    fileprivate func fetchEpisode(){
        
        guard let feedUrl = URL(string: result?.feedUrl ?? "") else{
            return
        }
        print(feedUrl)
        let parser = FeedParser(URL: feedUrl)
        parser.parseAsync { result in
            switch result{
            case .success(let feed):
                switch feed{
                case .rss(let rssFeed):
                    var episodes = [Episode]()
                    rssFeed.items?.forEach({ feedItem in
                        let episode = Episode(feedItem: feedItem)
                        episodes.append(episode)
                    })
                    self.episodeFeedback = episodes
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                default:
                    print("Found feed...")
                }
                break
            case .failure(_):
                break
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: EpisodeHeaderCollectionReusableView.identifier, for: indexPath) as? EpisodeHeaderCollectionReusableView, kind == UICollectionView.elementKindSectionHeader else{
            return UICollectionReusableView()
        }
        let headerViewModel = EpisodeHeaderViewModel(title: result?.trackName ?? "", author: result?.artistName ?? "", description: "", podcastCategory: result?.primaryGenreName ?? "", artworkUrl: result?.artworkUrl100 ?? "")
        header.configure(with: headerViewModel)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return episodeFeedback.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodeCollectionViewCell.identifier, for: indexPath) as? EpisodeCollectionViewCell else{
            return UICollectionViewCell()
        }
        
        let episode = episodeFeedback[indexPath.row]
        cell.trackNameLabel.text = episode.title ?? ""
        cell.descriptoonLabel.text = episode.description ?? ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        cell.dateLabel.text = dateFormatter.string(from: episode.pubDate)
        cell.trackTimeLabel.text = episode.duration
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let navController = PlayerV2ViewController()
        navController.modalPresentationStyle = .fullScreen
        let episode = episodeFeedback[indexPath.row]
        navController.episodeDetails = episode
        self.navigationController?.present(navController, animated: true, completion: nil)
//        PlaybackPresentor.shared.startPlayback(from: self, episode: episode)
    }
}

extension Double {
  func asString(style: DateComponentsFormatter.UnitsStyle) -> String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.hour, .minute, .second, .nanosecond]
    formatter.unitsStyle = style
    return formatter.string(from: self) ?? ""
  }
}

