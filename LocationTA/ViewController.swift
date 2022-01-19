//
//  ViewController.swift
//  LocationTA
//
//  Created by DaninMac on 13.01.22.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import SDWebImage

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var images = [LocImage]()
    
    var dbRef: DatabaseReference!
    
    let imagePicker = UIImagePickerController()
    
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
    
    let viewAround: UIView  = {
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
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func buttonTapped(sender : UIButton) {
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("image was chosen")
        dismiss(animated: true, completion: nil)
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            var data = Data()
            let imageName = NSUUID().uuidString
            data = pickedImage.jpegData(compressionQuality: 0.8)!
            
            let imageRef = Storage.storage().reference().child("images/" + imageName)
            
            _ = imageRef.putData(data, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    print(error as Any)
                    return
                }
                
                Storage.storage().reference().child("images/" + imageName).downloadURL(completion: { (url, error) in
                    if error != nil {
                        print(error as Any)
                        return
                    } else {
                        let imageurl = url
                        print(imageurl?.absoluteString ?? "")
                        
                        let key = self.dbRef.childByAutoId().key
                        let image = ["url": imageurl?.absoluteString]
                        
                        let childUpdates = ["/\(String(describing: key))": image]
                        self.dbRef.updateChildValues(childUpdates)
                    }
                    
                    
                })
                
            })
            
        }
    }
    
    
    
    let collectionImagesView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        
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
        
        dbRef = Database.database().reference().child("images")
        
        loadDB()
        setUpUI()
        
    }
    
    
    func loadDB() {
        
        dbRef.observe(DataEventType.value) { (snapshot) in
            var newImage = [LocImage]()
            
            for locImageSnapshot in snapshot.children {
                let LocImageOdject = LocImage(snapshot: locImageSnapshot as! DataSnapshot)
                newImage.append(LocImageOdject)
            }
            self.images = newImage
            self.collectionImagesView.reloadData()
        }
    }
    
    func setUpUI() {
        
        view.addSubview(viewLabel)
        view.addSubview(viewAround)
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
        viewAround.topAnchor.constraint(equalTo: viewLabel.bottomAnchor, constant: 40).isActive = true
        viewAround.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        viewAround.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 5/6).isActive = true
        viewAround.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        viewAround.layer.cornerRadius = 23
        viewAround.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.backgroundColor = UIColor(red: 0.979, green: 0.979, blue: 0.979, alpha: 1)
    }
    
    func setUpViewInside() {
        viewInside.topAnchor.constraint(equalTo: viewAround.topAnchor, constant: 15).isActive = true
        viewInside.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        viewInside.widthAnchor.constraint(equalTo: viewAround.widthAnchor, constant: -30).isActive = true
        viewInside.heightAnchor.constraint(equalTo: viewAround.heightAnchor, constant: -30).isActive = true
        viewInside.layer.cornerRadius = 13
        viewInside.backgroundColor = UIColor(red: 0.929, green: 0.953, blue: 0.957, alpha: 1)
        
    }
    
    func setUplocationNameTF() {
        locationNameTF.topAnchor.constraint(equalTo: viewInside.topAnchor, constant: 15).isActive = true
        locationNameTF.leftAnchor.constraint(equalTo: viewInside.leftAnchor, constant: 15).isActive = true
        locationNameTF.widthAnchor.constraint(equalTo: viewInside.widthAnchor, multiplier: 5/7).isActive = true
        locationNameTF.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func setUpButton() {
        button.rightAnchor.constraint(equalTo: viewInside.rightAnchor, constant: -15).isActive = true
        button.topAnchor.constraint(equalTo: viewInside.topAnchor, constant: 15).isActive = true
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        button.widthAnchor.constraint(equalToConstant: 32).isActive = true
    }
    
    
    func setUpCollectionImagesView() {
        collectionImagesView.topAnchor.constraint(equalTo: locationNameTF.bottomAnchor, constant: 12).isActive = true
        collectionImagesView.rightAnchor.constraint(equalTo: viewInside.rightAnchor, constant: -15).isActive = true
        collectionImagesView.leftAnchor.constraint(equalTo: viewInside.leftAnchor, constant: 15).isActive = true
        collectionImagesView.bottomAnchor.constraint(equalTo: viewInside.bottomAnchor, constant: -10).isActive = true
    }
    
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
        let image = images[indexPath.row]
        cell.bg.sd_setImage(with: URL(string: image.url), placeholderImage: nil)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("User tapped on item \(indexPath.row)")

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
        let image = images[indexPath.row]
        cell.bg.sd_setImage(with: URL(string: image.url), placeholderImage: nil)
        
        let detailsVC = DetailsViewControllet()
        detailsVC.imageView = cell.bg
        detailsVC.modalPresentationStyle = .fullScreen
        self.present(detailsVC, animated: true, completion: nil)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionImagesView.frame.width/3 - 6), height: (collectionImagesView.frame.height/2 - 6))
    }
    
}
