//
//  APICaller.swift
//  NetflixClone
//
//  Created by MOHAMED ABD ELHAMED AHMED on 26/03/2022.
//

import Foundation

struct Constants {
    static let API_KEY = "08f1700bc8ebda5302e938028a9d0387"
    static let baseURl = "https://api.themoviedb.org"
    static let YoutubeAPI_KEY = "AIzaSyDqX8axTGeNpXRiISTGL7Tya7fjKJDYi4g"
    static let YoutubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}

enum ApiError :  Error{
    case failedTogetData
}


class APICaller {
    static let shared = APICaller()
    
    func getTrendingMovies(completion: @escaping (Result<[Titles],Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURl)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else { return print("Error in URL Of API")}
        let task  = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data , error == nil else { return }
            do {
                let results = try JSONDecoder().decode(TrendingTitlesResponse.self, from: data)
                guard let results = results.results else {return}
                completion(.success(results))
            }catch{
                completion(.failure(ApiError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func getTrendingTvs(completion: @escaping (Result<[Titles],Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURl)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else { return print("Error in URL Of API")}
        let task  = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data , error == nil else { return }
            do {
                let results = try JSONDecoder().decode(TrendingTitlesResponse.self, from: data)
                guard let results = results.results else {return}
                completion(.success(results))
            }catch{
                completion(.failure(ApiError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func getUpcomingMovies(completion: @escaping (Result<[Titles],Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURl)/3/movie/upcoming?api_key=\(Constants.API_KEY)") else { return print("Error in URL Of API")}
        let task  = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data , error == nil else { return }
            do {
                let results = try JSONDecoder().decode(TrendingTitlesResponse.self, from: data)
                guard let results = results.results else {return}
                completion(.success(results))
            }catch{
                completion(.failure(ApiError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func getPopularMovies(completion: @escaping (Result<[Titles],Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURl)/3/movie/popular?api_key=\(Constants.API_KEY)") else { return print("Error in URL Of API")}
        let task  = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data , error == nil else { return }
            do {
                let results = try JSONDecoder().decode(TrendingTitlesResponse.self, from: data)
                guard let results = results.results else {return}
                completion(.success(results))
            }catch{
                completion(.failure(ApiError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func getTopRatedvMovies(completion: @escaping (Result<[Titles],Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURl)/3/movie/top_rated?api_key=\(Constants.API_KEY)") else { return print("Error in URL Of API")}
        let task  = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data , error == nil else { return }
            do {
                let results = try JSONDecoder().decode(TrendingTitlesResponse.self, from: data)
                guard let results = results.results else {return}
                completion(.success(results))
            }catch{
                completion(.failure(ApiError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func getDiscoverMovies(completion: @escaping (Result<[Titles],Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURl)/3/discover/movie?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else { return print("Error in URL Of API")}
        let task  = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data , error == nil else { return }
            do {
                let results = try JSONDecoder().decode(TrendingTitlesResponse.self, from: data)
                guard let results = results.results else {return}
                completion(.success(results))
            }catch{
                completion(.failure(ApiError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func search(with query: String, completion: @escaping (Result<[Titles],Error>) -> Void) {
        guard let query =  query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.baseURl)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else { return print("Error in URL Of API")}
        let task  = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data , error == nil else { return }
            do {
                let results = try JSONDecoder().decode(TrendingTitlesResponse.self, from: data)
                guard let results = results.results else {return}
                completion(.success(results))
            }catch{
                completion(.failure(ApiError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func getMovie(with query: String, completion: @escaping (Result<VideoElement,Error>) -> Void ) {
        guard let query =  query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.YoutubeBaseURL)q=\(query)&key=\(Constants.YoutubeAPI_KEY)") else { return print("Error in URL Of API")}
        let task  = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data , error == nil else { return }
            do {
                let results = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                completion(.success(results.items[0]))
            }catch{
                completion(.failure(ApiError.failedTogetData))
            }
        }
        task.resume()
    }
}
