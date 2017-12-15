//
//  ViewController2.swift
//  Grade
//
//  Created by eleves on 17-11-24.
//  Copyright © 2017 eleves. All rights reserved.
//

import UIKit

class GradeController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    
    @IBOutlet weak var course_grade_tableview: UITableView!
    @IBOutlet weak var student_name_label: UILabel!
    @IBOutlet weak var courseField: UITextField!
    @IBOutlet weak var gradeField: UITextField!
    
    @IBOutlet weak var moyenneLabel: UILabel!
    @IBOutlet weak var moyenneLabelSur10: UILabel!
    
    let userdefaultObj = UserDefaultsManager()
    typealias studenName = String
    typealias cours = String
    typealias grade = String
    var studentGrades :[studenName:[cours:grade]]!
    var arrayOfCourse :[cours]!
    var arrayOfGrades :[grade]!
    var somme = 0
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        student_name_label.text = userdefaultObj.getValue(theKey: "name") as? String
        loadUserDefault()
        fillUpArray()
        faireMoyenne()
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //-------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfCourse.count
    }
    
    //-------
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell:UITableViewCell = course_grade_tableview.dequeueReusableCell(withIdentifier: "proto")!
        
        if let aCourse = cell.viewWithTag(100) as! UILabel!{
            aCourse.text = arrayOfCourse[indexPath.row]
        }
        if let aGrade = cell.viewWithTag(101) as! UILabel!{
            aGrade.text = String(arrayOfGrades[indexPath.row])
        }
        
        return cell
    }
    //-------
    func loadUserDefault(){
        if userdefaultObj.doesKeyExist(theKey:"grades"){
            studentGrades = userdefaultObj.getValue(theKey:"grades") as! [ViewController.studenName : [ViewController.cours : ViewController.grade]]
            
        }else{
            studentGrades = [studenName:[cours:grade]]()
        }
        
    }
    
    
    //-------
    func faireMoyenne() {
        if arrayOfGrades.count != 0 ||  gradeField.text != "" ||  courseField.text != "" {
            somme = 0
            for i in arrayOfGrades {
                somme += Int(i)!
                print(arrayOfGrades)
            }
            
            moyenneLabel.text = String("the average is : ") + String(somme/(arrayOfGrades.count)) + String("/100") // sur 100
            let moyenneSurDix = Double((somme/(arrayOfGrades.count)))/10.0
            moyenneLabelSur10.text = String(format:"the average is : %0.1f /10",moyenneSurDix)  // sur 10
        }
        
    }
    //-------
    
    func fillUpArray(){
        let name = student_name_label.text
        let courses_and_grades = studentGrades[name!]
        arrayOfCourse = [cours](courses_and_grades!.keys)
        arrayOfGrades = [cours](courses_and_grades!.values)
        
    }
    //-------
    
    @IBAction func save_course_and_grade(_ sender: UIButton) { // bouton ajouter
        let name = student_name_label.text!
        var student_courses = studentGrades[name]!
        student_courses[courseField.text!] = gradeField.text!
        studentGrades[name] = student_courses
        
        
        userdefaultObj.setKey(theValue: studentGrades as AnyObject, theKey: "grades") //sauvegarde
        fillUpArray()
        course_grade_tableview.reloadData()
        faireMoyenne()
        courseField.text = ""
        gradeField.text = ""
        
    }
    
    
    
    
    
    
    
}
