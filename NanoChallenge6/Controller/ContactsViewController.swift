//
//  ContactsViewController.swift
//  NanoChallenge6
//
//  Created by Charles Ferreira on 06/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var contacts: [AppContact] {
        return DataModel.shared.contacts
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        DataModel.shared.delegate = self
    }
}

extension ContactsViewController: DataModelDelegate {
    
    func dataModel(_ dataModel: DataModel, didUpdateContacts contacts: [AppContact]) {
        tableView.reloadData()
    }
}

extension ContactsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "ContactTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID)
            ?? UITableViewCell(style: .default, reuseIdentifier: cellID)
        
        let contact = contacts[indexPath.row]
        cell.textLabel?.text = contact.fullName
        
        return cell
    }
}
