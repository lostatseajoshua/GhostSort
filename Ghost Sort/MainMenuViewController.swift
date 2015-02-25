//
//  MainMenuViewController.swift
//  Ghost Sort
//
//  Created by Joshua Alvarado on 2/8/15.
//  Copyright (c) 2015 Joshua Alvarado. All rights reserved.
//

import UIKit
import AVFoundation

class MainMenuViewController: UIViewController {
    
    @IBOutlet weak var instructionsButton: UIButton!
    @IBOutlet weak var beginGameButton: UIButton!
    @IBOutlet weak var soundPrefenceButton: UIButton!
    
    var audioPlayer: AVAudioPlayer!

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let isMusicEnabled = userDefaults.objectForKey("Music") as? Bool
        {
            if isMusicEnabled
            {
                soundPrefenceButton.setTitle("Sound On", forState: .Normal)
            } else {
                soundPrefenceButton.setTitle("Sound Off", forState: .Normal)
            }
        } else {
            soundPrefenceButton.setTitle("Sound On", forState: .Normal)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.instructionsButton.layer.cornerRadius = self.instructionsButton.bounds.size.width / 2
        self.beginGameButton.layer.cornerRadius = self.beginGameButton.bounds.size.width / 2
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        setupAVAudioPlayer()
        playMusic()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func presentInstructionsView(sender: UIButton)
    {
        let instructionsView = self.storyboard?.instantiateViewControllerWithIdentifier("InstructionsView") as UIViewController
        self.presentViewController(instructionsView, animated: true, completion: nil)
    }
    
    func setupAVAudioPlayer()
    {
        if audioPlayer == nil
        {
            let url = NSBundle.mainBundle().URLForResource("gameIntroMusic", withExtension: ".wav")
            if let songUrl = url {
                var error: NSError?
                audioPlayer = AVAudioPlayer(contentsOfURL: songUrl, error: &error)
                audioPlayer.prepareToPlay()
                audioPlayer.numberOfLoops = -1
            }
        }
    }
        
    func playMusic()
    {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let isMusicEnabled = userDefaults.objectForKey("Music") as? Bool
        {
            if isMusicEnabled
            {
                if audioPlayer.playing != true
                {
                    audioPlayer.play()
                }
            } else {
                audioPlayer.stop()
            }
        }else{
            userDefaults.setBool(true, forKey: "Music")
            userDefaults.synchronize()
            playMusic()
        }
    }
    
    func stopPlayingMusic()
    {
        if audioPlayer != nil
        {
            let playingBool = audioPlayer.playing
            if playingBool
            {
                audioPlayer.stop()
            }
        }
    }
    
    @IBAction func toggleSoundSetting(sender: UIButton)
    {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if audioPlayer != nil
        {
            if audioPlayer.playing == true
            {
                audioPlayer.stop()
                userDefaults.setBool(false, forKey: "Music")
                soundPrefenceButton.setTitle("Sound Off", forState: .Normal)
            } else {
                audioPlayer.play()
                userDefaults.setBool(true, forKey: "Music")
                soundPrefenceButton.setTitle("Sound On", forState: .Normal)
            }
            userDefaults.synchronize()
        }

    }

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "game"
        {
            stopPlayingMusic()
        }
    }

}
