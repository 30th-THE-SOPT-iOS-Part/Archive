//
//  FirstViewController.swift
//  Seminar7
//
//  Created by taehy.k on 2022/05/27.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func fireOnTapped(_ sender: UIButton) {
        
        NotificationCenter.default.post(name: Notification.Name("Fire"), object: "불 났어요!!")
    }

    @IBAction func fireOffTapped(_ sender: UIButton) {
    }
}
