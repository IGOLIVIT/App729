//
//  ServiceViewModel.swift
//  App729
//
//  Created by IGOR on 24/07/2024.
//

import SwiftUI
import CoreData

final class ServiceViewModel: ObservableObject {
    
    @Published var photos: [String] = ["k1", "k2"]
    @Published var curPhoto: String = ""
    
    @AppStorage("categories") var categories: [String] = ["All"]
    @Published var carToAdd = ""
    @Published var currentCat = "All"

    @Published var isAdd: Bool = false
    @Published var isAddInventory: Bool = false
    @Published var isAddCat: Bool = false
    @Published var isCurr: Bool = false
    @Published var isDetail: Bool = false
    @Published var isDelete: Bool = false
    
    @Published var inPhoto: String = ""
    @Published var inName: String = ""
    @Published var inCat: String = ""
    @Published var inStamp: String = ""
    @Published var inModel: String = ""
    @Published var inSize: String = ""
    @Published var inSD: String = ""
    
    @Published var inventories: [InvModel] = []
    @Published var selectedInventory: InvModel?
    
    func addInventory() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "InvModel", into: context) as! InvModel
        
        loan.inPhoto = inPhoto
        loan.inName = inName
        loan.inStamp = inStamp
        loan.inCat = inCat
        loan.inModel = inModel
        loan.inSize = inSize
        loan.inSD = inSD

        CoreDataStack.shared.saveContext()
    }
    
    func fetchInventories() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<InvModel>(entityName: "InvModel")
        
        do {
            
            let result = try context.fetch(fetchRequest)
            
            self.inventories = result
            
        } catch let error as NSError {
            
            print("catch")
            
            print("Error fetching persons: \(error), \(error.userInfo)")
            
            self.inventories = []
        }
    }
    
    @Published var recName: String = ""
    @Published var recDate: String = ""
    @Published var recInv: String = ""
    
    @Published var records: [RecModel] = []
    @Published var selectedRecord: RecModel?
    
    func addRecord() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "RecModel", into: context) as! RecModel
        
        loan.recName = recName
        loan.recDate = recDate
        loan.recInv = recInv

        CoreDataStack.shared.saveContext()
    }
    
    func fetchRecords() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<RecModel>(entityName: "RecModel")
        
        do {
            
            let result = try context.fetch(fetchRequest)
            
            self.records = result
            
        } catch let error as NSError {
            
            print("catch")
            
            print("Error fetching persons: \(error), \(error.userInfo)")
            
            self.records = []
        }
    }
}
