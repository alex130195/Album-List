//
//  TrackListViewModel.swift
//  Album List
//
//  Created by Alex Poddubnyy on 15.10.17.
//  Copyright © 2017 Alex Poddubnyy. All rights reserved.
//

import Foundation

class TrackListViewModel {
    
    //MARK: Prviate properties
    fileprivate let queryManager = QueryManager()
    fileprivate var items : [Track] = []
    
    //MARK: Internal API
    func searchItemByAlbumId(_ albumId: Int, completion: @escaping (RequestStatus) -> ()) {
        queryManager.searchTrackList(searchTerm: albumId) { requestResults in
            let (items, status) = requestResults
            
            switch status {
            case .Sucess:
                self.items = items!
                completion(status)
            default:
                completion(status)
            }
        }
    }
 
    func item(atIndex index: Int) -> Track? {
        if case 0..<items.count = index {
            return items[index]
        }
        
        return nil
    }
    
    func itemsCount() -> Int {
        return items.count
    }
}
