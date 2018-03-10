//
//  Happiness.swift
//  NanoChallenge6
//
//  Created by Charles Ferreira on 10/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import UIKit

struct Happiness {
    
    static func calculate(lastCall: Date) -> Double {
        let worstCase = Constants.LastCall.worstCase.timeIntervalSinceNow
        let bestCase = Constants.LastCall.bestCase.timeIntervalSinceNow
        let interval = bestCase - worstCase
        let lastCallTime = lastCall.timeIntervalSinceNow
        let happiness = 1.0 - clamp01(abs(lastCallTime / interval))
        return happiness
    }
    
    static func tintColor(for happiness: Float) -> UIColor {
        let r = happiness < 0.5 ? 1 : CGFloat(2 - happiness * 2)
        let g = happiness > 0.5 ? 1 : CGFloat(happiness * 2)
        
        return UIColor(red: r, green: g, blue: 0, alpha: 1)
    }
    
    private init() {}
}
