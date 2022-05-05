//
//  PopUp.swift
//  BasicCustomView
//
//  Created by taehy.k on 2022/05/05.
//

import UIKit

class PopUp: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func showPopUpTapped(_ sender: Any) {
        print("커스텀 팝업 띄우기")
        guard let customPopUp = self.storyboard?.instantiateViewController(withIdentifier: "CustomPopUp") as? CustomPopUp else { return }
        customPopUp.modalTransitionStyle = .crossDissolve
        customPopUp.modalPresentationStyle = .overFullScreen
        present(customPopUp, animated: true)
    }
}
