//
//  AddMemoViewController.swift
//  MySchool
//
//  Created by SWUCOMPUTER on 2020/07/04.
//  Copyright © 2020 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData


class AddMemoViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var textTitle: UITextField!
    @IBOutlet var textMemo: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func getContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func buttonMemoSave(_ sender: UIBarButtonItem) {
        let context = self.getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Memo", in: context)
        let object = NSManagedObject(entity: entity!, insertInto: context)
        
        object.setValue(textTitle.text, forKey: "title")
        object.setValue(textMemo.text, forKey: "memo")
        object.setValue(Date(), forKey: "saveDate")
        
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError{
            print("Could not save \(error), \(error.userInfo)")
        }
        self.navigationController?.popViewController(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
