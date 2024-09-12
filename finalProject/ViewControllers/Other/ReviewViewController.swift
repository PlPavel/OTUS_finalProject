//
//  ReviewViewController.swift
//  finalProject
//
//  Created by Pavel Plyago on 25.08.2024.
//

import UIKit
import SnapKit

class ReviewViewController: UIViewController {
    
    var urlString: String = ""
    
    private lazy var reviewsTableView: UITableView = {
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
        view.addSubview(reviewsTableView)
        createHeaderView()
        
        reviewsTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func createHeaderView(){
        guard let url = URL(string: urlString) else {
            return
        }
        
        let headerView = UIView(frame: .init(x: 0, y: 0, width: view.frame.width, height: view.frame.width/2))
        
        let imgSize: CGFloat = headerView.frame.size.height / 1.5
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: imgSize, height: imgSize))
        headerView.addSubview(imgView)
        imgView.contentMode = .scaleAspectFill
        imgView.center = headerView.center
        imgView.layer.cornerRadius = 10
        imgView.layer.masksToBounds = true
        imgView.sd_setImage(with: url)
        reviewsTableView.tableHeaderView = headerView
    }

}


extension ReviewViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
}
