//
//  TopViewController.swift
//  Collection_test
//
//  Created by 川北 紘正 on 2019/06/10.
//  Copyright © 2019 川北 紘正. All rights reserved.
//

import UIKit
import RealmSwift

class TopViewController: UIViewController {
    @IBOutlet weak var topTable: UITableView!
    
    private var realm: Realm!
    private var todoList: Results<TodoItem>!
    private var token: NotificationToken!
    
    var scrollBeginPoint: CGFloat = 0.0
    var lastNavigationBarIsHidden = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // RealmのTodoリストを取得し，更新を監視
        realm = try! Realm()
        todoList = realm.objects(TodoItem.self)
        token = todoList.observe { [weak self] _ in
            self?.reload()
        }
    }
    
    deinit {
        token.invalidate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        
        // TopDetailViewから戻ってきた時のnavigationbar再壁画
        if lastNavigationBarIsHidden {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        topTable.delegate = self
        topTable.dataSource = self

        reload()
    }
    

    /*---------------------------------------------------
     *スクロール時のnavigationbar表示/非表示
     *---------------------------------------------------
     */
    // スクロール開始位置
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollBeginPoint = scrollView.contentOffset.y
    }
    
    // スクロール量
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollDiff = scrollBeginPoint - scrollView.contentOffset.y
        updateNavigationBarHiding(scrollDiff: scrollDiff)
    }
    
    // navigationbarの表示/非表示
    func updateNavigationBarHiding(scrollDiff: CGFloat) {
        let boundaryValue: CGFloat = 0.0
        
        /// navigationBar表示
        if scrollDiff > boundaryValue {
            navigationController?.setNavigationBarHidden(false, animated: true)
            lastNavigationBarIsHidden = false
            return
        }
        
        /// navigationBar非表示
        if scrollDiff < -boundaryValue {
            navigationController?.setNavigationBarHidden(true, animated: true)
            lastNavigationBarIsHidden = true
            return
        }
    }
    
    
    
    
    @IBAction func createTodoButton(_ sender: UIBarButtonItem) {
        let dlg = UIAlertController(title: "新しいTodo", message: "", preferredStyle: .alert)
        dlg.addTextField(configurationHandler: nil)
        dlg.addAction(UIAlertAction(title: "リストに追加", style: .default, handler: { action in
            if let t = dlg.textFields![0].text,
                !t.isEmpty {
                self.addTodoItem(title: t)
            }
        }))
        present(dlg, animated: true)
        
    }
    
    // Todoを追加
    func addTodoItem(title: String) {
        try! realm.write {
            realm.add(TodoItem(value: ["title": title]))
        }
    }
    
    // Todoを削除
    func deleteTodoItem(at index: Int) {
        try! realm.write {
            realm.delete(todoList[index])
        }
    }
    
    func reload() {
        topTable.reloadData()
    }
}



extension TopViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        // アイテム削除処理
////        itemarray.remove(at: indexPath.row)
////        let indexPaths = [indexPath]
////        tableView.deleteRows(at: indexPaths, with: .automatic)
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 選択されたセルに実行される処理
//
//        let item = itemarray[indexPath.row]
//
//        item.done = !item.done
//
//        topTable.reloadData()
//
//        // セルを選択した時の背景の変化を遅くする
//        tableView.deselectRow(at: indexPath, animated: true)
        
        
        let vc = UIStoryboard(name: "TopDetailView", bundle: nil).instantiateInitialViewController()! as! TopDetailViewController
        vc.todoTitle = todoList[indexPath.row].title
        navigationController?.pushViewController(vc, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension TopViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = topTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TopTableViewCell
        cell.textLabel?.text = todoList[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        deleteTodoItem(at: indexPath.row)
    }
    
}
