//
//  SplashViewController.swift
//  TodoList
//
//  Created by 川北 紘正 on 2019/09/03.
//  Copyright © 2019 川北 紘正. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    //    var logoImageView: UIImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    typealias CompletionClosure = ((_ result:Int) -> Void)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hogeC()
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let nextView = storyboard.instantiateInitialViewController()
//        self.present(nextView!, animated: true, completion: nil)
    }

    
    func hogeC() {
        hogeD(completionClosure: { (result:Int) in
            print(result)
        })
        
    }
    
    func hogeD(completionClosure:@escaping CompletionClosure) {
        //少し縮小するアニメーション
        UIView.animate(withDuration: 0.3,
                       delay: 1.0,
                       options: UIView.AnimationOptions.curveEaseOut,
                       animations: { () in
                        self.logoImageView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: { (Bool) in
            completionClosure(1)
        })
        
        //拡大させて、消えるアニメーション
        UIView.animate(withDuration: 0.2,
                       delay: 1.3,
                       options: UIView.AnimationOptions.curveEaseOut,
                       animations: { () in
                        self.logoImageView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                        self.logoImageView.alpha = 0
        }, completion: { (Bool) in
            self.logoImageView.removeFromSuperview()
            completionClosure(2)
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextView = storyboard.instantiateInitialViewController()
//            let nextView = TopViewController()
            self.present(nextView!, animated: false, completion: nil)
        })
    }
}

