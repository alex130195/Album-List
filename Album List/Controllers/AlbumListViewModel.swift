//
//  AlbumListViewModel.swift
//  Album List
//
//  Created by Alex Poddubnyy on 14.10.17.
//  Copyright © 2017 Alex Poddubnyy. All rights reserved.
//

import Foundation

class AlbumListViewModel {

    //MARK: Private properties
    fileprivate let queryManager = QueryManager()
    fileprivate var items: [Album] = []
    
    //MARK: Internal API
    func searchItemByArtistName(_ artistName: String, completion: @escaping (RequestStatus) -> ()) {
        queryManager.searchAlbumList(searchTerm: artistName) { requestResults in
            let (items, status) = requestResults
            
            switch status {
            case .Sucess:
                self.items = self.sortItemsAlphabetically(items!)
                completion(status)
            default:
                completion(status)
            }
        }
    }
    
    func sortItemsAlphabetically(_ items: [Album]) -> [Album] {
        return items.sorted {
            $0.collectionName.compare($1.collectionName) == ComparisonResult.orderedAscending
        }
    }
    
    func item(atIndex index: Int) -> Album? {
        if case 0..<items.count = index {
            return items[index]
        }
        
        return nil
    }
    
    func itemsCount() -> Int {
        return items.count
    }
}
