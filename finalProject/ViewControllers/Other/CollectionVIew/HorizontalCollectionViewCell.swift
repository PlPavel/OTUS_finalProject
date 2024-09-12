//
//  HorizontalCollectionViewCell.swift
//  finalProject
//
//  Created by Pavel Plyago on 15.08.2024.
//

import UIKit

protocol HorizontalCollectionDelegate: AnyObject {
    func didSelectItem(at indexPath: IndexPath, inSection section: Int)
}

class HorizontalCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: HorizontalCollectionDelegate?
    var section: Int = 0
    
    static let identifier = "HorizontalCollectionViewCell"
    
    private var urlImageSavedAlbums: [String] = []
    private var nameOfAlbums: [String] = []
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: 120, height: 120)
        layout.minimumInteritemSpacing = 10
        return layout
    }()
    
    private lazy var lineCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(AlbumsCollectionViewCell.self, forCellWithReuseIdentifier: AlbumsCollectionViewCell.identifier)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(lineCollectionView)
        lineCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 3))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with urlStrings: [String], nameAlbums: [String]) {
        self.urlImageSavedAlbums = urlStrings
        self.nameOfAlbums = nameAlbums
        lineCollectionView.reloadData()
    }
    
}


extension HorizontalCollectionViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return urlImageSavedAlbums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumsCollectionViewCell.identifier, for: indexPath) as! AlbumsCollectionViewCell
        let urlString = urlImageSavedAlbums[indexPath.row]
        let nameAlbum = nameOfAlbums[indexPath.row]
        cell.configure(with: urlString, title: nameAlbum)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItem(at: indexPath, inSection: section)
    }
    
    
}
