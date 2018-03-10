//
//  ContactTableRowController.swift
//  NanoChallenge6 WatchKit Extension
//
//  Created by Charles Ferreira on 09/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import WatchKit

class ContactTableRowController: NSObject {
    
    @IBOutlet var contactImage: WKInterfaceImage!
    @IBOutlet var contactName: WKInterfaceLabel!
    
    var contact: AppContact? {
        didSet {
            updateLayout()
        }
    }
    
    private func updateLayout() {
        contactName.setText(contact?.givenName ?? "atatata")
    }
}
