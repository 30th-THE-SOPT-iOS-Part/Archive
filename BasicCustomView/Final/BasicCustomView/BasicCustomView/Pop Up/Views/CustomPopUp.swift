//
//  CustomPopUp.swift
//  BasicCustomView
//
//  Created by taehy.k on 2022/05/05.
//

import UIKit

class CustomPopUp: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch = touches.first,
           touch.view == self.view {
            dismiss(animated: true)
        }
    }
    
    private func setupUI() {
        containerView.layer.cornerRadius = 12
        containerView.clipsToBounds = true
        iconImageView.layer.cornerRadius = iconImageView.frame.width/2
    }

    @IBAction func startButtonTapped(_ sender: Any) {
        /*
         이 부분에서 Button에 대한 액션 처리를 해주면 됩니다.
         */
        dismiss(animated: true)
    }
}
