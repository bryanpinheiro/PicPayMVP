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
    @IBOutlet weak var lbNumCartao: UITextField!
    @IBOutlet weak var lbTitular: UITextField!
    @IBOutlet weak var lbVencimento: UITextField!
    @IBOutlet weak var lbCvv: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var card: Card?
    
    lazy var presenter: CardRegisterPresenter = {
        let p = CardRegisterPresenter(view: self, router: CardRegisterRouter(self))
        return p
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        card = presenter.load()
        
        if(card != nil){
            guard let card = card else { return }
            lbNumCartao.text = card.number
            lbTitular.text = card.name
            lbVencimento.text = card.expiryDate
            lbCvv.text = String(card.cvv)
        }
    }
    
    //MARK: Actions
    @IBAction func btnSave(_ sender: Any) {
        guard let num = lbNumCartao.text else { return }
        guard let titular = lbTitular.text else { return }
        guard let vencimento = lbVencimento.text else { return }
        guard let cvv = lbCvv.text else { return }
        presenter.save(num, titular, vencimento, cvv)
    }
    
}

extension CardRegisterViewController: CardRegisterPresenterView{
    func startLoading() {
        SVProgressHUD.show()
    }
    
    func stopLoading() {
        SVProgressHUD.dismiss()
    }
    
    func reloadData() {
        print()
    }
}
