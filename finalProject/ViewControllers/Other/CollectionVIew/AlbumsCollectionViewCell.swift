//
//  AlbumsCollectionViewCell.swift
//  finalProject
//
//  Created by Pavel Plyago on 14.08.2024.
//

import UIKit
import SnapKit

class AlbumsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ImageCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let albumName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(albumName)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints(){
        imageView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.8)
        }
        albumName.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().offset(-5)
            $0.leading.equalToSuperview().offset(10)
            $0.top.equalTo(imageView.snp.bottom).offset(5)
        }
    }
    
    func configure(with urlString: String, title: String){
        if let url = URL(string: urlString) {
            self.imageView.sd_setImage(with: url)
        } else {
            print("Invalid url string: \(urlString)")
        }
        
        albumName.text = title
    }
}


