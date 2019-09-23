//
//  MainViewController.swift
//  test
//
//  Created by Sheng Zhao Huang on 2019/9/6.
//  Copyright © 2019 Sheng Zhao Huang. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //saddChildVc(storyName: "Home")
//        let vc = UIViewController()
//        vc.view.backgroundColor = UIColor.blue
//        addChild(vc)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    private func addChildVc(storyName:String){
        let chideVc = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        
        addChild(chideVc)
    }


}
