//
//  MemoDetailViewController.swift
//  MySchool
//
//  Created by SWUCOMPUTER on 2020/07/04.
//  Copyright © 2020 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class MemoDetailViewController: UIViewController {

    @IBOutlet var textTitle: UITextField!
    @IBOutlet var textMemo: UITextView!
    @IBOutlet var textDate: UITextField!
    
    var detailMemo: NSManagedObject?
    override func viewDidLoad() {
        super.viewDidLoad()

        if let memo = detailMemo{
            textTitle.text = memo.value(forKey: "title") as? String
            textMemo.text = memo.value(forKey: "memo") as? String
            let dbDate: Date? = memo.value(forKey: "saveDate") as? Date
            
            let formatter: DateFormatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd h:mm a"
            if let unwrapDate = dbDate{
                textDate.text = formatter.string(from: unwrapDate as Date)
            }
            
        }
        // Do any additional setup after loading the view.
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
