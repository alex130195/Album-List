//
//  SongModel.swift
//  Album List
//
//  Created by Alex Poddubnyy on 12.10.17.
//  Copyright © 2017 Alex Poddubnyy. All rights reserved.
//

import Foundation

struct Track {
    let trackName: String
    let trackId: Int
    let discCount: Int
    let discNumber: Int
    let trackNumber: Int
    let trackTimeMillis: Int
    
    func trackNumberFormattedString () -> String {
        return String(trackNumber)
    }
    
    func trackTimeFormattedString () -> String {
        let date = Date(timeIntervalSince1970: Double(trackTimeMillis) / 1000)
        let formatter = DateFormatter()
        formatter.dateFormat = "m:ss"
    
        return formatter.string(from: date)
    }
}
