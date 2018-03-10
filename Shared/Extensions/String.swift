//
//  String.swift
//  NanoChallenge6 WatchKit Extension
//
//  Created by Charles Ferreira on 10/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import Foundation

extension String {
    
    var digits: String {
        let filtredUnicodeScalars = unicodeScalars.filter { CharacterSet.decimalDigits.contains($0) }
        return String(String.UnicodeScalarView(filtredUnicodeScalars))
    }
}
