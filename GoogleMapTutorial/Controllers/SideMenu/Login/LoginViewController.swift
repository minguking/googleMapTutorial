//
//  LoginViewController.swift
//  GoogleMapTutorial
//
//  Created by Kang Mingu on 2021/02/22.
//

import UIKit

class LoginViewController: BaseViewController {
    
    // MARK: - Properties
    
    let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "ic_login_iparking")
        iv.setDimensions(width: 180, height: 90)
        return iv
    }()
    
    let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "ic_login_cancel"), for: .normal)
        button.addTarget(self, action: #selector(dismissButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    lazy var idTextField: UITextField = {
        let tf = UITextField()
        tf.delegate = self
        tf.placeholder = "아이디를 입력하세요"
        tf.textColor = .black
        tf.font = .systemFont(ofSize: 15, weight: .regular)
        tf.returnKeyType = .next
        tf.isSecureTextEntry = false
        tf.clearButtonMode = .whileEditing
        tf.tag = 0
        return tf
    }()
    
    lazy var pwTextField: UITextField = {
        let tf = UITextField()
        tf.delegate = self
        tf.placeholder = "비밀번호를 입력하세요"
        tf.textColor = .black
        tf.font = .systemFont(ofSize: 15, weight: .regular)
        tf.returnKeyType = .done
        tf.isSecureTextEntry = true
        tf.clearButtonMode = .whileEditing
        tf.tag = 1
        return tf
    }()
    
    let rememberView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let idCheckButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "check_round_off"), for: .normal)
        button.setImage(UIImage(named: "check_round_on"), for: .selected)
        button.setTitle("아이디 저장", for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
        button.addTarget(self, action: #selector(idCheckButtonDidTap(sender:)), for: .touchUpInside)
        return button
    }()
    
    let autoLoginButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "check_round_off"), for: .normal)
        button.setImage(UIImage(named: "check_round_on"), for: .selected)
        button.setTitle("자동 로그인", for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
        button.addTarget(self, action: #selector(autoLoginButtonDidTap(sender:)), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        idTextField.layer.addBorder([.bottom], color: .lightGray, width: 1.0)
        pwTextField.layer.addBorder([.bottom], color: .lightGray, width: 1.0)
    }
    
    
    // MARK: - Selectors
    
    @objc func dismissButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func idCheckButtonDidTap(sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @objc func autoLoginButtonDidTap(sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    
    // MARK: - Helpers
    
    override func configureUI() {
        
        let textFieldStackView = UIStackView(arrangedSubviews: [idTextField, pwTextField])
        textFieldStackView.axis = .vertical
        textFieldStackView.spacing = 0
        textFieldStackView.distribution = .fillEqually
        
        view.backgroundColor = .white
        
        rememberView.addSubview(idCheckButton)
        rememberView.addSubview(autoLoginButton)
        
        idCheckButton.setDimensions(width: 100, height: 30)
        idCheckButton.centerY(inView: rememberView, leftAnchor: rememberView.leftAnchor, paddingLeft: 0)
        autoLoginButton.setDimensions(width: 100, height: 30)
        autoLoginButton.centerY(inView: rememberView, rightAncher: rememberView.rightAnchor, paddingRight: 10)
        
        view.addSubview(logoImageView)
        view.addSubview(dismissButton)
        view.addSubview(textFieldStackView)
        view.addSubview(rememberView)
        
        dismissButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, right: view.rightAnchor, paddingTop: 10, paddingRight: 10)
        logoImageView.centerX(inView: view, topAnchor: dismissButton.bottomAnchor, paddingTop: 10)
        textFieldStackView.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                                  paddingTop: 30, paddingLeft: 20, paddingRight: 20, height: 100)
        rememberView.anchor(top: textFieldStackView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                            paddingTop: 20, paddingLeft: 10, paddingRight: 10, height: 30)
    }

}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    
}
