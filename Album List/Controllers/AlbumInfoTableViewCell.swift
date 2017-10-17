//
//  AlbumInfoTableViewCell.swift
//  Album List
//
//  Created by Alex Poddubnyy on 14.10.17.
//  Copyright © 2017 Alex Poddubnyy. All rights reserved.
//

import UIKit

class AlbumInfoTableViewCell: UITableViewCell {

    //MARK: Private properties
    @IBOutlet fileprivate weak var artworkImageView: UIImageView!
    @IBOutlet fileprivate weak var albumNameLabel: UILabel!
    @IBOutlet fileprivate weak var albumGenreNameAndYearLabel: UILabel!
    @IBOutlet fileprivate weak var artistNameLabel: UILabel!
    @IBOutlet fileprivate weak var priceLabel: UILabel!
    @IBOutlet fileprivate weak var copyrightLabel: UILabel!

    //MARK: Internal properties
    var album: Album?  {
        didSet {
            artworkImageView.kf.setImage(with: album?.artworkURL())
            albumNameLabel.text = album?.collectionName
            albumGenreNameAndYearLabel.text = album?.formattedGenreNameAndYear()
            artistNameLabel.text = album?.artistName
            priceLabel.text = album?.formattedPrice()
            copyrightLabel.text = album?.copyright
        }
    }
}
