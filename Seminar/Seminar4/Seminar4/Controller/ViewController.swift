//
//  ViewController.swift
//  Seminar4
//
//  Created by taehy.k on 2022/05/06.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // 로그인 버튼을 눌렀을 때 로그인 서버 통신 함수를 호출합니다.
    @IBAction func loginButtonTapped(_ sender: Any) {
        print("로그인")
        login()
    }
}

extension ViewController {
    
    // 서버 통신 코드를 실제로 뷰 컨트롤러에서 호출해서 사용하는 부분입니다.
    func login() {
        
        // 각각의 텍스트 필드의 있는 값을 받아옵니다.
        guard let name = nameTextField.text else { return }
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        // 서버 통신 서비스 코드를 싱글톤 변수를 통해서 접근하고 있네요.
        // 호출 후에 받은 응답을 가지고, 적절한 처리를 해주고 있습니다.
        UserService.shared.login(
            name: name,
            email: email,
            password: password) { response in
            switch response {
            case .success(let data):
                guard let data = data as? LoginResponse else { return }
                print(data)
                self.alert(message: data.message)
            case .requestErr(let err):
                print(err)
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
    
    // 알림창을 띄우는 함수입니다.
    func alert(message: String) {
        let alertVC = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertVC.addAction(okAction)
        present(alertVC, animated: true)
    }
}
