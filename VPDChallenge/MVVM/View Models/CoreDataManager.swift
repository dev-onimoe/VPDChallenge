//
//  CoreDataManager.swift
//  VPDChallenge
//
//  Created by Masud Onikeku on 23/06/2024.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //let context = appDelegate!.persistentContainer.viewContext
    
    func createData(data: [APIRepo], page: String) {
        //guard let appDelegate = appDelegate else { return }
        //managedContext = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: "Repos", in: managedContext)!
        let cmsg = NSManagedObject(entity: userEntity, insertInto: managedContext) as! Repos
        let mRanges = APIRepos(repos: data)
        cmsg.setValue(mRanges, forKeyPath: "repos")
        cmsg.setValue(page, forKey: "page")
        do {
            try managedContext.save()
            
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    
    func retrieveData() -> APIRepos? {
        
        //guard let appDelegate = appDelegate else { return nil}
        //managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Repos")
        var repos : APIRepos? = nil
        do {
            
            let result = try managedContext.fetch(Repos.fetchRequest())
            var i = 0
            for data in result as! [NSManagedObject] {
                repos = data.value(forKey: "repos") as? APIRepos
                let page = data.value(forKey: "page") as? String
                print(page, repos?.repos.count)
                i = i + 1
                //return repos
            }
            
        }catch {
            print ("Failed" )
            
        }
        return repos
    }
    
    func updateData(page: String, repos: [APIRepo]) {
        //guard let appDelegate = appDelegate else { return }
        //managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Repos")
        let ppg = page != "1" ? String(Int(page)! - 1) : "1"
        fetchRequest.predicate = NSPredicate(format:"page == %@", ppg)
        print("update Count", repos.count)
        let result = try? managedContext.fetch(fetchRequest)
        if result?.count != 0 {
            let dic = result![0] as! Repos
            let mRanges = APIRepos(repos: repos)
            dic.setValue(mRanges, forKey: "repos")
            dic.setValue(page, forKey: "page")
            do {
                try managedContext.save()
                print("saved!")
            } catch {
                print(error.localizedDescription)
            }
        }else {
            print("No result")
        }
    }
}
