//
//  SecondViewController.swift
//  FourthHWApp
//
//  Created by Yura Menschikov on 11/13/18.
//  Copyright © 2018 Yura Menschikov. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate{
    
    let backgroundImage = UIImageView(image: #imageLiteral(resourceName: "anket3.jpg"))
    
    let genderPicker = UIPickerView()
    let agePicker = UIDatePicker()
    
    let nameLabel = UILabel()
    let surnameLabel = UILabel()
    let settingsLabel = UILabel()
    
    let nameTextField = UITextField()
    let surnameTextField = UITextField()
    
    let saveButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.backgroundImage.frame = self.view.frame
        
        genderPicker.dataSource = self
        genderPicker.delegate = self
        nameTextField.delegate = self
        surnameTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIWindow.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIWindow.keyboardWillChangeFrameNotification, object: nil)
        
        createPickerTextFieldLabel()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIWindow.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIWindow.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func createPickerTextFieldLabel(){
        genderPicker.frame = CGRect(x: 112, y: 158, width: 150, height: 80)
        agePicker.frame = CGRect(x: 112, y: 200, width: 150, height: 100)
        
        self.nameLabel.frame = CGRect(x: 28, y: 413, width: 100, height: 50)
        nameLabel.backgroundColor = UIColor.black
        nameLabel.text = "Name:"
        nameLabel.textAlignment = .center
        nameLabel.textColor = UIColor.white
        
        self.surnameLabel.frame = CGRect(x: 28.0, y: 502.5, width: 100.0, height: 50.0)
        surnameLabel.backgroundColor = UIColor.black
        surnameLabel.text = "Surname:"
        surnameLabel.textAlignment = .center
        surnameLabel.textColor = UIColor.white
        
        self.nameTextField.frame = CGRect(x: 148, y: 422, width: 190, height: 31)
        nameTextField.placeholder = "Enter your name"
        nameTextField.textAlignment = .left
        nameTextField.clearButtonMode = .whileEditing
        
        self.surnameTextField.frame = CGRect(x: 148.0, y: 512.5, width: 190.0, height: 31.0)
        surnameTextField.placeholder = "Enter your surname"
        surnameTextField.textAlignment = .left
        surnameTextField.clearButtonMode = .whileEditing
        
        self.agePicker.frame = CGRect(x: 48, y: 280, width: 280, height: 100)
        agePicker.datePickerMode = .date
        
        // settingslabel and alertview
        self.saveButton.frame = CGRect(x: 138, y: 560, width: 100, height: 50)
        saveButton.backgroundColor = UIColor.red
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor( .white, for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonIsPressed(sender:)), for: .touchUpInside)
        
        self.settingsLabel.frame = CGRect(x: 86, y: 80, width: 200, height: 50)
        settingsLabel.backgroundColor = UIColor.darkGray
        settingsLabel.text = "Personal Data"
        settingsLabel.textColor = UIColor.white
        settingsLabel.textAlignment = .center
        
        self.view.addSubview(backgroundImage)
        self.view.addSubview(genderPicker)
        self.view.addSubview(nameLabel)
        self.view.addSubview(surnameLabel)
        self.view.addSubview(nameTextField)
        self.view.addSubview(surnameTextField)
        self.view.addSubview(agePicker)
        self.view.addSubview(saveButton)
        self.view.addSubview(settingsLabel)
    }
    
    // for func keyboardwillshow/hide/changeframe
    @objc func keyboardWillChange(notification: Notification) {
        //print("keyboard will show: \(notification.name)")
        view.frame.origin.y = -200
    }
    
    // how much components will show in picker
    @objc func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // how much components at all
    @objc func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    // which components are in picker
    @objc func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let gender = ["Not selected", "Man", "Woman"]
        return gender[row]
    }
    
    //MARK: - hide keyboard when press anywhere, instead keyboard
    @objc override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        view.frame.origin.y = 0
    }
    
    @objc func saveButtonIsPressed(sender: UIButton) {
        
    }
    
   /*
     @objc func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            
        }
    }
 */
}
