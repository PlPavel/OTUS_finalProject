//
//  SearchViewController.swift
//  finalProject
//
//  Created by Pavel Plyago on 03.08.2024.
//

import UIKit

class SearchViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    private lazy var searchMusicBar: UISearchController = {
        let searchController = UISearchController(searchResultsController: SearchResultsViewController())
        searchController.searchBar.placeholder = "Songs, Artists, Albums"
        
        return searchController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.searchController = searchMusicBar
        searchMusicBar.searchResultsUpdater = self
        searchMusicBar.searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let resultController = searchMusicBar.searchResultsController as? SearchResultsViewController,
              let query = searchBar.text, !query.isEmpty else {
            return
        }
        APICaller.shared.searchForItem(query: query) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    data.albums.items.forEach({ item in
                        resultController.albumsSearch.append("\(item.name) - \(item.artists[0].name)")
                    })
                    data.artists.items.forEach({ item in
                        resultController.artistsSearch.append(item.name)
                    })
                    data.tracks.items.forEach({ item in
                        resultController.tracksSearch.append("\(item.album.name) - \(item.artists[0].name)")
                    })
                    resultController.setUpTableView()
                    resultController.searchTableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    

}
