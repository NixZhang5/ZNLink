//
//  ViewController.swift
//  ZNLink
//
//  Created by xinpin on 2018/11/14.
//  Copyright © 2018年 Nix. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Response
    @IBAction func clickSingleLinkAction() {
        let vc = SingleLinkViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

