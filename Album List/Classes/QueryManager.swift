//
//  DataManager.swift
//  Album List
//
//  Created by Alex Poddubnyy on 12.10.17.
//  Copyright © 2017 Alex Poddubnyy. All rights reserved.
//

import Foundation
import Alamofire

class QueryManager {
    typealias JSONDictionary = [String: Any]
    typealias QueryAlbumResult = (([Album]?, RequestStatus)) -> ()
    typealias QueryTrackResult = (([Track]?, RequestStatus)) -> ()
    
    //MARK: Internal API
    func searchAlbumList(searchTerm: String, completion: @escaping QueryAlbumResult) {
        let parameters: Parameters = ["media": "music",
                                      "entity" : "album",
                                      "term" : searchTerm]
        
        Alamofire.request("https://itunes.apple.com/search", parameters: parameters).responseJSON { response in
            
            guard response.error == nil else {
                return completion((nil, .Error(error: .RequestError)))
            }
            
            let results = self.updateAlbumList(response)
            completion(results)
        }
    }
    
    func searchTrackList(searchTerm: Int, completion: @escaping QueryTrackResult) {
        let parameters: Parameters = ["id": searchTerm,
                                      "entity" : "song"]
        
        Alamofire.request("https://itunes.apple.com/lookup", parameters: parameters).responseJSON { response in
            
            guard response.error == nil else {
                return completion((nil, .Error(error: .RequestError)))
            }
            
            let results = self.updateTrackList(response)
            completion(results)
        }
    }
}

//MARK: Private API
private extension QueryManager {
    func updateAlbumList(_ response: DataResponse<Any>) -> ([Album]?, RequestStatus) {
        var albumList: [Album] = []
        
        guard let json = response.result.value as? JSONDictionary else {
            return (nil, .Error(error: .ParseError))
        }
        
        guard let albumsArray = json["results"] as? [Any] else {
            return (nil, .Error(error: .ParseError))
        }
        
        for trackDictionary in albumsArray {
            if let trackDictionary = trackDictionary as? JSONDictionary,
                let artistName = trackDictionary["artistName"] as? String,
                let artworkURLString = trackDictionary["artworkUrl100"] as? String,
                let collectionName = trackDictionary["collectionName"] as? String,
                let copyright = trackDictionary["copyright"] as? String,
                let country = trackDictionary["country"] as? String,
                let currency = trackDictionary["currency"] as? String,
                let primaryGenreName = trackDictionary["primaryGenreName"] as? String,
                let releaseDate = trackDictionary["releaseDate"] as? String,
                let trackCount = trackDictionary["trackCount"] as? Int,
                let collectionId = trackDictionary["collectionId"] as? Int,
                let collectionPrice = trackDictionary["collectionPrice"] as? Any {
                
                let album = Album(artistName: artistName,
                                  artworkURLString: artworkURLString,
                                  collectionName: collectionName,
                                  copyright: copyright,
                                  country: country,
                                  currency: currency,
                                  primaryGenreName: primaryGenreName,
                                  releaseDate: releaseDate,
                                  trackCount: trackCount,
                                  collectionId: collectionId,
                                  collectionPrice: collectionPrice)
                
                albumList.append(album)
            } else {
                return (nil, .Error(error: .ParseError))
            }
        }
        
        if albumList.isEmpty {
            return (albumList, .Error(error: .NoFind))
        }
        
        return (albumList, .Sucess)
    }
    
    func updateTrackList(_ response: DataResponse<Any>) -> ([Track]?, RequestStatus) {
        var trackList: [Track] = []
        
        guard let json = response.result.value as? JSONDictionary else {
            return (nil, .Error(error: .ParseError))
        }
        
        guard let trackArray = json["results"] as? [Any] else {
            return (nil, .Error(error: .ParseError))
        }
        
        for (number, trackDictionary) in trackArray.enumerated() {
            if number == 0 { continue } //Skip first object, first object contains information about album
            if let trackDictionary = trackDictionary as? JSONDictionary,
                let trackName = trackDictionary["trackName"] as? String,
                let trackId = trackDictionary["trackId"] as? Int,
                let discCount = trackDictionary["discCount"] as? Int,
                let discNumber = trackDictionary["discNumber"] as? Int,
                let trackNumber = trackDictionary["trackNumber"] as? Int,
                let trackTimeMillis = trackDictionary["trackTimeMillis"] as? Int {
                
                let track = Track(trackName: trackName,
                                  trackId: trackId,
                                  discCount: discCount,
                                  discNumber: discNumber,
                                  trackNumber: trackNumber,
                                  trackTimeMillis: trackTimeMillis)
                
                trackList.append(track)
                
            } else {
                return (nil, .Error(error: .ParseError))
            }
        }
        
        if trackList.isEmpty {
            return (trackList, .Error(error: .NoFind))
        }
        
        return (trackList, .Sucess)
    }
}
