//
//  APICaller.swift
//  Remainder
//
//  Created by Dmitriy Stepanov on 12.09.2022.
//
/*
  0. create struct  with URL
  1. create class APICaller
  2. create instanse shared
  3. create func fetchData (@escaping)
  4. create ULR
  5. create task
  6. create result
  7. resume task
 */

import Foundation
import UIKit

struct Constans {
    static let baseURL = "https://api.themoviedb.org"
    static let API_KEY = "3d8c4618059cb074ba7187853bf758cb"
}
struct TypeOfMovie {
    static let trendingMovies = "/3/trending/movie/day?api_key="
    static let upcomig = "/3/movie/upcoming?api_key="
    static let trendingTvs = "/3/trending/tv/day?api_key="
    static let popular = "/3/movie/popular?api_key="
    static let topRateMove = "/3/movie/top_rated?api_key="
    static let discover = "/3/discover/movie?api_key="
}


struct ConstansFinal : Codable {
   static let baseURL = "https://api.themoviedb.org"
    static let API_Key = "3d8c4618059cb074ba7187853bf758cb"
}

struct TypeMovie : Codable {
    static let trendingMovies = "/3/trending/movie/day?api_key="
    static let upcomig = "/3/movie/upcoming?api_key="
    static let trendingTvs = "/3/trending/tv/day?api_key="
    static let popular = "/3/movie/popular?api_key="
    static let topRateMove = "/3/movie/top_rated?api_key="
    static let discover = "/3/discover/movie?api_key="
}



class API_Caller{
    static let shared = API_Caller()
    
    func fetchData(type: String, completion: @escaping(Result<[VideoTitle], Error>)->()){
        guard let url = URL(string: "\(ConstansFinal.baseURL)\(TypeOfMovie.trendingMovies)\(ConstansFinal.API_Key)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let result = try JSONDecoder().decode(VideoResponce.self, from: data)
                completion(.success(result.results))
                //print(result.results)
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

