//
//  ViewController.swift
//  ApiTest
//
//  Created by Ostrenkiy on 28.09.2018.
//  Copyright © 2018 Ostrenkiy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let api = CoursesApi(requestMaker: RequestMaker())
    
    func retrieveCachedAndApi(twice: Bool) {
        let cachedCourses = RealmPersistenceService.shared.read(type: Course.self, predicate: nil)
        print("cached courses \(cachedCourses.map { "\($0.id) \($0.title)"})")
        api.getCourses().done { [weak self] courses, meta in
            print("loaded courses \(courses.map { "\($0.id) \($0.title)"})")
            RealmPersistenceService.shared.write(objects: courses)
            if twice {
                self?.retrieveCachedAndApi(twice: false)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        retrieveCachedAndApi(twice: true)
    }



}

