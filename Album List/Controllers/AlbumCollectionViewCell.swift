//
//  AlbumCollectionViewCell.swift
//  Album List
//
//  Created by Alex Poddubnyy on 11.10.17.
//  Copyright © 2017 Alex Poddubnyy. All rights reserved.
//

import UIKit
import Kingfisher

class AlbumCollectionViewCell: UICollectionViewCell {

    //MARK: Private propertise
    @IBOutlet fileprivate weak var artworkImageView: UIImageView!
    @IBOutlet fileprivate weak var albumNameLabel: UILabel!
    @IBOutlet fileprivate weak var albumYearLabel: UILabel!
    @IBOutlet fileprivate weak var artistNameLabel: UILabel!
    
    //MARK: Internal properties
    var album: Album? {
        didSet {
            artworkImageView.kf.setImage(with: album?.artworkURL())
            albumNameLabel.text = album?.collectionName
            albumYearLabel.text = album?.formattedReleaseDateString()
            artistNameLabel.text = album?.artistName
        }
    }
}
