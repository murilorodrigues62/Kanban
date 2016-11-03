//
//  DetailViewController.swift
//  Kanban
//
//  Created by ifsp on 23/09/16.
//  Copyright © 2016 com.ifsp. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var tituloText: UITextField!
    @IBOutlet weak var prazoText: UITextField!
    @IBOutlet weak var descricaoText: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var pickerDataSource = ["Todo", "Doing", "Done"];
    var indexTodoManager: Int!
    var date: NSDate!
    var estado: Int = 0
    
    @IBAction func salvarTarefa(sender: AnyObject) {
        
        // Obriga a informação do título
        if tituloText.text! == "" {
            let alert = UIAlertController(title: "Ops", message: "Informe o Título", preferredStyle: UIAlertControllerStyle.Alert)
        
            // Emite alerta
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
            return
        }
        
        // Executa ou apend ou update
        if indexTodoManager == nil {
            TodoManager.sharedInstance.addNewTodo(tituloText.text!, descricao: descricaoText.text!, estado: self.estado, date: date)
        }else{
            TodoManager.sharedInstance.saveTodo(indexTodoManager,titulo: tituloText.text!, descricao: descricaoText.text!, estado: self.estado, date: date)

        }
        self.navigationController?.popViewControllerAnimated(true);
    }    
    
    //fecha a tela
    @IBAction func cancelar(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true);
        //dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        // Atualiza os dados na tela
        super.viewDidLoad()
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        tituloText.delegate = self
        prazoText.delegate = self
        descricaoText.delegate = self
        
        if indexTodoManager != nil {
            let todo: Todo = TodoManager.sharedInstance.todoAtIndex(indexTodoManager)
            tituloText.text = todo.titulo
            date = NSDate(timeIntervalSince1970: todo.prazo)
            descricaoText.text = todo.descricao
            pickerView.selectRow(Int(todo.estado!), inComponent: 0, animated: true)
            estado = Int(todo.estado!)
        }else{
            date = NSDate()
        }
    }
    
    //Quando apertamos enter nos textField o Teclado fecha da tela do telefone
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField == prazoText {
            let datePicker = UIDatePicker()
            //para mudar o tipo de teclado quando se está digitando data
            textField.inputView = datePicker
            // para capturar a data do teclado de data
            datePicker.addTarget(self, action: #selector(DetailViewController.datePickerChanged(_:)), forControlEvents: .ValueChanged)
        }
    }
    
    func datePickerChanged(sender: UIDatePicker){
        displayDate(sender.date)
    }
    
    func displayDate(date: NSDate){
        let formatter = NSDateFormatter()
        formatter.dateStyle = .FullStyle
        prazoText.text = formatter.stringFromDate(date)
        self.date = date
    }
    
    // Touch Events
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        displayDate(date)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //numero dos componentes setados
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //numeros de elementos do picker
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerDataSource[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        // selected value in Uipickerview in Swift
        self.estado = row;
    }
}
