//
//  VideoModels.swift
//  Remainder
//
//  Created by Dmitriy Stepanov on 13.09.2022.
//

import Foundation



struct VideoResponce : Codable {
    let results : [VideoTitle]
}

struct VideoTitle: Codable {
    let id : Int
    let original_language: String?
    let title: String?
    let overview: String?
    let release_date: String?
    let poster_path: String?
    let vote_average: Double?
    let vote_count: Int?
    
}
