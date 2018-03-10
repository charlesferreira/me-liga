//
//  InterfaceController.swift
//  NanoChallenge6 WatchKit Extension
//
//  Created by Charles Ferreira on 06/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController {
    
    @IBOutlet weak var contactsTable: WKInterfaceTable!
    
    override func willActivate() {
        super.willActivate()
        DataModel.shared.delegate = self
        loadTableData()
    }
    
    private func loadTableData() {
        let contacts = DataModel.shared.contacts
        contactsTable.setNumberOfRows(contacts.count, withRowType: "ContactTableRowController")
        
        for (index, contact) in contacts.enumerated() {
            if let row = contactsTable.rowController(at: index) as? ContactTableRowController {
                row.contact = contact
            }
        }
    }
}

extension InterfaceController: DataModelDelegate {
    
    func dataModel(_ dataModel: DataModel, didUpdateContacts contacts: [AppContact]) {
        loadTableData()
    }
}
