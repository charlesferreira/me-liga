//
//  Constants.swift
//  NanoChallenge6 WatchKit Extension
//
//  Created by Charles Ferreira on 09/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import Foundation

struct Constants {
    
    struct LastCall {
//        static let `default` = Date.threeDaysAgo
//        static let bestCase = Date.oneHourAgo
//        static let worstCase = Date.sevenDaysAgo
        static var `default`: Date { return Date.tenMinutesAgo }
        static var bestCase: Date { return Date.now }
        static var worstCase: Date { return Date.tenMinutesAgo }
    }
}
