//
//  GameLogic.swift
//  Ghost Sort
//
//  Created by Joshua Alvarado on 2/8/15.
//  Copyright (c) 2015 Joshua Alvarado. All rights reserved.
//

import Foundation
import UIKit
class GameLogic
{
    var score: Int {
        didSet{
            updateGameSpeed()
        }
    }
    var speed: CGFloat
    var speedRange: Double
    init(){
        score = 0
        speed = 1.0
        speedRange = DEFAULT_GAMESPEED + GAME_SPEED_BUFFERRANGE
    }
    
    func match()
    {
        score++
    }
    
    func misMatch()
    {
        score--
    }
    
    private func updateGameSpeed()
    {
        if score % 15 == 0
        {
            speed = speed + 0.2
        }
    }
    
}
