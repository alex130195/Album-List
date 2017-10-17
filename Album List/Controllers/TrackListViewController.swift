//
//  AlbubInfoViewController.swift
//  Album List
//
//  Created by Alex Poddubnyy on 12.10.17.
//  Copyright © 2017 Alex Poddubnyy. All rights reserved.
//

import UIKit

class TrackListViewController: UIViewController {
    
    //MARK: Private properties
    @IBOutlet fileprivate weak var trackListTableView: UITableView!
    
    fileprivate let viewModel = TrackListViewModel()
    fileprivate let album: Album
    
    //MARK: Lifecycle
    init(with album: Album) {
        self.album = album
        
        super.init(nibName: "TrackListViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
        loadData()
    }
}

//MARK: ConfigureView
extension TrackListViewController {
    func configureView () {
        let trackNib = UINib(nibName: "TrackTableViewCell", bundle: nil)
        let albumInfoNib = UINib(nibName: "AlbumInfoTableViewCell", bundle: nil)
        
        trackListTableView.register(trackNib, forCellReuseIdentifier: "trackCell")
        trackListTableView.register(albumInfoNib, forCellReuseIdentifier: "albumInfoCell")
        
        trackListTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
}

//MARK: UITableViewDataSource
extension TrackListViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return viewModel.itemsCount()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "albumInfoCell") as! AlbumInfoTableViewCell
            cell.album = album
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "trackCell") as! TrackTableViewCell
            cell.track = viewModel.item(atIndex: indexPath.row)
            return cell
        }
    }
}

//MARK: UITableViewDelegate
extension TrackListViewController : UITableViewDelegate { }

//MARK: Supporting methods
private extension TrackListViewController {
    func loadData() {
        viewModel.searchItemByAlbumId(album.collectionId) { responseStatus in
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
        self.trackListTableView.reloadData()
        self.trackListTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
}
