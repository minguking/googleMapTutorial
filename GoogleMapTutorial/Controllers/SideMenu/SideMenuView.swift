//
//  SideMenuView.swift
//  GoogleMapTutorial
//
//  Created by Kang Mingu on 2021/02/08.
//

import UIKit

private let sideMenuCellID = "SideMenuCellID"

protocol SideMenuViewDelegate: class {
    func didSwipe(view: UIView, recognizer: UIPanGestureRecognizer)
    func moveView(view: UIViewController)
}

class SideMenuView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: SideMenuViewDelegate?
    
    var sections: [SideMenuSection] = []
    
    lazy var recognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(sender:)))
    
    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let topView: UIView = {
        let view = UIView()
        view.backgroundColor = KAMainColor
        return view
    }()
    
    private let topLabel: UILabel = {
        let label = UILabel()
        label.text = "로그인을 해주세요."
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    private let loginOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.tag = 0
        button.setTitle("로그인", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        button.tintColor = .white
        button.setDimensions(width: 80, height: 30)
        button.layer.cornerRadius = 30 / 2
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(loginOutButtonDidTap(sender:)), for: .touchUpInside)
        return button
    }()
    
    private let joinModifyInfoButton: UIButton = {
        let button = UIButton(type: .system)
        button.tag = 0
        button.setTitle("회원가입", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        button.tintColor = .white
        button.setDimensions(width: 80, height: 30)
        button.layer.cornerRadius = 30 / 2
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(joinModifyInfoButtonDidTap(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var mobileTicketView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(mobileTicketViewDidTap))
        view.addGestureRecognizer(recognizer)
        return view
    }()
    
    private let mobileTicketImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "ic_sidemenu_ticket")
        iv.setDimensions(width: 30, height: 30)
        return iv
    }()
    
    private let mobileTicketLabel: UILabel = {
        let label = UILabel()
        label.text = "모바일주차권"
        label.textAlignment = .center
        label.textColor = .black // need to be changed,,,
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    lazy var parkingPassView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(parkingPassViewDidTap))
        view.addGestureRecognizer(recognizer)
        return view
    }()
    
    private let parkingPassImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "ic_sidemenu_pass")
        iv.setDimensions(width: 30, height: 30)
        return iv
    }()
    
    private let parkingPassLabel: UILabel = {
        let label = UILabel()
        label.text = "파킹패스"
        label.textAlignment = .center
        label.textColor = .black // need to be changed,,,
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let tableView = UITableView()
    
    let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let bottomImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "ic_goyang_gray")
        iv.tintColor = .lightGray
        iv.sizeToFit()
        return iv
    }()
    
    let callButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "ic_call_gray"), for: .normal)
        button.tintColor = .lightGray
        let attributedString = NSMutableAttributedString(string: "1522-2960",
                                                         attributes: [.font: UIFont.systemFont(ofSize: 13, weight: .bold),
                                                                      .foregroundColor: UIColor.lightGray,
                                                                      .underlineStyle: NSUnderlineStyle.single.rawValue,
                                                                      .underlineColor: UIColor.lightGray])
        attributedString.append(NSAttributedString(string: "(24시간 운영)",
                                                   attributes: [.font: UIFont.systemFont(ofSize: 13, weight: .regular),
                                                                .foregroundColor: UIColor.lightGray]))
        button.setAttributedTitle(attributedString, for: .normal)
        button.addTarget(self, action: #selector(callButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    let copyrightLabel: UILabel = {
        let label = UILabel()
        label.text = "© Goyang Urban Management Cop All Right Reserved"
        label.textColor = .lightGray
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Selectors
    
    @objc func handlePanGesture(sender: UIPanGestureRecognizer) {
        delegate?.didSwipe(view: self, recognizer: recognizer)
    }
    
    @objc func loginOutButtonDidTap(sender: UIButton) {
        print("DEBUG: handle log in or out... tag: \(sender.tag)")
        
    }
    
    @objc func joinModifyInfoButtonDidTap(sender: UIButton) {
        print("DEBUG: handle join or modify info...tag: \(sender.tag)")
    }
    
    @objc func mobileTicketViewDidTap() {
        print("DEBUG: mobile ticket view tapped...")
        
        // if userLogin...
        // else
    }
    
    @objc func parkingPassViewDidTap() {
        print("DEBUG: parking pass view tapped...")
        
        // parkingPassVC로 푸쉬 이동,,,
        // let parkingPassVC = ParkingPassViewController()
        // navigationController.pushViewController(parkingPassVC, animate: true)
    }
    
    @objc func callButtonDidTap() {
        print("DEBUG: call button tapped...")
    }
    
    
    // MARK: - Helpers
    
    func configureUI() {
        
        backgroundColor = .white
        
        gestureRecognizers = [recognizer]
        
        initSideMenuSections()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SideMenuCell.self, forCellReuseIdentifier: sideMenuCellID)
        tableView.bounces = false
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        
        // mainView
        
        addSubview(mainView)
        mainView.addSubview(topView)
        mainView.addSubview(mobileTicketView)
        mainView.addSubview(parkingPassView)
        mainView.addSubview(tableView)
        mainView.addSubview(bottomView)
        
        let buttonStack = UIStackView(arrangedSubviews: [loginOutButton, joinModifyInfoButton])
        buttonStack.axis = .horizontal
        buttonStack.spacing = 10
        
        topView.addSubview(topLabel)
        topView.addSubview(buttonStack)
        
        // movileTicketView / parkingPassView
        
        mobileTicketView.addSubview(mobileTicketImageView)
        mobileTicketView.addSubview(mobileTicketLabel)
        parkingPassView.addSubview(parkingPassImageView)
        parkingPassView.addSubview(parkingPassLabel)
        
        // bottomView
        
        bottomView.addSubview(bottomImageView)
        bottomView.addSubview(callButton)
        bottomView.addSubview(copyrightLabel)
        
        // layout
        
        let sideViewWidth = UIScreen.main.bounds.size.width - 100
        
        mainView.addConstraintsToFillView(self)
        topView.anchor(top: mainView.topAnchor, left: mainView.leftAnchor, right: mainView.rightAnchor, height: 110)
        mobileTicketView.anchor(top: topView.bottomAnchor, left: mainView.leftAnchor, width: sideViewWidth / 2, height: sideViewWidth / 3)
        parkingPassView.anchor(top: topView.bottomAnchor, left: mobileTicketView.rightAnchor, width: sideViewWidth / 2, height: sideViewWidth / 3)
        tableView.anchor(top: mobileTicketView.bottomAnchor, left: mainView.leftAnchor, bottom: mainView.bottomAnchor, right: mainView.rightAnchor,
                         paddingBottom: 100)
        bottomView.anchor(left: mainView.leftAnchor, bottom: mainView.bottomAnchor, right: mainView.rightAnchor, height: 100)
        
        topLabel.centerX(inView: topView, topAnchor: topView.topAnchor, paddingTop: 15)
        topLabel.anchor(height: 40)
        buttonStack.centerX(inView: topView, topAnchor: topLabel.bottomAnchor, paddingTop: 5)
        
        mobileTicketImageView.centerX(inView: mobileTicketView, topAnchor: mobileTicketView.topAnchor, paddingTop: 20)
        mobileTicketLabel.centerX(inView: mobileTicketView, topAnchor: mobileTicketImageView.bottomAnchor, paddingTop: 5)
        parkingPassImageView.centerX(inView: parkingPassView, topAnchor: parkingPassView.topAnchor, paddingTop: 20)
        parkingPassLabel.centerX(inView: parkingPassView, topAnchor: parkingPassImageView.bottomAnchor, paddingTop: 5)
        
        bottomImageView.centerX(inView: bottomView, topAnchor: bottomView.topAnchor, paddingTop: 15)
        bottomImageView.anchor(height: 20)
        callButton.centerX(inView: bottomView, topAnchor: bottomImageView.bottomAnchor, paddingTop: 5)
        copyrightLabel.centerX(inView: bottomView, topAnchor: callButton.bottomAnchor, paddingTop: 10)
        
    }
    
    func initSideMenuSections() {
        for i in 0 ..< SideMenuSectionType.count {
            let types = SideMenuSectionType(rawValue: i)!
            self.sections.append(SideMenuSection(title: types.title,
                                                 menus: types.menuNames,
                                                 viewControllers: types.viewControllers,
                                                 isCheckLogin: types.isCheckLogins,
                                                 isExpand: types.isExpand))
        }
        
        print("DEBUG: count :: \(SideMenuSectionType.count)")
    }
    
}


extension SideMenuView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sections[section].isExpand {
            return sections[section].menus.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: sideMenuCellID, for: indexPath) as! SideMenuCell
        
        cell.backgroundColor = .white
        cell.textLabel?.text = sections[indexPath.section].menus[indexPath.row] // indexPath.section,,,
        cell.textLabel?.font = .systemFont(ofSize: 14.0, weight: .regular)
        
        return cell
    }
    
}

extension SideMenuView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let popupView = sections[indexPath.section].viewControllers[indexPath.row] as! UIViewController
        delegate?.moveView(view: popupView)
        
        print("DEBUG: login needed? : \(sections[indexPath.section].isCheckLogin[indexPath.row])")
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandableHeaderView()
        
        var image = UIImage(named: "ic_action_down")
        
        header.arrowImageView.image = image
        if sections[section].isExpand {
            image = UIImage(named: "ic_action_up")
            
        }
        header.config(title: sections[section].title, section: section, image: image!, delegate: self)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        
        footer.backgroundColor = .lightGray
        
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if sections.count - 1 == section {
            return 0
        } else {
            return 0.7
        }
    }
    
}

extension SideMenuView: ExpandableHeaderViewDelegate {
    
    func toggleSection(header: UITableViewHeaderFooterView, section: Int) {
        
        for i in 0 ..< sections.count {
            if i == section {
                sections[i].isExpand = !sections[i].isExpand
            } else {
                sections[i].isExpand = false
            }
        }
        tableView.reloadData()
    }
    
}
