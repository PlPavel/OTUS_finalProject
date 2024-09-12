//
//  ProfileViewController.swift
//  finalProject
//
//  Created by Pavel Plyago on 03.08.2024.
//

import UIKit
import SDWebImage

class ProfileViewController: UIViewController {
    
    private var profileInfo: [String] = []
    
    private lazy var profileTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        getProfileInfo()
        view.addSubview(profileTableView)
        profileTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func getProfileInfo(){
        APICaller.shared.getCurrentUserProfile {[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let profileData):
                    self?.profileAPIToString(profileData: profileData)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func profileAPIToString(profileData: UserProfile) {
        profileInfo.append("Full Name: \(profileData.display_name)")
        profileInfo.append("Email: \(profileData.email)")
        profileInfo.append("User ID: \(profileData.id)")
        profileInfo.append("Plan: \(profileData.product)")
        createHeaderProfile(with: profileData.images[1].url)
        profileTableView.reloadData()
    }
    
    func createHeaderProfile(with string: String?) {
        guard let urlString = string, let url = URL(string: urlString) else {
            return
        }
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width/1.5))
        
        let imageSize: CGFloat = headerView.frame.size.height/1.5
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageSize, height: imageSize))
        headerView.addSubview(imageView)
        imageView.center = headerView.center
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageSize/2
        imageView.sd_setImage(with: url)
        profileTableView.tableHeaderView = headerView
    }

}


extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = profileInfo[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
        
}
