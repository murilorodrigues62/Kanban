//
//  DoneViewController.swift
//  Kanban
//
//  Created by ifsp on 16/09/16.
//  Copyright © 2016 com.ifsp. All rights reserved.
//

import UIKit

class DoneViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //pega o número de registros salvos
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