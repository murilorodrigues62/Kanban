//
//  TodoManager.swift
//  Kanban
//
//  Created by ifsp on 30/09/16.
//  Copyright © 2016 com.ifsp. All rights reserved.
//

import UIKit
import CoreData

class TodoManager{
    
    static let sharedInstance = TodoManager()
    static var estadoAtual = 0
    private var todos = [Todo]()
    let context: NSManagedObjectContext!
    
    var count: Int {
        get{
            return todos.count
        }
    }
    
    func todoAtIndex(index: Int) -> Todo{
        return todos[index]
    }
    
    // Metodo para adicionar tarefa
    func addNewTodo(titulo: String,descricao: String, estado: Int,  date: NSDate){
        let todo =  NSEntityDescription.insertNewObjectForEntityForName("Todo", inManagedObjectContext: context) as! Todo
        todo.titulo = titulo
        todo.descricao = descricao
        todo.prazo = date.timeIntervalSince1970
        todo.estado = estado
        
        todos.append(todo)
        saveContext()
        
        //faz a consulta atual
        fetchTodos(TodoManager.estadoAtual)
    }
    
    // Metodo para atualizar tarefa
    func saveTodo(index: Int,titulo: String,descricao: String, estado: Int,  date: NSDate){
        let todo: Todo = TodoManager.sharedInstance.todoAtIndex(index)
        todo.titulo = titulo
        todo.descricao = descricao
        todo.prazo = date.timeIntervalSince1970
        todo.estado = estado
        
        saveContext()
        
        //faz a consulta atual
        fetchTodos(TodoManager.estadoAtual)
    }
    
    func removeTodoAtIndex(index: Int){
        //remove do banco de dados
        context.deleteObject(todoAtIndex(index))
        //remove do array
        todos.removeAtIndex(index)
        saveContext()
        
        //faz a consulta atual
        fetchTodos(TodoManager.estadoAtual)
    }
    
    func saveContext(){
        do{
            try context.save()
        } catch let error as NSError{
            print("Error saving context: \(error), \(error.userInfo)")
        }
    }
    
    func fetchTodos(estado: Int){
        let fetchRequest = NSFetchRequest(entityName: "Todo")
        
        do{
            //faz o filtro pelo estado das tarefas
            fetchRequest.predicate = NSPredicate(format: "estado == %i", estado)
            let results = try context.executeFetchRequest(fetchRequest)
            todos = results as! [Todo]
        }catch let error as NSError{
            print("Could not fetch todos: \(error), \(error.userInfo)")
        }
    }
    
    // MARK: Init
    private init(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        context = appDelegate.managedObjectContext
        
        fetchTodos(0)
    }
}
