//
//  PaymentPresenter.swift
//  PicPayMVP
//
//  Created by Bryan Souza on 03/09/19.
//  Copyright © 2019 Bryan Souza. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents

class PaymentPresenter {
    
    private(set) weak var view: PaymentViewController!
    var router: PaymentPresenterRouter
    
    //MARK: CONSTRUCTOR
    init(view: PaymentViewController, router: PaymentPresenterRouter) {
        self.view = view
        self.router = router
    }
    
    //MARK: FUNCTIONS
    func pay(numero: String, cvv: Int, valor: Double, expiracao: String, idContato: Int){
        NetworkManager.shared.payment(numero: numero, cvv: cvv, valor: valor, expiracao: expiracao, idContato: idContato) { (response, error) in
            if(error != nil){
                print("error: \(error!)")
            }
            else{
                let timestamp = response?.transaction.timestamp
                let id = response?.transaction.destinationUser.id
                let brTime = self.createDateTime(String(timestamp!))
                let status = response?.transaction.success
                DispatchQueue.main.async {
                    let vc = UIStoryboard(name: "User", bundle: nil).instantiateViewController(identifier: "ReceiptViewController") as ReceiptViewController
                    vc.money = valor
                    vc.date = brTime
                    vc.id = id
                    vc.status = status! ? nil : "Recusado"
                    let bottomSheet: MDCBottomSheetController = MDCBottomSheetController(contentViewController: vc)
                    self.view.present(bottomSheet, animated: true, completion: nil)
                }
            }
        }
    }
    
    func createDateTime(_ timestamp: String) -> String {
        var strDate = "undefined"
        
        if let unixTime = Double(timestamp) {
            let date = Date(timeIntervalSince1970: unixTime)
            let dateFormatter = DateFormatter()
            let timezone = TimeZone.current.abbreviation() ?? "CET"
            print(timezone)
            dateFormatter.timeZone = TimeZone(abbreviation: timezone)
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
            strDate = dateFormatter.string(from: date)
        }
        
        let array = strDate.split(separator: " ")
        strDate = array[0] + " ás " + array[1]
        return strDate
    }
    
    //MARK: Navigation
    @available(iOS 13.0, *)
    func presentCardRegister(){
        AppData.appDelegate.navigationController?.pushViewController(AppData.viewControllers[1].subViewControllers![0], animated: true)
    }
    
}
