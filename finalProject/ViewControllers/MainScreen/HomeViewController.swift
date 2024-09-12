//
//  HomeViewController.swift
//  finalProject
//
//  Created by Pavel Plyago on 03.08.2024.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    private var urlSectionsImgItem: [[String]] = [[], [], []]
    private var sectionsNameItem: [[String]] = [[],[], []]
    private var headerTitle: [String] = [
        "Favorite albums",
        "Followed Artist",
        "Popular Playlists"
    ]
    
    private lazy var musicCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HorizontalCollectionViewCell.self,
                                forCellWithReuseIdentifier: HorizontalCollectionViewCell.identifier)
        collectionView.register(HeaderCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: HeaderCollectionReusableView.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(musicCollectionView)
        musicCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        fetchAllData()
        musicCollectionView.reloadData()
    }
    
    func fetchAllData(){
        
        APICaller.shared.getSavedUserAlbum {[weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.fetchData(from: data.items, imagePath: \.album.images, namePath: \.album.name, sectionIndex: 0)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        APICaller.shared.getFollowedArtists {[weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.fetchData(from: data.artists.items, imagePath: \.images, namePath: \.name, sectionIndex: 1)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        APICaller.shared.getFeaturedPlaylist { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async{
                    self?.fetchData(from: data.playlists.items, imagePath: \.images, namePath: \.name, sectionIndex: 2)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func fetchData<T>(from items: [T], imagePath: KeyPath<T, [Image]>, namePath: KeyPath<T, String>, sectionIndex: Int){
        for item in items {
            guard let imageString = item[keyPath: imagePath].first?.url else {
                return
            }
            let name = item[keyPath: namePath]
            self.urlSectionsImgItem[sectionIndex].append(imageString)
            self.sectionsNameItem[sectionIndex].append(name)
        }
        musicCollectionView.reloadData()
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        urlSectionsImgItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalCollectionViewCell.identifier, for: indexPath) as! HorizontalCollectionViewCell
        let urlString = urlSectionsImgItem[indexPath.section]
        let albumsName = sectionsNameItem[indexPath.section]
        cell.configure(with: urlString, nameAlbums: albumsName)
        cell.delegate = self
        cell.section = indexPath.section
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.width/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        guard kind == UICollectionView.elementKindSectionHeader else {
            fatalError("Unexpected element kind")
        }
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                     withReuseIdentifier: HeaderCollectionReusableView.identifier,
                                                                     for: indexPath) as! HeaderCollectionReusableView
        let title = headerTitle[indexPath.section]
        header.configure(with: title)
        return header
    }
    
    

}

extension HomeViewController: HorizontalCollectionDelegate {
    
    func didSelectItem(at indexPath: IndexPath, inSection section: Int) {
        let vc = ReviewViewController()
//        print("\(indexPath.section), \(indexPath.row), \(indexPath.item)")
        vc.urlString = urlSectionsImgItem[section][indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
