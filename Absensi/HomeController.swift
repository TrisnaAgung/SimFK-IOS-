//
//  HomeController.swift
//  Absensi
//
//  Created by Unit TSI on 07/11/19.
//  Copyright © 2019 technesia. All rights reserved.
//

import UIKit
import ImageSlideshow
import ActionSheetPicker_3_0

class HomeController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var info: UIView!
    @IBOutlet weak var initialLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    let name = ["Jadwal Kuliah","Jadwal Live","Absensi Kehadiran"]
    let image = [UIImage(named: "ic_list")!,UIImage(named: "ic_live")!,UIImage(named: "ic_finger")!]
    var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    @IBAction func logout(_ sender: Any) {
        let preferences = UserDefaults.standard
        preferences.set(false, forKey: "Login")
        preferences.synchronize()
        Switcher.updateRootVC()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionview.dataSource       = self
        collectionview.delegate         = self
        
//        setupCollectionViewItemSize()
        
        var layout                      = self.collectionview.collectionViewLayout as! UICollectionViewFlowLayout
//        layout.sectionInset             = UIEdgeInsetsMake(0, 5, 0, 5)
        layout.minimumInteritemSpacing  = 10
        layout.minimumLineSpacing       = 20
        layout.itemSize                 = CGSize(width: (self.collectionview.frame.size.width - 20)/2,height: self.collectionview.frame.size.height/3)
        info.layer.borderColor          = UIColor.lightGray.cgColor
        info.layer.borderWidth          = 1
        
        if let stringInput = UserDefaults.standard.object(forKey: "nama") as? String {
            let stringInputArr = stringInput.components(separatedBy: " ")
            var stringNeed = ""
            var i = 0
            for string in stringInputArr {
                if i < 3 {
                    stringNeed = stringNeed + String(string.first!)
                }
                i += 1
            }
            if stringNeed.count > 2 {
                initialLabel.font = UIFont.boldSystemFont(ofSize: 38)
            }else{
                initialLabel.font = UIFont.boldSystemFont(ofSize: 45)
            }
            initialLabel.text = "\(stringNeed.uppercased())"
            nameLabel.text = "\(stringInput)"
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return name.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell                = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MenuViewCell
        
        cell.image.image        = image[indexPath.item]
        cell.name.text          = name[indexPath.item]
        cell.layer.borderColor  = UIColor.lightGray.cgColor
        cell.layer.borderWidth  = 0.7
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.item {
        case 0:
            self.performSegue(withIdentifier: "menu1", sender: self)
            break;
        case 1:
            self.performSegue(withIdentifier: "menu2", sender: self)
            break;
        case 2:
            self.performSegue(withIdentifier: "menu3", sender: self)
            break;
        default:
            break;
        }
    }
    private func setupCollectionViewItemSize() {
        if collectionViewFlowLayout == nil {
            let number:CGFloat = 2
            let linespacing:CGFloat = 10
            let interitemspacing:CGFloat = 20
            
            let width = (collectionview.frame.width - (number - 1) * interitemspacing) / number
            let height = width - 10
            
            collectionViewFlowLayout                            = UICollectionViewFlowLayout()
            collectionViewFlowLayout.itemSize                   = CGSize(width: width, height: height)
            collectionViewFlowLayout.sectionInset               = UIEdgeInsets.zero
            collectionViewFlowLayout.scrollDirection            = .vertical
            collectionViewFlowLayout.minimumLineSpacing         = linespacing
            collectionViewFlowLayout.minimumInteritemSpacing    = interitemspacing
        
            
            collectionview.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        }
    }
}

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}


