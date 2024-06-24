//
//  Repos+CoreDataProperties.swift
//  VPDChallenge
//
//  Created by Masud Onikeku on 23/06/2024.
//
//

import Foundation
import CoreData


extension Repos {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Repos> {
        return NSFetchRequest<Repos>(entityName: "Repos")
    }

    @NSManaged public var repos: APIRepos?
    @NSManaged public var page: String?

}

extension Repos : Identifiable {

}
