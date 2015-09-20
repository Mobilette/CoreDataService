//
//  ViewController.swift
//  CoreDataService
//
//  Created by Romain ASNAR on 9/20/15.
//  Copyright (c) 2015 Mobilette. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        CoreDataService.deleteAllEntities("TestEntity")
        let test1 = CoreDataService.managedObjectWithEntityName("TestEntity") as? TestEntity
        test1?.title = "Test 1 title"
        let test2 = CoreDataService.managedObjectWithEntityName("TestEntity") as? TestEntity
        test2?.title = "Test 2 title"
        CoreDataService.saveNewChanges()
        let numberOfManagedObjects = CoreDataService.fetchManagedObjects(entityName: "TestEntity")?.count
        println("number of managed objects: \(numberOfManagedObjects)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

