//
//  Item+CoreDataClass.swift
//  DreamListr
//
//  Created by Hesham Saleh on 1/29/17.
//  Copyright © 2017 Hesham Saleh. All rights reserved.
//

import Foundation
import CoreData
import Simperium.SPManagedObject


public class Item: SPManagedObject {

    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        self.created = NSDate() //Assigning current date to 'created' attribute.
        
    }
}
