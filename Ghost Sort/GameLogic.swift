//
//  GameLogic.swift
//  Ghost Sort
//
//  Created by Joshua Alvarado on 2/8/15.
//  Copyright (c) 2015 Joshua Alvarado. All rights reserved.
//

import Foundation

class GameLogic
{
    var score: Int
    var speed: Double
    var speedRange: Double
    init(){
        score = 0
        speed = 2.0
        speedRange = 2.5
    }
    
    func checkForMatch(item: String, item2: String)
    {
        if item == item2
        {
            match()
        }
        else
        {
            misMatch()
        }
    }
    
    private func match()
    {
        score++
    }
    
    private func misMatch()
    {
        score--
    }
    
    private func updateGameSpeed()
    {
        switch score
        {
        case 0...10: speed = DEFAULT_GAMESPEED - SPEED_DECREASE_AMOUNT; speedRange = speed + GAME_SPEED_BUFFERRANGE
        default: speed = DEFAULT_GAMESPEED; speedRange = speed + GAME_SPEED_BUFFERRANGE
        }
    }
    
}
