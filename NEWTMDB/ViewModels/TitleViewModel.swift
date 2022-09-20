//
//  VideoCellViewModel.swift
//  Remainder
//
//  Created by Dmitriy Stepanov on 13.09.2022.
//

import Foundation

class TitleViewModel {
    
    let id : Int?
    let original_language : String?
    let overview : String?
    let imageURL : String?
    let release_date : String?
    let title : String?
    let vote_average : Double?
    let vote_count : Int?
    var imageData : Data? = nil
    
    init ( id : Int?,
           original_language : String?,
           overview : String?,
           imageURL : String?,
           release_date : String?,
           title : String?,
           vote_average : Double?,
           vote_count : Int?
    ) {
        self.id = id
        self.original_language = original_language
        self.overview = overview
        self.imageURL = imageURL
        self.release_date = release_date
        self.title = title
        self.vote_average = vote_average
        self.vote_count = vote_count
    }
}
