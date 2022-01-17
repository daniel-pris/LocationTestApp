//
//  ViewController.swift
//  LocationTA
//
//  Created by DaninMac on 13.01.22.
//

import UIKit

class ViewController: UIViewController{
    
    let viewLabel: UIView  = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imageLabel: UIImageView = {
        let theImageView = UIImageView()
        theImageView.image = UIImage(named: "labelImage")
        theImageView.translatesAutoresizingMaskIntoConstraints = false
        return theImageView
    }()
    
    let viewArownd: UIView  = {
        let view = UIView()
        view.backgroundColor = .white
        
        view.layer.cornerRadius = 33
        view.layer.shadowColor = UIColor(red: 0.49, green: 0.49, blue: 0.49, alpha: 1).cgColor
        view.layer.shadowOpacity = 0.6
        view.layer.shadowOffset = CGSize(width: -10, height: 16)
        view.layer.shadowRadius = 8
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let viewInside: UIView  = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let locationNameTF: UITextField = {
        let textField =  UITextField()
        textField.placeholder = "Название локации"
        textField.font = UIFont.systemFont(ofSize: 24)
        textField.borderStyle = UITextField.BorderStyle.none
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let button: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "plusImage"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let collectionImagesView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        
        let customCell = UICollectionViewCell()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "CustomCollectionViewCell")
        collectionView .translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionImagesView.delegate = self
        collectionImagesView.dataSource = self
        
        setUpUI()
        
    }
    
    
    func setUpUI() {
        
        view.addSubview(viewLabel)
        view.addSubview(viewArownd)
        view.addSubview(viewInside)
        view.addSubview(button)
        
        viewLabel.addSubview(imageLabel)
        viewInside.addSubview(locationNameTF)
        viewInside.addSubview(collectionImagesView)
        
        setUpViewLabel()
        setUpVectorImage()
        setUpViewAround()
        setUpViewInside()
        setUplocationNameTF()
        setUpCollectionImagesView()
        setUpButton()
        
    }
    
    func setUpViewLabel() {
        
        viewLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 89).isActive = true
        viewLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 4/5).isActive = true
        viewLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/10).isActive = true
        viewLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    
    func setUpVectorImage() {
        
        imageLabel.widthAnchor.constraint(equalTo: viewLabel.widthAnchor).isActive = true
        imageLabel.heightAnchor.constraint(equalTo: viewLabel.heightAnchor).isActive = true
        imageLabel.centerXAnchor.constraint(equalTo: viewLabel.centerXAnchor).isActive = true
        imageLabel.centerYAnchor.constraint(equalTo: viewLabel.centerYAnchor).isActive = true
        
    }
    
    func setUpViewAround() {
        viewArownd.topAnchor.constraint(equalTo: viewLabel.bottomAnchor, constant: 40).isActive = true
        viewArownd.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        viewArownd.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 2/5).isActive = true
        viewArownd.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        viewArownd.layer.cornerRadius = 23
        viewArownd.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.backgroundColor = UIColor(red: 0.979, green: 0.979, blue: 0.979, alpha: 1)
    }
    
    func setUpViewInside() {
        viewInside.topAnchor.constraint(equalTo: viewArownd.topAnchor, constant: 15).isActive = true
        viewInside.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        viewInside.widthAnchor.constraint(equalTo: viewArownd.widthAnchor, constant: -30).isActive = true
        viewInside.heightAnchor.constraint(equalTo: viewArownd.heightAnchor, constant: -30).isActive = true
        viewInside.layer.cornerRadius = 23
        viewInside.backgroundColor = UIColor(red: 0.929, green: 0.953, blue: 0.957, alpha: 1)
        
    }
    
    func setUplocationNameTF() {
        locationNameTF.topAnchor.constraint(equalTo: viewInside.topAnchor, constant: 15).isActive = true
        locationNameTF.leftAnchor.constraint(equalTo: viewInside.leftAnchor, constant: 15).isActive = true
        locationNameTF.widthAnchor.constraint(equalTo: viewInside.widthAnchor, multiplier: 5/7).isActive = true
        locationNameTF.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setUpButton() {
        button.rightAnchor.constraint(equalTo: viewInside.rightAnchor, constant: -15).isActive = true
        button.topAnchor.constraint(equalTo: viewInside.topAnchor, constant: 15).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    
    func setUpCollectionImagesView() {
        collectionImagesView.topAnchor.constraint(equalTo: locationNameTF.bottomAnchor, constant: 15).isActive = true
        collectionImagesView.rightAnchor.constraint(equalTo: viewInside.rightAnchor, constant: -15).isActive = true
        collectionImagesView.leftAnchor.constraint(equalTo: viewInside.leftAnchor, constant: 15).isActive = true
        collectionImagesView.bottomAnchor.constraint(equalTo: viewInside.bottomAnchor, constant: -15).isActive = true
    }
    
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("User tapped on item \(indexPath.row)")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionImagesView.frame.width/3 - 8), height: (collectionImagesView.frame.width/3 - 8))
    }
    
}
