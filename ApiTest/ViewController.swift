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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        api.getCourses().done {
            courses, meta in
            print(courses)
            print(meta)
        }
    }



}

