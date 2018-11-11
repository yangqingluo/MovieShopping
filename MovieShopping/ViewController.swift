//
//  ViewController.swift
//  MovieShopping
//
//  Created by 7kers on 2018/11/10.
//  Copyright © 2018年 yang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func goBtnAction(_ sender: UIButton) {
        self.present(YYNavigationController.init(rootViewController: MovieController()), animated: true, completion: {[weak self]()  -> Void in
            print("....")
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

