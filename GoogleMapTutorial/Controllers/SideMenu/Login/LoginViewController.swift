//
//  LoginViewController.swift
//  GoogleMapTutorial
//
//  Created by Kang Mingu on 2021/02/22.
//

import UIKit

import Alamofire

class LoginViewController: BaseViewController {
    
    // MARK: - Properties
    
    // Test
    let urlString = "https://dgparking.or.kr/userapprest/appMemberLogin"
    
    let header: HTTPHeaders = [
        "opercd": "18",
        "separatorDevice": "IOS",
        "reqip": "192.168.150.131",
        "appVersion": "1.0.5",
        "deviceName": "Simulator",
        "deviceOsVersion": "14.3",
        "Content-Type": "application/json; charset=UTF-8"
    ]
    //
    
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
        button.setTitleColor(.black, for: .normal)
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
        button.setTitleColor(.black, for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
        button.addTarget(self, action: #selector(autoLoginButtonDidTap(sender:)), for: .touchUpInside)
        return button
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
        button.backgroundColor = KAMainColor
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        autoStatus()
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
    
    
    // MARK: - API
    
    /// 로그인 요청
    func login(userID: String, userPW: String) {
        let parameters: Parameters = ["userId": userID, "userPw": userPW]
        
        AF.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header)
            .validate(statusCode: 200 ..< 500)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    guard let json = value as? [String: Any] else { break }
                    print("DEBUG: json \(json)")
                    
                case .failure(let error):
                    print("DEBUG: failed with error = \(error.localizedDescription)")
                }
            }
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
    
    // Test
    @objc func loginButtonDidTap() {
        if !idTextField.hasText || !pwTextField.hasText {
            let alert = UIAlertController(title: "", message: "아이디/패스워드를 입력해 주세요.", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        } else {
            UserDefaults.standard.set(idCheckButton.isSelected, forKey: LoginUserDefault.isSaveID.rawValue)
            UserDefaults.standard.set(autoLoginButton.isSelected, forKey: LoginUserDefault.isAutoLogin.rawValue)
            
            if idCheckButton.isSelected {
                UserDefaults.standard.set(idTextField.text, forKey: LoginUserDefault.userID.rawValue)
            }
            if autoLoginButton.isSelected {
                UserDefaults.standard.set(idTextField.text, forKey: LoginUserDefault.userID.rawValue)
                UserDefaults.standard.set(pwTextField.text, forKey: LoginUserDefault.userPW.rawValue)
            }
        }
        login(userID: idTextField.text!, userPW: pwTextField.text!)
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
        view.addSubview(loginButton)
        
        dismissButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, right: view.rightAnchor, paddingTop: 10, paddingRight: 10)
        logoImageView.centerX(inView: view, topAnchor: dismissButton.bottomAnchor, paddingTop: 10)
        textFieldStackView.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                                  paddingTop: 30, paddingLeft: 20, paddingRight: 20, height: 100)
        rememberView.anchor(top: textFieldStackView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                            paddingTop: 20, paddingLeft: 10, paddingRight: 10, height: 30)
        loginButton.anchor(top: rememberView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                           paddingTop: 20, paddingLeft: 20, paddingRight: 20, height: 50)
    }
    
    func autoStatus() {
        let isSaveID = UserDefaults.standard.bool(forKey: LoginUserDefault.isSaveID.rawValue)
        let isAutoLogin = UserDefaults.standard.bool(forKey: LoginUserDefault.isAutoLogin.rawValue)
        
        if isSaveID {
            idTextField.text = UserDefaults.standard.string(forKey: LoginUserDefault.userID.rawValue)
            idCheckButton.isSelected = isSaveID
        }
        if isAutoLogin {
            pwTextField.text = UserDefaults.standard.string(forKey: LoginUserDefault.userPW.rawValue)
            autoLoginButton.isSelected = isAutoLogin
        }
    }
    
    func getWiFiAddress() -> String {
        var address : String?
        
        // Get list of all interfaces on the local machine:
        var ifaddr : UnsafeMutablePointer<ifaddrs>?
        //        guard getifaddrs(&ifaddr) == 0 else { return nil }
        //        guard let firstAddr = ifaddr else { return nil }
        guard getifaddrs(&ifaddr) == 0 else { return "0.0.0.0" }
        guard let firstAddr = ifaddr else { return "0.0.0.0" }
        
        // For each interface ...
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ifptr.pointee
            
            // Check for IPv4 or IPv6 interface:
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                
                // Check interface name:
                let name = String(cString: interface.ifa_name)
                if  name == "en0" {
                    
                    // Convert interface address to a human readable string:
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                &hostname, socklen_t(hostname.count),
                                nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostname)
                }
            }
        }
        freeifaddrs(ifaddr)
        return address ?? "0.0.0.0"
    }
    
    func getAppVersion() -> String {
        let info: [String: Any] = Bundle.main.infoDictionary!
        let currentVersion = info["CFBundleShortVersionString"] as! String
        return currentVersion
    }
    
}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    
}



// Test
extension UIDevice {
    
    class var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "i386", "x86_64":                          return "Simulator"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro"
        case "AppleTV5,3":                              return "Apple TV"
        default:                                        return identifier
        }
    }
}
//
