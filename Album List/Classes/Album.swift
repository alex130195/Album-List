//
//  AlbumModel.swift
//  Album List
//
//  Created by Alex Poddubnyy on 12.10.17.
//  Copyright © 2017 Alex Poddubnyy. All rights reserved.
//

import Foundation

class Album {
    let artistName: String
    let artworkURLString: String
    let collectionName: String
    let copyright: String 
    let country: String
    let currency: String
    let primaryGenreName: String
    let releaseDate: String
    let trackCount: Int
    let collectionId: Int
    let collectionPrice: Any //collectionPrice is of the Any type, because for some artist iTunes API return not Double type and we get parsing error.
    
    init(artistName: String, artworkURLString: String, collectionName: String, copyright: String,
         country: String, currency: String, primaryGenreName: String, releaseDate: String,
         trackCount: Int, collectionId: Int, collectionPrice: Any) {
        
        self.artistName = artistName
        self.artworkURLString = artworkURLString
        self.collectionName = collectionName
        self.copyright = copyright
        self.country = country
        self.currency = currency
        self.primaryGenreName = primaryGenreName
        self.releaseDate = releaseDate
        self.trackCount = trackCount
        self.collectionId = collectionId
        self.collectionPrice = collectionPrice
    }
    
    func formattedReleaseDateString() -> String {
        let startIndex =  releaseDate.index(releaseDate.startIndex, offsetBy: 0)
        let endIndex = releaseDate.index(startIndex, offsetBy: 3)
        
        return String(releaseDate[startIndex...endIndex])
    }
    
    func formattedGenreNameAndYear () -> String {
        return primaryGenreName + " • " + formattedReleaseDateString()
    }
    
    func artworkURL() -> URL? {
        return URL(string: artworkURLString)
    }
    
    func formattedPrice() -> String {
        if let price = collectionPrice as? NSNumber {
            return String(describing: price) + " " + currency
        }
        
        return ""
    }
}
