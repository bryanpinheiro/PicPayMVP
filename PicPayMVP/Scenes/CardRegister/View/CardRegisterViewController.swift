//
//  CardRegisterViewController.swift
//  PicPayMVP
//
//  Created by Bryan Souza on 05/09/19.
//  Copyright © 2019 Bryan Souza. All rights reserved.
//

import UIKit
import SVProgressHUD

class CardRegisterViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var txtTitular: TextFieldMaterialDesign!
    @IBOutlet weak var txtNumCard: TextFieldMaterialDesign!
    @IBOutlet weak var txtExpiryDate: TextFieldMaterialDesign!
    @IBOutlet weak var txtCvv: TextFieldMaterialDesign!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var card: Card?
    
    lazy var presenter: CardRegisterPresenter = {
        let p = CardRegisterPresenter(view: self, router: CardRegisterRouter(self))
        return p
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        card = CardRequest.shared.load()
        self.setupNavigation()
        if(card != nil){
            guard let card = card else { return }
            txtNumCard.text = card.number
            txtTitular.text = card.name
            txtExpiryDate.text = card.expiryDate
            txtCvv.text = String(card.cvv)
        }
    }
    
    //MARK: Actions
    @available(iOS 13.0, *)
    @IBAction func btnSave(_ sender: Any) {
        guard let num = txtNumCard.text else { return }
        guard let titular = txtTitular.text else { return }
        guard let vencimento = txtExpiryDate.text else { return }
        guard let cvv = txtCvv.text else { return }
        presenter.save(num, titular, vencimento, cvv)
        presenter.presentPayment()
    }
    
}
