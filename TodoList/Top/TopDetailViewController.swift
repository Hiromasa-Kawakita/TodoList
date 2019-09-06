//
//  TopDetailViewController.swift
//  Collection_test
//
//  Created by 川北 紘正 on 2019/08/28.
//  Copyright © 2019 川北 紘正. All rights reserved.
//

import UIKit

class TopDetailViewController: UIViewController {
    
    @IBOutlet weak var topDetailCollection: UICollectionView!
    
    var itemArrayDetail: Item!
    var todoItem: TodoItem!
    var todoTitle: String!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "詳細"
        
        topDetailCollection.delegate = self
        topDetailCollection.dataSource = self
        
        //Xib
        let nib = UINib(nibName: "TopDetailCollectionViewCell", bundle: nil)
        self.topDetailCollection.register(nib, forCellWithReuseIdentifier: "detailCellXib")
    }
}




extension TopDetailViewController: UICollectionViewDelegate {
    
}

extension TopDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailCellXib", for: indexPath) as! TopDetailCollectionViewCell
        
//        switch indexPath.row {
//        case 0:
//            cell.detailTitle.text = todoTitle
//        default:
//            return cell
//        }
        cell.todoTextField.text = todoTitle
        return cell
    }

}

extension TopDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let cellSize: CGSize
        let widthSize = UIScreen.main.bounds.width

        cellSize = CGSize(width: widthSize, height: 458)
        return cellSize
    }
}
