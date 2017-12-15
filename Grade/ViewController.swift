//
//  ViewController.swift
//  Grade
//
//  Created by eleves on 17-11-24.
//  Copyright © 2017 eleves. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    
    @IBOutlet weak var student_name_field: UITextField!
    @IBOutlet weak var student_name_tableview: UITableView!
    let userdefaultObj = UserDefaultsManager()
    typealias studenName = String
    typealias cours = String
    typealias grade = String
    var studentGrades : [studenName:[cours:grade]]!
    
    override func viewDidLoad() {
        loadUserDefault()
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentGrades.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style:UITableViewCellStyle.default,reuseIdentifier: nil)
        cell.textLabel?.text = [studenName](studentGrades.keys)[indexPath.row]
        return cell
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{ 
        textField.resignFirstResponder()
        return true
    }
    
    
    
    
    func loadUserDefault(){ // sauvegarde
        if userdefaultObj.doesKeyExist(theKey:"grades"){
            studentGrades = userdefaultObj.getValue(theKey:"grades") as! [ViewController.studenName : [ViewController.cours : ViewController.grade]]
            
        }else{
            studentGrades = [studenName:[cours:grade]]()
        }
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            let name = [studenName](studentGrades.keys)[indexPath.row]
            studentGrades[name] = nil
            userdefaultObj.setKey(theValue:studentGrades as AnyObject, theKey: "grades")
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { // lorsque l'on sélectionne l'élève
        let name = [studenName](studentGrades.keys)[indexPath.row]
        userdefaultObj.setKey(theValue: name as AnyObject, theKey: "name")
        performSegue(withIdentifier: "seg", sender: nil)
    }
    
    @IBAction func add_student(_ sender: UIButton) {// bouton pour ajouter les éleves
        if student_name_field.text != "" {
            studentGrades[student_name_field.text!] = [cours:grade]()
            student_name_field.text = ""
            userdefaultObj.setKey(theValue: studentGrades as AnyObject, theKey: "grades")
            student_name_tableview.reloadData()
        }
        
    }
    
}

