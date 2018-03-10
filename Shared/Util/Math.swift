//
//  Math.swift
//  NanoChallenge6
//
//  Created by Charles Ferreira on 10/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import Foundation

func clamp<T: Comparable>(_ value: T, minValue: T, maxValue: T) -> T {
    return max(minValue, min(maxValue, value))
}

func clamp01<T: Numeric & Comparable>(_ value: T) -> T {
    return max(0, min(1, value))
}
