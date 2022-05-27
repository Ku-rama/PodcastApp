//
//  EpisodeHeaderViewModel.swift
//  PodcastApp
//
//  Created by Makwana Bhavin on 29/03/22.
//

import Foundation

struct EpisodeHeaderViewModel: Codable{
    var title: String?
    var author: String?
    var description: String?
    var podcastCategory: String
    var artworkUrl: String?
}
