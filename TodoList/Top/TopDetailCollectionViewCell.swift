//
//  TopDetailCollectionViewCell.swift
//  Collection_test
//
//  Created by 川北 紘正 on 2019/08/29.
//  Copyright © 2019 川北 紘正. All rights reserved.
//

import UIKit
import TextFieldEffects

class TopDetailCollectionViewCell: UICollectionViewCell {
    
    var todoItem: TodoItem!
    
    @IBAction func editButton(_ sender: UIBarButtonItem) {
        todoItem.title = todoTextField.text ?? "なし"
    }
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var todoTextField: HoshiTextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        todoTextField.clearButtonMode = UITextField.ViewMode.always
        
        todoTextField.delegate = self
    }
}

extension TopDetailCollectionViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        todoTextField.resignFirstResponder()
//        outputText.text = textField.text
        return true
    }
}
