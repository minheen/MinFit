//
//  LibraryViewController.swift
//  MinFit
//
//  Created by 노민희 on 2022/05/24.
//

import UIKit

import Firebase

class LibraryViewController: UIViewController {

    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        ref.child("Library").observeSingleEvent(of: .value) { kind in
            kind.children.forEach { name in
                print(name)
            }
        }
    }
}
