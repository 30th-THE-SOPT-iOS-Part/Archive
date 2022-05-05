//
//  ViewPager.swift
//  BasicCustomView
//
//  Created by taehy.k on 2022/05/05.
//

import UIKit

class ViewPager: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func showViewPagerTapped(_ sender: Any) {
        print("뷰 페이저 화면으로 전환하기")
        guard let customViewPager = self.storyboard?.instantiateViewController(withIdentifier: "CustomViewPager") as? CustomViewPager else { return }
        self.navigationController?.pushViewController(customViewPager, animated: true)
    }
}
