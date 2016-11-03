//
//  MasterViewController.swift
//  ViewControllerContainment
//
//  Created by Bart Jacobs on 01/05/16.
//  Copyright © 2016 Bart Jacobs. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {

    @IBOutlet var segmentedControl: UISegmentedControl!

    lazy var todoViewController: TodoViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())

        // Instantiate View Controller
        var viewController = storyboard.instantiateViewControllerWithIdentifier("TodoViewController") as! TodoViewController

        // Add View Controller as Child View Controller
        self.addViewControllerAsChildViewController(viewController)

        return viewController
    }()

    lazy var doingViewController: DoingViewController = {
        
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        
        var viewController = storyboard.instantiateViewControllerWithIdentifier("DoingViewController") as! DoingViewController

        self.addViewControllerAsChildViewController(viewController)
        
        return viewController
    }()
    
    lazy var doneViewController: DoneViewController = {
        
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        
        var viewController = storyboard.instantiateViewControllerWithIdentifier("DoneViewController") as! DoneViewController
        self.addViewControllerAsChildViewController(viewController)
        
        return viewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        setupSegmentedControl()
        updateView()
    }

    func updateView() {
        // Exibe a View conforme o que está selecionado no segmented control
        todoViewController.view.hidden = !(segmentedControl.selectedSegmentIndex == 0)
        doingViewController.view.hidden = !(segmentedControl.selectedSegmentIndex == 1)
        doneViewController.view.hidden = !(segmentedControl.selectedSegmentIndex == 2)
        
        TodoManager.sharedInstance.fetchTodos(segmentedControl.selectedSegmentIndex)
        TodoManager.estadoAtual = segmentedControl.selectedSegmentIndex
        
        // chama metodo que atualiza tabela conforme status selecionado
        if segmentedControl.selectedSegmentIndex == 0 {
            todoViewController.atualizaTabela()
        }else if segmentedControl.selectedSegmentIndex == 1 {
            doingViewController.atualizaTabela();
        }else{
            doneViewController.atualizaTabela();
        }
    }

    func setupSegmentedControl() {
        // Configure Segmented Control
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegmentWithTitle("Todo", atIndex: 0, animated: false)
        segmentedControl.insertSegmentWithTitle("Doing", atIndex: 1, animated: false)
        segmentedControl.insertSegmentWithTitle("Done", atIndex: 2, animated: false)
        segmentedControl.addTarget(self, action: #selector(selectionDidChange(_:)), forControlEvents: .ValueChanged)

        // Select First Segment
        segmentedControl.selectedSegmentIndex = 0
    }

    func selectionDidChange(sender: UISegmentedControl) {
        updateView()
    }
    
    private func addViewControllerAsChildViewController(viewController: UIViewController) {
        // Add Child View Controller
        addChildViewController(viewController)

        // Add Child View as Subview
        view.addSubview(viewController.view)

        // Configure Child View
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]

        // Notify Child View Controller
        viewController.didMoveToParentViewController(self)
    }
    
    private func removeViewControllerAsChildViewController(viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMoveToParentViewController(nil)

        // Remove Child View From Superview
        viewController.view.removeFromSuperview()

        // Notify Child View Controller
        viewController.removeFromParentViewController()
    }
    
}
