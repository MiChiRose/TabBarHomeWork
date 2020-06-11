//
//  ViewController.swift
//  FourthHWApp
//
//  Created by Yura Menschikov on 11/13/18.
//  Copyright © 2018 Yura Menschikov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    let background = UIImageView(image: #imageLiteral(resourceName: "pole.jpg"))
    let enterButton = UIButton()
    let loginTextField = UITextField()
    let passwordTextField = UITextField()
    let showPasswordSlider = UISwitch()
    let passLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationController?.navigationBar.isHidden = true
        
        self.title = "Personal data"
        
        self.background.frame = self.view.frame
        
        self.loginTextField.delegate = self
        self.passwordTextField.delegate = self
        
        createAndShowButtonsLabelsTextFields()
        
    }
    
    //MARK: - Create Buttons, switch, labels and textFields
    @objc func createAndShowButtonsLabelsTextFields(){
        self.enterButton.frame = CGRect(x: 138, y: 290, width: 100, height: 50)
        enterButton.backgroundColor = UIColor.lightGray
        enterButton.setTitle("Enter", for: .normal)
        enterButton.setTitleColor(.white, for: .normal)
        enterButton.setTitleColor(.lightGray, for: .highlighted)
        enterButton.addTarget(self, action: #selector(pressButton(sender:)), for: .touchUpInside)
        
        self.loginTextField.frame = CGRect(x: 38, y: 90, width: 300, height: 31)
        loginTextField.backgroundColor = UIColor.white
        loginTextField.placeholder = "Enter login"
        loginTextField.borderStyle = UITextField.BorderStyle.roundedRect
        loginTextField.keyboardType = .default
        loginTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        
        self.passwordTextField.frame = CGRect(x: 38, y: 150, width: 300, height: 31)
        passwordTextField.backgroundColor = UIColor.white
        passwordTextField.placeholder = "Enter password"
        passwordTextField.borderStyle = UITextField.BorderStyle.roundedRect
        passwordTextField.keyboardType = .emailAddress
        passwordTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        passwordTextField.isSecureTextEntry = true
        
        self.showPasswordSlider.frame = CGRect(x: 38, y: 210, width: 49, height: 31)
        showPasswordSlider.tintColor = UIColor.lightGray
        showPasswordSlider.onTintColor = UIColor.darkGray
        showPasswordSlider.thumbTintColor = UIColor.white
        self.showPasswordSlider.addTarget(self, action: #selector(showHidePassword(sender:)), for: .valueChanged)
        
        self.passLabel.frame = CGRect(x: 138, y: 210, width: 200, height: 31)
        passLabel.text = "Show/Hide password"
        passLabel.backgroundColor = UIColor.darkGray
        passLabel.textColor = UIColor.white
        passLabel.textAlignment = .center
        
        self.view.addSubview(background)
        self.view.addSubview(enterButton)
        self.view.addSubview(loginTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(showPasswordSlider)
        self.view.addSubview(passLabel)
    }
    
    //MARK: - go to 2nd VC when press button and create TabBarController
    @objc func pressButton(sender: UITextField) {
        
        let secondVC = SecondViewController()
        let thirdVC = ThirdViewController()
        let musicVC = MusicViewController()
        
        let secondController = UINavigationController(rootViewController: secondVC)
        let thirdController = UINavigationController(rootViewController: thirdVC)
        let musicController = UINavigationController(rootViewController: musicVC)
        
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([secondController, thirdController, musicController], animated: true)
        tabBarController.loadView()
        secondController.tabBarItem = UITabBarItem(title: "Settings", image: #imageLiteral(resourceName: "settings.png"), tag: 0)
        thirdController.tabBarItem = UITabBarItem(title: "Timer", image: #imageLiteral(resourceName: "alarm-clock.png"), tag: 1)
        musicController.tabBarItem = UITabBarItem(title: "Music", image: #imageLiteral(resourceName: "musical-note.png"), tag: 2)
        
        if (loginTextField.text?.isEmpty ?? true) || (passwordTextField.text?.isEmpty ?? true) {
            let alert = UIAlertController(title: "Error", message: "Your login or password incorrect", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Understood", style: .default){ (action) in
            }
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
        } else {
            self.navigationController?.pushViewController(tabBarController, animated: true)
        }
    }
    
    //MARK: - func show or hide password textField
    @objc func showHidePassword(sender: UISwitch) {
        if sender.isOn {
            passwordTextField.isSecureTextEntry = false
        } else {
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    //MARK: - hide keyboard when press "return"
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.loginTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        return true
    }
    
    //MARK: - hide keyboard when press anywhere, instead keyboard
    @objc override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

