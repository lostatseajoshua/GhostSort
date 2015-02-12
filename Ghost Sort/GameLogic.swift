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
    init(){
        score = 0
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
    
    func match()
    {
        score++
    }
    func misMatch()
    {
        score--
    }
    
}
