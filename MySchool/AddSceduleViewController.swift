//
//  AddSceduleViewController.swift
//  MySchool
//
//  Created by SWUCOMPUTER on 2020/07/04.
//  Copyright © 2020 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class AddSceduleViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet var pickerSubject: UIPickerView!
    @IBOutlet var pickerDate: UIDatePicker!
    @IBOutlet var SegClassOrTask: UISegmentedControl!
    
    var subjects: [NSManagedObject] = []
    //var subject: NSManagedObject?
    var subjectArray: Array<String> = []
    var arrayForPicker: Array<String> = []
    var existColorNum: Int = 0
    var textType: String = ""
    var textDay: String = ""
    var myDate:String = ""
    func getContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    override func viewDidLoad() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.existColorNum = appDelegate.existColorNumber
        print("1")
        print("existColorNum\(existColorNum)")
        let context = self.getContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Color")
        do {
            subjects = try context.fetch(fetchRequest)
            print("2")
        } catch let error as NSError{
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
            let subject = subjects[0]
            print("2.5")
            if let textcolor = subject.value(forKey: "color1") as? String{
                subjectArray.append(textcolor)
            }
            if let textcolor = subject.value(forKey: "color2") as? String{
                subjectArray.append(textcolor)
            }
            if let textcolor = subject.value(forKey: "color3") as? String{
                subjectArray.append(textcolor)
            }
            if let textcolor = subject.value(forKey: "color4") as? String{
                subjectArray.append(textcolor)
            }
            if let textcolor = subject.value(forKey: "color5") as? String{
                subjectArray.append(textcolor)
            }
            if let textcolor = subject.value(forKey: "color6") as? String{
                subjectArray.append(textcolor)
            }
            if let textcolor = subject.value(forKey: "color7") as? String{
                subjectArray.append(textcolor)
            }
            if let textcolor = subject.value(forKey: "color8") as? String{
                subjectArray.append(textcolor)
            }
            if let textcolor = subject.value(forKey: "color9") as? String{
                subjectArray.append(textcolor)
                print("3")
            }
        for i in 0...subjectArray.count-1{
            if let existSubject = subjectArray[i] as? String{
                print("7")
                print(existSubject)
                arrayForPicker.append(existSubject)
            }
        }
            print("4")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayForPicker.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayForPicker[row]
    }
    @IBAction func typeSelect(_ sender: UISegmentedControl) {
        let typeArray: Array<String> = ["강의", "과제", "시험"]
        textType = typeArray[sender.selectedSegmentIndex]
        
    }
    @IBAction func buttonScheduleSave(_ sender: UIBarButtonItem) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .medium
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        textDay = dateFormatter.string(from: (self.pickerDate.date))
        print(textDay)
        
        
        let subjectText: String = arrayForPicker[self.pickerSubject.selectedRow(inComponent: 0)]
        
        let urlString: String = "http://condi.swu.ac.kr/student/T04/schedule/insertFavorite.php"
        guard let requestURL = URL(string: urlString) else { return }
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        guard let userID = appDelegate.ID else { return }
        
        
        myDate = dateFormatter.string(from: Date())
        print(myDate)
        
        var restString: String = "id=" + userID + "&subject=" + subjectText
        restString += "&classOrTask=" + textType
        restString += "&date=" + myDate
        restString += "&writeDate=" + textDay
        request.httpBody = restString.data(using: .utf8)
        print("aa")
        let session2 = URLSession.shared
        let task2 = session2.dataTask(with: request) { (responseData, response, responseError) in
            guard responseError == nil else { return }
            guard let receivedData = responseData else { return }
            if let utf8Data = String(data: receivedData, encoding: .utf8) { print(utf8Data) }
        }
        task2.resume()
        _ = self.navigationController?.popViewController(animated: true)
        
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
