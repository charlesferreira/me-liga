//
//  CLKComplicationServer.swift
//  NanoChallenge6 WatchKit Extension
//
//  Created by Charles Ferreira on 10/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import WatchKit

extension CLKComplicationServer {
    
    func reloadAllComplications() {
        activeComplications?.forEach { reloadTimeline(for: $0) }
    }
}
