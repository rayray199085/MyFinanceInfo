//
//  CoreDataManager.swift
//  CoreDataLearning
//
//  Created by Stephen Cao on 12/7/19.
//  Copyright © 2019 Stephencao Cao. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    static let shared = CoreDataManager()
    
    lazy var context: NSManagedObjectContext = {
        let context = ((UIApplication.shared.delegate) as! AppDelegate).context
        return context
    }()
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func addCompanyWith(ticker: String, searchFrequency: Int16) {
        let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context) as! Company
        company.ticker = ticker
        company.searchFrequency = searchFrequency
        saveContext()
    }
    
    func getAllCompany() -> [Company] {
        let fetchRequest: NSFetchRequest = Company.fetchRequest()
        // for sort
        let sort = NSSortDescriptor(key: #keyPath(Company.searchFrequency), ascending: false)
        fetchRequest.sortDescriptors = [sort]
        do {
            let result = try context.fetch(fetchRequest)
            return result
        } catch {
            fatalError();
        }
    }
    
    func getCompanyWith(ticker: String) -> [Company] {
        let fetchRequest: NSFetchRequest = Company.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "ticker == %@", ticker)
        do {
            let result: [Company] = try context.fetch(fetchRequest)
            return result
        } catch {
            fatalError();
        }
    }
    
    func updateCompanySearchFrequencyWith(ticker: String) {
        let fetchRequest: NSFetchRequest = Company.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "ticker == %@", ticker)
        do {
            let result = try context.fetch(fetchRequest)
            for company in result {
                company.searchFrequency += 1
            }
        } catch {
            fatalError();
        }
        saveContext()
    }
    
    func deleteWith(ticker: String) {
        let fetchRequest: NSFetchRequest = Company.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "ticker == %@", ticker)
        do {
            let result = try context.fetch(fetchRequest)
            for company in result {
                context.delete(company)
            }
        } catch {
            fatalError();
        }
        saveContext()
    }
    
    func deleteAllCompany() {
        let result = getAllCompany()
        for company in result {
            context.delete(company)
        }
        saveContext()
    }
}
