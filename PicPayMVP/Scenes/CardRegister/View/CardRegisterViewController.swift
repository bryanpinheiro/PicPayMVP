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
    @IBOutlet weak var lbTitular: UITextField!
    @IBOutlet weak var lbNumCartao: UITextField!
    @IBOutlet weak var lbVencimento: UITextField!
    @IBOutlet weak var lbCvv: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    //MARK: Actions
    @IBAction func btnSave(_ sender: Any) {
        
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
