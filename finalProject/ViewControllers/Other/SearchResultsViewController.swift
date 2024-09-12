//
//  SearchResultsViewController.swift
//  finalProject
//
//  Created by Pavel Plyago on 18.08.2024.
//

import UIKit

struct SearchSection {
    let title: String
    let data: [String]
}

class SearchResultsViewController: UIViewController {
    
    var sections: [SearchSection] = []
    
    var albumsSearch: [String] = []
    var artistsSearch: [String] = []
    var tracksSearch: [String] = []
    
    lazy var searchTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(searchTableView)
        searchTableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func setUpTableView(){
        sections = [
            SearchSection(title: "Albums", data: albumsSearch),
            SearchSection(title: "Artists", data: artistsSearch),
            SearchSection(title: "Tracks", data: tracksSearch)
        ]
    }
    
}

extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = sections[indexPath.section].data[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section].title
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
