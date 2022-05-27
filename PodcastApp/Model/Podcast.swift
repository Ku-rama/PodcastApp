//
//  Podcast.swift
//  PodcastApp
//
//  Created by Makwana Bhavin on 04/02/22.
//

import Foundation


struct Podcast: Codable {
    var trackName: String?
    var artistName: String?
    var artworkUrl100: String?
    var feedUrl: String?
    var collectionCensoredName: String?
    var collectionName: String?
    var primaryGenreName: String?
}

