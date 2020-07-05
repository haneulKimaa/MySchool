//
//  ColorViewController.swift
//  MySchool
//
//  Created by SWUCOMPUTER on 2020/07/04.
//  Copyright © 2020 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class ColorViewController: UIViewController, UITextFieldDelegate{
    @IBOutlet var textColor1: UITextField!
    @IBOutlet var textColor2: UITextField!
    @IBOutlet var textColor3: UITextField!
    @IBOutlet var textColor4: UITextField!
    @IBOutlet var textColor5: UITextField!
    @IBOutlet var textColor6: UITextField!
    @IBOutlet var textColor7: UITextField!
    @IBOutlet var textColor8: UITextField!
    @IBOutlet var textColor9: UITextField!
    var justOneAlert: Bool = false
    
    var color: [NSManagedObject] = []
    var existColorForPicker: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        let context = self.getContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Color")
        do {
            color = try context.fetch(fetchRequest)
        } catch let error as NSError{
            print("Could not fetch \(error), \(error.userInfo)")
        }
        if justOneAlert == false{
            let alert = UIAlertController(title: "주의하세요!", message: "색상과 과목명은 한 번 저장하면 바꿀 수 없습니다. *어플을 삭제 후 재 설치하면 바꿀 수 있습니다.(스케줄 내역은 유지됩니다)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            justOneAlert = true
        }
        
        
    

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
    @IBAction func buttonColorSave(_ sender: UIBarButtonItem) {
        
        textColor1.isUserInteractionEnabled = false
        textColor2.isUserInteractionEnabled = false
        textColor3.isUserInteractionEnabled = false
        textColor4.isUserInteractionEnabled = false
        textColor5.isUserInteractionEnabled = false
        textColor6.isUserInteractionEnabled = false
        textColor7.isUserInteractionEnabled = false
        textColor8.isUserInteractionEnabled = false
        textColor9.isUserInteractionEnabled = false
        
        let context = self.getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Color", in: context)
        let object = NSManagedObject(entity: entity!, insertInto: context)
        
        if textColor1.text != ""{
            object.setValue(textColor1.text, forKey: "color1")
            existColorForPicker += 1
        }
        if textColor2.text != ""{
            object.setValue(textColor2.text, forKey: "color2")
            existColorForPicker += 1
        }
        if textColor3.text != ""{
            object.setValue(textColor3.text, forKey: "color3")
            existColorForPicker += 1
        }
        if textColor4.text != ""{
            object.setValue(textColor4.text, forKey: "color4")
            existColorForPicker += 1
        }
        if textColor5.text != ""{
            object.setValue(textColor5.text, forKey: "color5")
            existColorForPicker += 1
        }
        if textColor6.text != ""{
            object.setValue(textColor6.text, forKey: "color6")
            existColorForPicker += 1
        }
        if textColor7.text != ""{
            object.setValue(textColor7.text, forKey: "color7")
            existColorForPicker += 1
        }
        if textColor8.text != ""{
            object.setValue(textColor8.text, forKey: "color8")
            existColorForPicker += 1
        }
        if textColor9.text != ""{
            object.setValue(textColor9.text, forKey: "color9")
            existColorForPicker += 1
        }
        
        
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError{
            print("Could not save \(error), \(error.userInfo)")
        }
        let alert = UIAlertController(title: "완료!", message: "색상이 적용되었습니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.existColorNumber = self.existColorForPicker
        
    }
    
    
    

    
    // MARK: - Navigation

//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
   // }
    

}
