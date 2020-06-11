//
//  ThirdViewController.swift
//  FourthHWApp
//
//  Created by Yura Menschikov on 11/13/18.
//  Copyright © 2018 Yura Menschikov. All rights reserved.
//

import UIKit
import AVFoundation

class ThirdViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, AVAudioPlayerDelegate {
    
    let timerPicker = UIPickerView()
    
    var timer : Timer?
    
    let timerButton = UIButton()
    
    var player = AVAudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainFunc()
        
        playerFunc()
        
    }
    
    func mainFunc(){
        self.view.backgroundColor = UIColor.white
        timerPicker.delegate = self
        timerPicker.frame = CGRect(x: 0, y: 0, width: 150, height: 100)
        timerPicker.center = self.view.center
        timerButton.frame = CGRect(x: 138, y: 200, width: 100, height: 50)
        timerButton.setTitle("Start", for: .normal)
        timerButton.backgroundColor = UIColor.darkGray
        
        timerButton.setTitleColor(.white, for: .normal)
        timerButton.setTitleColor(.lightGray, for: .highlighted)
        
        timerButton.addTarget(self, action: #selector(buttonIsPressed(sender:)), for: .touchUpInside)
        
        self.view.addSubview(timerPicker)
        self.view.addSubview(timerButton)
    }
    
    func playerFunc(){
        do {
            if let path = Bundle.main.path(forResource: "service-bell_daniel_simion", ofType: "wav") {
                try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            }
        } catch {
            print("ERROR")
        }
    }
    
    @objc func changeValueAtPickerView(){
        // получаем текущее значение таймера
        let valueOfTimer = self.timerPicker.selectedRow(inComponent: 0)
        // проверка на окончание работы таймера
        if valueOfTimer == 0 {
            self.timer?.invalidate()
            let alert = UIAlertController(title: nil, message: "Time is over", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok", style: .default){ (action) in
            }
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
            player.play()
        } else {
            // устанавливаем новое значение
            self.timerPicker.selectRow(valueOfTimer-1, inComponent: 0, animated: true)
        }
    }
    
    @objc func buttonIsPressed(sender: UIButton){
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(changeValueAtPickerView), userInfo: nil, repeats: true)
    }
    
    
    @objc func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @objc func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 61
    }
    
    @objc func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row)
    }
    
    //MARK: - hide keyboard when press anywhere, instead keyboard
    @objc override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
