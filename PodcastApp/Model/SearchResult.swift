//
//  SearchResult.swift
//  PodcastApp
//
//  Created by Makwana Bhavin on 26/03/22.
//

import Foundation

struct SearchResult: Codable{
    let resultCount: Int
    let results: [Podcast]
}
