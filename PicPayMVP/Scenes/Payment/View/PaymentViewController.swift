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
    var user: User?
    var image: UIImage?
    
    //MARK: Outlets
    @IBOutlet weak var userImage: RoundImage!
    @IBOutlet weak var lbUsername: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    
    lazy var presenter: PaymentPresenter = {
        let p = PaymentPresenter(view: self as! PaymentPrensenterView, router: PaymentPresenterRouter(self))
        return p
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbUsername.text = user?.username
        userImage.image = image
        // Do any additional setup after loading the view.
    }
    
    //MARK: ACTIONS
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func edit(_ sender: Any) {
        presenter.router.presentCardRegister()
    }
    
}

extension PaymentViewController: PaymentPrensenterView{
    func startLoading() {
        print("start")
    }
    
    func stopLoading() {
        print("stop")
    }
}
