//
//  EpisodeFeedbackModel.swift
//  PodcastApp
//
//  Created by Makwana Bhavin on 28/03/22.
//

import Foundation
import FeedKit


struct Episode: Codable{
    var title: String?
    var author: String?
    var description: String?
    var explicit: Bool?
    var pubDate: Date
    var duration: String?
    var artworkUrl100: String?
//    var category: String?
    var streamUrl: String?
    
    
//    var episodeArtUrl: String?
    
    init(feedItem: RSSFeedItem){
        self.title = feedItem.title ?? ""
        self.pubDate = feedItem.pubDate ?? Date()
        self.description = feedItem.description ?? ""
        guard let double = feedItem.iTunes?.iTunesDuration else{
            return
        }
        let epidsodeDuration = double.asString(style: .abbreviated)
        self.duration = epidsodeDuration
        self.artworkUrl100 = feedItem.iTunes?.iTunesImage?.attributes?.href
        self.author = feedItem.iTunes?.iTunesAuthor
        self.streamUrl = feedItem.enclosure?.attributes?.url ?? ""
    }
}
