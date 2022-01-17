//
//  CustomCell.swift
//  LocationTA
//
//  Created by DaninMac on 16.01.22.
//
import UIKit

class CustomCell: UICollectionViewCell {
    
    static let identifier = "CustomCollectionViewCell"
    
    
    //    var data: CustomData? {
    //        didSet {
    //            guard let data = data else { return }
    //            bg.image = data.backgroundImage
    //
    //        }
    //    }
    
    fileprivate let bg: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        iv.image = UIImage(systemName: "house")
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .red
        contentView.layer.cornerRadius = 13
        
        contentView.addSubview(bg)
        
        bg.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        bg.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        bg.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        bg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
