//
//  CardRegisterPresenter.swift
//  PicPayMVP
//
//  Created by Bryan Souza on 05/09/19.
//  Copyright © 2019 Bryan Souza. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CardRegisterPresenter {
    
    //MARK: PROPERTIES
    private(set) weak var view: CardRegisterViewController!
    private weak var scrollView: UIScrollView!
    private var router: CardRegisterRouter
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK: CONSTRUCTOR
    init(view: CardRegisterViewController, router: CardRegisterRouter) {
        self.view = view
        self.router = router
    }
    
    //MARK: ViewDidLoad
    func viewDidLoad(){
        reload()
    }
    
    //MARK: SAVE CARD ON CORE DATA
    func save(_ number: String, _ titular: String, _ vencimento: String, _ cvv: String){
        if(CardRequest.shared.load() == nil){
            //CREATE
            create(number, titular, vencimento, cvv)
        }
        else{
            //UPDATE
            if (!number.isEmpty && !titular.isEmpty && !vencimento.isEmpty && !cvv.isEmpty && CardRequest.cardList.count > 0){
                CardRequest.cardList[0].name = titular
                CardRequest.cardList[0].expiryDate = vencimento
                CardRequest.cardList[0].number = number
                CardRequest.cardList[0].cvv = Int32(cvv)!
                saveContext()
            }
            else {
                //CREATE
                create(number, titular, vencimento, cvv)
            }
        }
    }
    
    //MARK: CREATE
    func create(_ number: String, _ titular: String, _ expiryDate: String, _ cvv: String){
        if (!number.isEmpty && !titular.isEmpty && !expiryDate.isEmpty && !cvv.isEmpty){
            let newCard = Card(context: context)
            newCard.id = 1
            newCard.name = titular
            newCard.cvv = Int32(cvv)!
            newCard.number = number
            newCard.expiryDate = expiryDate
            CardRequest.cardList.append(newCard)
            saveContext()
        }
    }
    
    //MARK: SAVE
    func saveContext(){
        do{
            try context.save()
        }
        catch {
            print("Error: \(error)")
        }
    }
    
    //MARK: RELOAD
    func reload(){
        let request: NSFetchRequest<Card> = Card.fetchRequest()
        do{
            CardRequest.cardList = try context.fetch(request)
        }
        catch
        {
            print("Error fetching data from context: \(error)")
        }
    }
    
    //DELETE
    func delete(){
        guard let card = CardRequest.cardList.last else { return }
        context.delete(card)
        saveContext()
    }
    
    //MARK: PresentPayment
    @available(iOS 13.0, *)
    func presentPayment(){
        AppData.appDelegate.navigationController?.viewControllers.removeLast()
        AppData.appDelegate.navigationController?.viewControllers.removeLast()
        AppData.appDelegate.navigationController?.pushViewController(AppData.viewControllers[2].viewController, animated: true)
    }
    
}
