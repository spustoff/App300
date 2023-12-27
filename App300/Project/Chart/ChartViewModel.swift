//
//  ChartViewModel.swift
//  App300
//
//  Created by Вячеслав on 12/24/23.
//

import SwiftUI
import CoreData

final class ChartViewModel: ObservableObject {
    
    @Published var charts: [ChartModel] = []
    
    @Published var isAdd: Bool = false
    
    @Published var date_stream: Date = Date()
    @Published var start_stream: Date = Date()
    @Published var end_stream: Date = Date()
    
    @Published var streamer: String = ""
    @Published var game: String = ""
    
    func addStream() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "ChartModel", into: context) as! ChartModel
        
        loan.date_stream = date_stream
        loan.start_stream = start_stream
        loan.end_stream = end_stream
        
        loan.streamer = streamer
        loan.game = game
        
        CoreDataStack.shared.saveContext()
    }
    
    func fetchCharts() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<ChartModel>(entityName: "ChartModel")

        do {
            
            let result = try context.fetch(fetchRequest)
        
            self.charts = result
            
        } catch let error as NSError {
            
            print("catch")
            
            print("Error fetching persons: \(error), \(error.userInfo)")
            
            self.charts = []
        }
    }
}
