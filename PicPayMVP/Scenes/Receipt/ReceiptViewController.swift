//
//  ReceiptViewController.swift
//  PicPayMVP
//
//  Created by Bryan Souza on 26/10/19.
//  Copyright © 2019 Bryan Souza. All rights reserved.
//

import UIKit

class ReceiptViewController: UIViewController {

    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var imgUser: RoundImage!
    @IBOutlet weak var lbUsername: UILabel!
    @IBOutlet weak var lbMoney: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbID: UILabel!
    
    var money: Double?
    var id: Int?
    var date: String?
    var status: String?
    
    override func viewWillAppear(_ animated: Bool) {
        if let u = AppData.User {
            lbUsername.text = u.username
        }
        if let i = AppData.Image {
            imgUser.image = i
        }
        if let m = money {
            lbMoney.text = "R$ \(m)"
        }
        if let d = date {
            lbDate.text = d
        }
        if let i = id {
            lbID.text = "Transação: \(i)"
        }
        if let s = status{
            lbStatus.text = s
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
