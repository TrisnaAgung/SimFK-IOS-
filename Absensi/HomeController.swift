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

class HomeController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var info: UIView!
    @IBOutlet weak var initialLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    let name = ["Jadwal Kuliah","Jadwal Live","Absensi Kehadiran","History Mengajar"]
    let image = [UIImage(named: "ic_list")!,UIImage(named: "ic_live")!,UIImage(named: "ic_finger")!,UIImage(named: "ic_history")!]
    var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    @IBOutlet weak var helpbutton: UIBarButtonItem!
    @IBAction func logout(_ sender: Any) {
        let preferences = UserDefaults.standard
        preferences.set(false, forKey: "Login")
        preferences.synchronize()
        Switcher.updateRootVC()
    }
    @IBAction func help(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier:"help") as? HelpViewController {
            vc.modalTransitionStyle     = .crossDissolve;
            vc.modalPresentationStyle   = .overCurrentContext
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionview.dataSource       = self
        collectionview.delegate         = self
        
        //create a new button
        let button: UIButton = UIButton(type: UIButtonType.custom)
        //set image for button
        button.setImage(UIImage(named: "ic_help1"), for: UIControlState.normal)
        //add function for button
        button.addTarget(self, action: Selector(("help1")), for: UIControlEvents.touchUpInside)
        //set frame
//        button.frame = CGRectMake(0, 0, 53, 31)
        
        let barButton = UIBarButtonItem(customView: button)
        //assign button to navigationbar
        self.navigationItem.leftBarButtonItem = barButton
        
//        setupCollectionViewItemSize()
        
        var layout                      = self.collectionview.collectionViewLayout as! UICollectionViewFlowLayout
//        layout.sectionInset             = UIEdgeInsetsMake(0, 5, 0, 5)
        layout.minimumInteritemSpacing  = 10
        layout.minimumLineSpacing       = 15
//        layout.itemSize                 = CGSize(width: (self.collectionview.frame.size.width - 20)/2,height: self.collectionview.frame.size.height/3)
//        info.layer.borderColor          = UIColor.lightGray.cgColor
//        info.layer.borderWidth          = 1
        
        if let stringInput = UserDefaults.standard.object(forKey: "nama") as? String {
            let stringInputArr = stringInput.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: " ")
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = view.frame.size.height
//        let height = self.collectionview.frame.size.height/3
        let width = view.frame.size.width
        // in case you you want the cell to be 40% of your controllers view
        return CGSize(width: width * 0.4, height: height * 0.22)
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
        case 3:
            self.performSegue(withIdentifier: "menu4", sender: self)
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
    
    @objc func help1(){
        if let vc = self.storyboard?.instantiateViewController(withIdentifier:"help") as? HelpViewController {
            vc.modalTransitionStyle     = .crossDissolve;
            vc.modalPresentationStyle   = .overCurrentContext
            self.present(vc, animated: true, completion: nil)
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


