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
    private(set) weak var view: CardRegisterPresenterView!
    private weak var scrollView: UIScrollView!
    private var router: CardRegisterRouter
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var cardList = [Card]()
    
    //MARK: CONSTRUCTOR
    init(view: CardRegisterPresenterView, router: CardRegisterRouter) {
        self.view = view
        self.router = router
    }
    
    //MARK: SAVE CARD ON CORE DATA
    func save(_ number: String, _ titular: String, _ vencimento: String, _ cvv: String){
        if(load() == nil){
            //CREATE
            if (!number.isEmpty && !titular.isEmpty && !vencimento.isEmpty && !cvv.isEmpty){
                let newCard = Card(context: context)
                newCard.id = 1
                newCard.name = titular
                newCard.cvv = Int32(cvv)!
                newCard.number = number
                newCard.expiryDate = vencimento
                self.cardList.append(newCard)
                saveContext()
            }
        }
        else{
            //UPDATE
            if (!number.isEmpty && !titular.isEmpty && !vencimento.isEmpty && !cvv.isEmpty){
                cardList[0].name = titular
                cardList[0].expiryDate = vencimento
                cardList[0].number = number
                cardList[0].cvv = Int32(cvv)!
                saveContext()
            }
        }
    }
    
    func saveContext(){
        do{
            try context.save()
        }
        catch {
            print("Error: \(error)")
        }
    }
    
    //MARK: GET CARD FROM CORE DATA
    
    //READ
    func load() -> Card? {
        let request: NSFetchRequest<Card> = Card.fetchRequest()
        do{
            cardList = try context.fetch(request)
        }
        catch
        {
            print("Error fetching data from context: \(error)")
        }
        
        if(cardList.isEmpty){
            return nil
        }
        else {
            return cardList[0]
        }
        
    }
    
    //DELETE
    func delete(){
        guard let card = cardList.last else { return }
        context.delete(card)
        saveContext()
    }
    
    //MARK: Navigation
    func prepare(for segue: UIStoryboardSegue, sender: Any?){
        router.prepare(for: segue, sender: sender)
    }
}
