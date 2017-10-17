//
//  ViewController.swift
//  Album List
//
//  Created by Alex Poddubnyy on 11.10.17.
//  Copyright © 2017 Alex Poddubnyy. All rights reserved.
//

import UIKit

class AlbumListViewController: UIViewController {
    
    //MARK: Private propertis
    @IBOutlet fileprivate weak var albumListCollectionView: UICollectionView!
    
    fileprivate var searchBar = UISearchBar()
    fileprivate let viewModel = AlbumListViewModel()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.titleView?.isHidden = false
    }
}

//MARK: ConfigureView
extension AlbumListViewController {
    func configureView() {
        let nib = UINib(nibName: "AlbumCollectionViewCell", bundle: nil)
        albumListCollectionView.register(nib, forCellWithReuseIdentifier: "albumCell")

        searchBar.placeholder = "Artist name"
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        if #available(iOS 11.0, *) {
            searchBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
        }
    }
}

//MARK: UICollectionViewDataSource
extension AlbumListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.itemsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "albumCell", for: indexPath) as! AlbumCollectionViewCell
        cell.album = viewModel.item(atIndex: indexPath.row)
        return cell
    }
}

//MARK: UICollectionViewDelegate
extension AlbumListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let album = viewModel.item(atIndex: indexPath.row) else {
            return
        }
        
        hideSearchBar(true)
        
        let trackListViewController = TrackListViewController(with: album)
        navigationController?.pushViewController(trackListViewController, animated: true)
    }
}

//MARK: UICollectionViewDelegateFlowLayout
extension AlbumListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       
        let collectionViewWidth = collectionView.frame.size.width
        let collectinViewCellsWidth: CGFloat = 150 * 2
        let inset = (collectionViewWidth - collectinViewCellsWidth) / 4
  
        return UIEdgeInsetsMake(0, inset, 0, inset)
    }
}

//MARK: UISearchBarDelegate
extension AlbumListViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
        searchBar.text = nil
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()

        if !(searchBar.text!.isEmpty) {
            searchAlbumListByArtist(artistName: searchBar.text!)
        } else {
            searchBar.showsCancelButton = false
        }
    }
}

//MARK: UIScrollViewDelegate
extension AlbumListViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
}

//MARK: Supporting methods
private extension AlbumListViewController {
    func searchAlbumListByArtist(artistName: String) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        viewModel.searchItemByArtistName(searchBar.text!) { responseStatus in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false

            switch responseStatus {
            case .Sucess:
                self.updateView()
            case .Error(let error):
                self.showAlert(withMessage: error.rawValue)
            }
        }
    }
    
    func showAlert(withMessage message: String) {
        let alertController = UIAlertController(title: nil, message: message , preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func updateView() {
        self.albumListCollectionView.reloadData()
        self.albumListCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
    func hideSearchBar(_ hide: Bool) {
        searchBar.endEditing(hide)
        navigationItem.titleView?.isHidden = hide
    }
}
