//
//  SearchVC.swift
//  Git Follow
//
//  Created by iOS Dev on 11/12/25.
//

import UIKit

class SearchVC: UIViewController {
    let logoImageView = UIImageView()
    let userNameTextField = GFTextFeald()
    let getFollowerBtn = GFButton(
        backgroundColor: .systemGreen,
        title: "Get Followers"
    )
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTextField()
        configureButton()
        createDismissKeyboardTapGesture()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func createDismissKeyboardTapGesture(){
        let tapGesture = UITapGestureRecognizer(
            target: self.view,
            action: #selector(UIView.endEditing)
        )
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func pushToFollowerListVC(){
        if userNameTextField.text != nil , userNameTextField.text?.isEmpty == false {
            let followerListVC = FollowerListVC()
            followerListVC.userName = userNameTextField.text
            followerListVC.title = userNameTextField.text
            navigationController?.pushViewController(followerListVC, animated: true)
        }else{
            self.presentGFAlertOnMainThread(title: "Missing User Name", message: "You have not entered the user name 😊", buttonTitle: "Ok")
        }
    }
    
    
    /**
     * All the UI functions
     */
     
    func configureLogoImageView(){
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")!
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTextField(){
        view.addSubview(userNameTextField)
        userNameTextField.delegate = self
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor
                .constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            userNameTextField.leadingAnchor
                .constraint(equalTo: view.leadingAnchor, constant: 50), //this two makes it like match parent in android xml code
            userNameTextField.trailingAnchor
                .constraint(equalTo: view.trailingAnchor, constant: -50),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    func configureButton(){
        view.addSubview(getFollowerBtn)
        getFollowerBtn
            .addTarget(
                self,
                action: #selector(pushToFollowerListVC),
                for: .touchUpInside
            )
        NSLayoutConstraint.activate([
            getFollowerBtn.topAnchor
                .constraint(equalTo: userNameTextField.bottomAnchor, constant: 30),
            getFollowerBtn.leadingAnchor
                .constraint(equalTo: view.leadingAnchor, constant: 50),
            getFollowerBtn.trailingAnchor
                .constraint(equalTo: view.trailingAnchor, constant: -50),
            getFollowerBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}


extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushToFollowerListVC()
        return true
    }
}
