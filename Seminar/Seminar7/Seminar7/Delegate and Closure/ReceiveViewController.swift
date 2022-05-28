//
//  ReceiveViewController.swift
//  Seminar7
//
//  Created by taehy.k on 2022/05/28.
//

import UIKit

protocol CartDelegate {
    func alarmCartIsFilled(itemCount: Int)
}

class ReceiveViewController: UIViewController {
    
    var productName: String = ""
    var price: String = ""
    var delegate: CartDelegate?     // 객체가 가지는 어떤 권한
    var itemCount: Int = 0
    
    var closure: ((Int) -> ())?        // 클로저 선언
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var itemCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    private func setUI() {
        productNameLabel.text = productName
        priceLabel.text = price
        itemCountLabel.text = itemCount.description
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        itemCount = Int(sender.value)
        itemCountLabel.text = Int(sender.value).description
    }
    
    @IBAction func insertCartButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
//        delegate?.alarmCartIsFilled(itemCount: itemCount)   // 권한 중에 이런 액션을 실행할거야, 이런 요청을 날릴거야
        closure?(itemCount)
    }
}
