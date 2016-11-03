//
//  ViewController.swift
//  Kanban
//
//  Created by ifsp on 16/09/16.
//  Copyright © 2016 com.ifsp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!

    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            print("aaa")
        case 1:
            print("bbb")
        default:
            break;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        // Do any additional setup after loading the view, typically from a nib.
        
        lazy var todoViewController: TodoController = {
            
            // Load StoryBoard
            let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            
            //Instantiate View Controller
            var viewController = storyboard.instantiateViewControllerWithIdentifier("TodoController") as! TodoController
            
            //add view controller as child view controller
            
            self.addview(UIViewController)
        }

    }
    
    func setupView(){
        setupSegmentedControl()
    }
    
    func setupSegmentedControl(){
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegmentWithTitle("Todo", atIndex: 0, animated: false)
        segmentedControl.insertSegmentWithTitle("Doing", atIndex: 1, animated: false)
        
        segmentedControl.addTarget(self, action: #selector(selectionDidChange(_:)), forControlEvents: .ValueChanged)
        
        segmentedControl.selectedSegmentIndex = 0
    }
    
    func selectionDidChange(sender: UISegmentedControl){
        updateView()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

