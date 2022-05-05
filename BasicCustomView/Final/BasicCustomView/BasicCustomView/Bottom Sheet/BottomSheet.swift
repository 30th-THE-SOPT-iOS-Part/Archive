//
//  BottomSheet.swift
//  BasicCustomView
//
//  Created by taehy.k on 2022/05/05.
//

import UIKit

class BottomSheet: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func showBottomSheetTapped(_ sender: Any) {
        print("커스텀 바텀시트 띄우기")
        guard let customBottomSheet = self.storyboard?.instantiateViewController(withIdentifier: "CustomBottomSheet") as? CustomBottomSheet else { return }
        customBottomSheet.modalTransitionStyle = .crossDissolve
        customBottomSheet.modalPresentationStyle = .overFullScreen
        present(customBottomSheet, animated: false) {
            customBottomSheet.showBottomSheetWithAnimation()
        }
    }
}
