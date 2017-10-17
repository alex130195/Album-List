//
//  SongsListTableViewCell.swift
//  Album List
//
//  Created by Alex Poddubnyy on 12.10.17.
//  Copyright © 2017 Alex Poddubnyy. All rights reserved.
//

import UIKit

class TrackTableViewCell: UITableViewCell {

    //MARK: Private properties
    @IBOutlet fileprivate weak var trackNumberLabel: UILabel!
    @IBOutlet fileprivate weak var trackNameLabel: UILabel!
    @IBOutlet fileprivate weak var trackTimeLabel: UILabel!
    
    //MARK: Internal properties
    var track: Track? {
        didSet {
            trackNameLabel.text = track?.trackName
            trackNumberLabel.text = track?.trackNumberFormattedString()
            trackTimeLabel.text = track?.trackTimeFormattedString()
        }
    }
}
