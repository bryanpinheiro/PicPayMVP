//
//  CardRequest.swift
//  PicPayMVP
//
//  Created by Bryan Souza on 19/09/19.
//  Copyright © 2019 Bryan Souza. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct CardRequest {
    
    static let shared = CardRequest()
    static var cardList: [Card] = []
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //READ
    func load() -> Card? {
        let request: NSFetchRequest<Card> = Card.fetchRequest()
        do{
            CardRequest.cardList = try context.fetch(request)
        }
        catch
        {
            print("Error fetching data from context: \(error)")
        }
        if(CardRequest.cardList.isEmpty){
            return nil
        }
        else {
            return CardRequest.cardList[0]
        }
    }
}
