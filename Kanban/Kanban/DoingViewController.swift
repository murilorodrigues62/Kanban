//
//  SessionsViewController.swift
//  ViewControllerContainment
//
//  Created by Bart Jacobs on 01/05/16.
//  Copyright © 2016 Bart Jacobs. All rights reserved.
//

import UIKit

class DoingViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TodoManager.sharedInstance.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")!
        let todo = TodoManager.sharedInstance.todoAtIndex(indexPath.row)
        
        cell.textLabel?.text = todo.titulo
        let formatter = NSDateFormatter()
        formatter.dateStyle = .FullStyle
        let date = NSDate(timeIntervalSince1970: todo.prazo)
        cell.detailTextLabel?.text = formatter.stringFromDate(date)
        
        return cell
    }
    
    //View lifecycle methods
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    internal func atualizaTabela(){
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            //Remove o item do banco de dados
            TodoManager.sharedInstance.removeTodoAtIndex(indexPath.row)
            // remove o item da tableView
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Left)
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showEdit", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showEdit" {
            let indexPaths = self.tableView!.indexPathsForSelectedRows!
            let indexPath = indexPaths[0] as NSIndexPath
            
            let vc = segue.destinationViewController as! DetailViewController
            vc.indexTodoManager = indexPath.row
        }
    } 

}
