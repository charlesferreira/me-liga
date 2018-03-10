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
        setTitle("Contatos")
        DataModel.shared.delegate = self
        loadTableData()
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        let contact = DataModel.shared.contacts[rowIndex]
        if let number = contact.phoneNumber {
            makeAPhoneCall(to: number)
            notifyIPhoneApp(contactIndex: rowIndex)
        }
    }
    
    private func makeAPhoneCall(to number: String) {
        if let url = URL(string: "tel://\(number)") {
            print("Ligando para:", number)
            WKExtension.shared().openSystemURL(url)
        }
    }
    
    private func loadTableData() {
        let contacts = DataModel.shared.contacts
        contactsTable.setNumberOfRows(contacts.count, withRowType: "ContactTableRowController")
        
        for (index, contact) in contacts.enumerated() {
            if let row = contactsTable.rowController(at: index) as? ContactTableRowController {
                row.contact = contact
            }
        }
        
        CLKComplicationServer.sharedInstance().reloadAllComplications()
    }
    
    private func notifyIPhoneApp(contactIndex: Int) {
        let message = [Message.Keys.watchAppDidCallContact: contactIndex]
        WCSession.default.sendMessage(message, replyHandler: nil, errorHandler: nil)
    }
}

extension InterfaceController: DataModelDelegate {
    
    func dataModel(_ dataModel: DataModel, didUpdateContacts contacts: [AppContact]) {
        loadTableData()
    }
}
