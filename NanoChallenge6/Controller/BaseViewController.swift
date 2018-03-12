//
//  BaseViewController.swift
//  NanoChallenge6
//
//  Created by Charles Ferreira on 11/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        let textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        navigationController?.navigationBar.barTintColor = backgroundColor
        navigationController?.navigationBar.tintColor = textColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: textColor]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: textColor]
        
    }
}
