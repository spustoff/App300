//
//  TeamViewModel.swift
//  App300
//
//  Created by Вячеслав on 12/24/23.
//

import SwiftUI
import CoreData

final class TeamViewModel: ObservableObject {
    
    @Published var isAdd: Bool = false
    @Published var isDetail: Bool = false
    
    @Published var nickname: String = ""
    @Published var name: String = ""
    @Published var subscribers: String = ""
    
    @Published var teams: [TeamModel] = []
    
    func addMember() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "TeamModel", into: context) as! TeamModel
        
        loan.nickname = nickname
        loan.name = name
        loan.subscribers = Int16(subscribers) ?? 0
        
        CoreDataStack.shared.saveContext()
    }
    
    func fetchTeams() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<TeamModel>(entityName: "TeamModel")

        do {
            
            let result = try context.fetch(fetchRequest)
        
            self.teams = result
            
        } catch let error as NSError {
            
            print("catch")
            
            print("Error fetching persons: \(error), \(error.userInfo)")
            
            self.teams = []
        }
    }
}
