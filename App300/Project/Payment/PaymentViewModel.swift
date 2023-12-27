//
//  PaymentViewModel.swift
//  App300
//
//  Created by Вячеслав on 12/24/23.
//

import SwiftUI
import CoreData

final class PaymentViewModel: ObservableObject {
    
    @Published var payments: [PaymentModel] = []
    
    @Published var date_stream: Date = Date()
    @Published var streamer: String = ""
    @Published var earned: String = ""
    @Published var payment_type: String = ""
    
    @Published var isAdd: Bool = false
    
    func addPayment() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "PaymentModel", into: context) as! PaymentModel
        
        loan.date_stream = date_stream
        loan.streamer = streamer
        loan.earned = Int16(earned) ?? 0
        
        loan.payment_type = payment_type
        
        CoreDataStack.shared.saveContext()
    }
    
    func fetchPayments() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<PaymentModel>(entityName: "PaymentModel")

        do {
            
            let result = try context.fetch(fetchRequest)
        
            self.payments = result
            
        } catch let error as NSError {
            
            print("catch")
            
            print("Error fetching persons: \(error), \(error.userInfo)")
            
            self.payments = []
        }
    }
}
