//
//  WelcomePopViewController.swift
//  VSoft
//
//  Created by Shaik Ghouse Basha on 18/3/17.
//  Copyright © 2017 Shaik Ghouse Basha. All rights reserved.
//

import UIKit

class WelcomePopViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func removePopupButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
