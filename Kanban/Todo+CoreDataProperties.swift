//
//  Todo+CoreDataProperties.swift
//  Kanban
//
//  Created by ifsp on 30/09/16.
//  Copyright © 2016 com.ifsp. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Todo {

    @NSManaged var titulo: String?
    @NSManaged var descricao: String?
    @NSManaged var prazo: NSTimeInterval
    @NSManaged var estado: NSNumber?

}
