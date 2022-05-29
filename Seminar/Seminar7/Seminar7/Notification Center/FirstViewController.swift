//
//  FirstViewController.swift
//  Seminar7
//
//  Created by taehy.k on 2022/05/27.
//

import UIKit
/// 동시에 여러 객체에 똑같은 이벤트를 전달하고 싶을 때 노티 사용하기 !
/// 첫번째 화면에서 불지르기 버튼 누ㄹ르면 두번째, 세번재 화면에도 전달된다 !
///
class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func fireOnTapped(_ sender: UIButton) {
        
        NotificationCenter.default.post(name: Notification.Name("Fire"), object: self, userInfo: ["data": "string"])
    }

    @IBAction func fireOffTapped(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name("Fire-off"), object: "불 꺼져요!!")
    }
}
