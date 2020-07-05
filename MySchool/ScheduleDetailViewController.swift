//
//  ScheduleDetailViewController.swift
//  MySchool
//
//  Created by SWUCOMPUTER on 2020/07/05.
//  Copyright © 2020 SWUCOMPUTER. All rights reserved.
//

import UIKit

class ScheduleDetailViewController: UIViewController {

    @IBOutlet var dayText: UILabel!
    @IBOutlet var writeDateText: UILabel!
    @IBOutlet var typeText: UILabel!
    @IBOutlet var subjectText: UILabel!
    
    var selectedData: ScheduleData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let scheduleData = selectedData else {
            return
        }
        subjectText.text = scheduleData.subject
        typeText.text = scheduleData.classOrTask
        writeDateText.text = "기한 : " + scheduleData.writeDate
        dayText.text = "작성 날짜 : " + scheduleData.date
        // Do any additional setup after loading the view.
    }
    @IBAction func buttonDelete(_ sender: UIButton) {
        let alert=UIAlertController(title:"정말 삭제 하시겠습니까?", message: "",preferredStyle:.alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .cancel, handler: { action in
            let urlString: String = "http://condi.swu.ac.kr/student/T04/schedule/deleteFavorite.php"
            guard let requestURL = URL(string: urlString) else { return }
            var request = URLRequest(url: requestURL)
            request.httpMethod = "POST"
            guard let scheduleNO = self.selectedData?.scheduleno else { return }
            let restString: String = "scheduleno=" + scheduleNO
            request.httpBody = restString.data(using: .utf8)
            let session = URLSession.shared
            let task = session.dataTask(with: request) { (responseData, response, responseError) in
                guard responseError == nil else { return }
                guard let receivedData = responseData else { return }
                if let utf8Data = String(data: receivedData, encoding: .utf8) { print(utf8Data) }
            }
            task.resume()
            self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(alert, animated: true)
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
