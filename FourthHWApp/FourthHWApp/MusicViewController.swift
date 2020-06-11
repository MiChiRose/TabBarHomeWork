//
//  MusicViewController.swift
//  FourthHWApp
//
//  Created by Yura Menschikov on 11/13/18.
//  Copyright © 2018 Yura Menschikov. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class MusicViewController: UIViewController, AVAudioPlayerDelegate {
    
    var player = AVAudioPlayer()
    
    let array = [1,2,3]

    let backgroundImage = UIImageView(image: #imageLiteral(resourceName: "orangew.jpg"))
    
    let lowVolumeImage = UIImageView(image: #imageLiteral(resourceName: "speaker.png"))
    let highVolumeImage = UIImageView(image: #imageLiteral(resourceName: "speaker-2.png"))
    let playButtonImage = UIImageView(image: #imageLiteral(resourceName: "play-button.png"))
    let pauseButtonImage = UIImageView(image: #imageLiteral(resourceName: "pause-3.png"))
    let previousButtonImage = UIImageView(image: #imageLiteral(resourceName: "previous-track-button.png"))
    let nextButtonImage = UIImageView(image: #imageLiteral(resourceName: "next-track-button.png"))
    
    let randomCover = UIImageView(image: #imageLiteral(resourceName: "555434-1FzqjL1503944654.png"))
    let idCover = UIImageView(image: #imageLiteral(resourceName: "imgrdns.jpg"))
    
    let playButton = UIButton()
    let previousButton = UIButton()
    let nextButton = UIButton()
    
    let trackNameLabel = UILabel()
    let timeStartLabel = UILabel()
    let timeEndLabel = UILabel()
    
    let volumeSlider = UISlider()
    let lengthTrackSlider = UISlider()
    
    var time1 = Timer()
    let time2 = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerFunc()
        
        mainFunc()
        
    }
    
    func playerFunc(){
        do {
            if let path = Bundle.main.path(forResource: "imagine-dragons_-_radioactive", ofType: "mp3") {
                try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                self.volumeSlider.maximumValue = Float(player.duration)
            }
        } catch {
            print("ERROR")
        }
    }
    
    func mainFunc(){
        self.backgroundImage.frame = self.view.frame
        
        self.volumeSlider.frame = CGRect(x: 65, y: 565, width: 240, height: 20)
        volumeSlider.tintColor = UIColor.orange
        volumeSlider.maximumValue = 100.0
        volumeSlider.minimumValue = 0.0
        
        self.lowVolumeImage.frame = CGRect(x: 20, y: 560, width: 32, height: 32)
        self.highVolumeImage.frame = CGRect(x: 320, y: 560, width: 32, height: 32)
        
        self.playButton.frame = CGRect(x: 160, y: 450, width: 64, height: 64)
        playButton.setImage(UIImage(named: "play-button.png"), for: .normal)
        playButton.addTarget(self, action: #selector(playPauseButton(_:)), for: .touchUpInside)
        self.nextButton.frame = CGRect(x: 280, y: 450, width: 64, height: 64)
        self.previousButton.frame = CGRect(x: 30, y: 450, width: 64, height: 64)
        
        self.randomCover.frame = CGRect(x: 60, y: 100, width: 256, height: 256)
        self.idCover.frame = CGRect(x: 60, y: 100, width: 256, height: 256)
        
        volumeSlider.addTarget(self, action: #selector(volumeChange(sender:)), for: .valueChanged)
        
        
        time1 = Timer.scheduledTimer(timeInterval: 0.1 , target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        self.lengthTrackSlider.frame = CGRect(x: 65, y: 400, width: 240, height: 20)
        lengthTrackSlider.minimumValue = 0.0
        lengthTrackSlider.maximumValue = Float(player.duration)
        lengthTrackSlider.tintColor = UIColor.yellow
        lengthTrackSlider.addTarget(self, action: #selector(lengthChange(sender:)), for: .valueChanged)
        
        
        self.view.addSubview(backgroundImage)
        self.view.addSubview(volumeSlider)
        self.view.addSubview(lengthTrackSlider)
        self.view.addSubview(lowVolumeImage)
        self.view.addSubview(highVolumeImage)
        
        self.view.addSubview(randomCover)
        
        self.view.addSubview(playButton)
        self.view.addSubview(previousButton)
        self.view.addSubview(nextButton)
    }
    
    @objc func playPauseButton(_ sender: UIButton) {
        if !player.isPlaying {
            playButton.setImage(UIImage(named: "pause-3.png"), for: .normal)
            self.view.addSubview(idCover)
            self.player.play()
        } else {
            playButton.setImage(UIImage(named: "play-button.png"), for: .normal)
            self.player.pause()
        }
    }
    
    @objc func lengthChange(sender: UISlider){
        if sender == lengthTrackSlider {
            player.currentTime = TimeInterval(lengthTrackSlider.value)
        }
    }
    
    @objc func volumeChange(sender: UISlider){
        self.player.volume = self.volumeSlider.value
    }
    
    @objc func updateTimer(){
        lengthTrackSlider.value = Float(player.currentTime)
    }
    
    /*
    @objc func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        lengthTrackSlider.value = 0.0
        playButton.setImage(UIImage(named: "play-button.png"), for: .normal)
        self.view.addSubview(randomCover)
        self.player.stop()
        
    }
 */
    
}
