//
//  ThirdViewController.swift
//  Seminar7
//
//  Created by taehy.k on 2022/05/27.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet var fires: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fires.forEach { $0.isHidden = true }
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(notiReceived),
                                               name: NSNotification.Name("Fire"),
                                               object: nil)
    }
    
    @objc func notiReceived(notification: NSNotification) {
        if let notification = notification.object {
            print(notification)
        }
        fires.forEach { $0.isHidden = false }
    }
}
