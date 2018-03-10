//
//  ContactsViewController.swift
//  NanoChallenge6
//
//  Created by Charles Ferreira on 06/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import UIKit
import WatchConnectivity

class ContactsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var contacts: [AppContact] {
        return DataModel.shared.contacts
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        DataModel.shared.delegate = self
    }
    
    private func makeAPhoneCall(to number: String) {
        if let url = URL(string: "tel://\(number)") {
            UIApplication.shared.open(url)
        }
    }
    
    private func notifyWatchApp() {
        guard let data = DataModel.shared.encode() else { return }
        let message = [Message.Keys.iPhoneDidUpdateContacts: data]
        WCSession.default.sendMessage(message, replyHandler: nil, errorHandler: nil)
    }
}

extension ContactsViewController: DataModelDelegate {
    
    func dataModel(_ dataModel: DataModel, didUpdateContacts contacts: [AppContact]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        notifyWatchApp()
    }
}

extension ContactsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "ContactTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID)
            ?? UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: cellID)
        
        let contact = contacts[indexPath.row]
        cell.textLabel?.text = contact.fullName
        cell.detailTextLabel?.text = contact.lastCall.diffForHumans()
        cell.imageView?.image = image(for: contact.happiness)
        
        return cell
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

extension ContactsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Apagar") { (_, _, _) in
            DataModel.shared.remove(at: indexPath.row)
        }
        delete.image = #imageLiteral(resourceName: "delete")
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let call = UIContextualAction(style: UIContextualAction.Style.normal, title: nil) { (_, _, _) in
            let contact = DataModel.shared.touch(at: indexPath.row)
            if let number = contact.phoneNumber {
                self.makeAPhoneCall(to: number)
            }
        }
        call.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        call.image = #imageLiteral(resourceName: "call")
        
        
        return UISwipeActionsConfiguration(actions: [call])
    }
}
