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
        contactName.setText(contact?.givenName ?? "")
        contactName.setTextColor(Happiness.tintColor(for: Float(contact?.happiness ?? 0)))
        if let happiness = contact?.happiness {
            contactImage.setImage(image(for: happiness))
        }
    }
    
    private func image(for happiness: Double) -> UIImage {
        switch happiness {
        case 0.0..<0.2: return #imageLiteral(resourceName: "status-sad")
        case 0.2..<0.5: return #imageLiteral(resourceName: "status-unhappy")
        case 0.5..<0.8: return #imageLiteral(resourceName: "status-happy")
        default: return #imageLiteral(resourceName: "status-excited")
        }
    }
}
