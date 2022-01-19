//
//  DetailsViewController.swift
//  LocationTA
//
//  Created by DaninMac on 19.01.22.
//

import UIKit
import AVKit

class DetailsViewControllet: UIViewController {
    
    var imageView: UIImageView = {
        let theImageView = UIImageView()
        theImageView.contentMode = .scaleToFill
        theImageView.translatesAutoresizingMaskIntoConstraints = false
        return theImageView
    }()
    
    var buttonClose: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "exit"), for: .normal)
        button.addTarget(self, action: #selector(buttonClosing), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func buttonClosing(sender : UIButton) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        view.addSubview(buttonClose)
        setUpImageView()
        setUpButton()
        
    }
    
    func setUpImageView() {
        
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    func setUpButton() {
        
        buttonClose.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        buttonClose.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        buttonClose.widthAnchor.constraint(equalToConstant: 50).isActive = true
        buttonClose.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
}
