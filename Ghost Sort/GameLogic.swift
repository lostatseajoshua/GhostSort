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
    var score: Int {
        didSet{
            updateGameSpeed()
        }
    }
    var speed: Double
    var speedRange: Double
    init(){
        score = 0
        speed = DEFAULT_GAMESPEED
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
        switch score
        {
        case 10: increaseGameSpeed()
        case 15: increaseGameSpeed()
        case 25: increaseGameSpeed()
        case 35: increaseGameSpeed()
        default: speed = DEFAULT_GAMESPEED; speedRange = speed + GAME_SPEED_BUFFERRANGE
        }
    }
    private func increaseGameSpeed()
    {
        speed = speed - SPEED_DECREASE_AMOUNT; speedRange = speed - GAME_SPEED_BUFFERRANGE
    }
    
}
