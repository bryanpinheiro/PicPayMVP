//
//  PaymentViewController.swift
//  PicPayMVP
//
//  Created by Bryan Souza on 31/08/19.
//  Copyright © 2019 Bryan Souza. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController {
    
    //MARK: Properties
    var image: UIImage?
    
    //MARK: Outlets
    @IBOutlet weak var userImage: RoundImage!
    @IBOutlet weak var lbUsername: UILabel!
    @IBOutlet weak var txtPrice: UITextField!
    
    lazy var presenter: PaymentPresenter = {
        let p = PaymentPresenter(view: self, router: PaymentPresenterRouter(self))
        return p
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        if let u = AppData.User {
            lbUsername.text = u.username
        }
        if let i = AppData.Image {
            userImage.image = i
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigation()
        // Do any additional setup after loading the view.
    }
    
    //MARK: ACTIONS
    @IBAction func back(_ sender: Any) {
        AppData.appDelegate.navigationController?.popToRootViewController(animated: true)
    }
    
    @available(iOS 13.0, *)
    @IBAction func edit(_ sender: Any) {
        presenter.presentCardRegister()
    }
    
    @IBAction func pay(_ sender: Any) {
        guard let card = CardRequest.shared.load() else { return }
        guard let u = AppData.User else { return }
        
        //Data
        guard let number = card.number else { return }
        guard let priceText = txtPrice.text else { return }
        guard let expiryDate = card.expiryDate else { return }
        guard let price = Double(priceText) else { return }
        
        presenter.pay(numero: number, cvv: Int(card.cvv), valor: price, expiracao: expiryDate, idContato: u.id)
    }
    
}
