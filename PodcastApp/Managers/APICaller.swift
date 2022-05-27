//
//  APICaller.swift
//  PodcastApp
//
//  Created by Makwana Bhavin on 25/03/22.
//

import Foundation

final class APICaller{
    static let shared = APICaller()
    
    private init(){}
    
    struct Constants{
        static let baseUrl = "https://itunes.apple.com/search"
    }
    
    enum APIError: Error{
        case failedToGetData
    }
    
    enum HTTPMethod: String{
        case GET
        case POST
    }
    
    public func getSearchResult(for searchText: String, completion: @escaping(Result<SearchResult, Error>) -> Void){
        
//        let url = "https://itunes.apple.com/search?term=\(searchText)"
        let url = Constants.baseUrl + "?term=\(searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        print(url)
        
        createRequest(with: URL(string: url), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else{
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do{
                    let json1 = try JSONDecoder().decode(SearchResult.self, from: data)
//                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    
                    completion(.success(json1))
                } catch {
                    print(error)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    
    private func createRequest(with url: URL?, type: HTTPMethod, completion: @escaping(URLRequest) -> Void){
        
        guard let apiUrl = url else{
            return
        }
        
        var request = URLRequest(url: apiUrl)
        request.httpMethod = type.rawValue
        request.timeoutInterval = 30
        completion(request)
    }
}
