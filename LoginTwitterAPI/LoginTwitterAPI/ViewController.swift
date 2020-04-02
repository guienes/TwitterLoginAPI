//
//  ViewController.swift
//  LoginTwitterAPI
//
//  Created by Guilherme Enes on 02/04/20.
//  Copyright © 2020 Guilherme Enes. All rights reserved.
//

import UIKit
import TwitterKit

class ViewController: UIViewController {

    @IBOutlet weak var label_name: UILabel!
    @IBOutlet weak var label_username: UILabel!
    @IBOutlet weak var imgView_profile: UIImageView!
    var loginButton: TWTRLogInButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton = TWTRLogInButton{(session,error) in
            if let unwrappedsession = session{
                let client = TWTRAPIClient()
                client.loadUser(withID: (unwrappedsession.userID)) { (user, error) in
                    self.label_name.text = user?.name
                    self.label_username.text = unwrappedsession.userName
                    
                    let imgUrl = user?.profileImageURL
                    let url = URL(string: imgUrl!)
                    let data = try?Data (contentsOf: url!)
                    self.imgView_profile.image = UIImage (data: data!)
                    
                    
                }
            } else {
                print(error)
            }
        }
        
        loginButton.center = self.view.center
        self.view.addSubview(loginButton)
        // Do any additional setup after loading the view.
    }
}

