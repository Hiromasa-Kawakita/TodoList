//
//  CategoryViewController.swift
//  Collection_test
//
//  Created by 川北 紘正 on 2019/06/12.
//  Copyright © 2019 川北 紘正. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    var articles: [[String: String?]] = []
    let category_img = ["category_meeting"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        //Xib
        let nib = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
        self.categoryCollectionView.register(nib, forCellWithReuseIdentifier: "categoryCell")
    }
}

extension CategoryViewController: UICollectionViewDelegate {
}

extension CategoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return articles.count;
        return 2;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
        
        switch indexPath.row {
        case 0:
            cell.categoryImage.image = UIImage(named: category_img[indexPath.row])
            cell.categoryLabel.text = "Meeting"
        default:
            cell.categoryImage.image = UIImage(named: "defaultImage")
            cell.categoryLabel.text = ""
        }
        return cell
    }
}

extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthSize = UIScreen.main.bounds.width * 0.42
        return CGSize(width: widthSize, height: widthSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
    }

}
