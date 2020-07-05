//
//  ViewController.swift
//  MySchool
//
//  Created by SWUCOMPUTER on 2020/07/03.
//  Copyright © 2020 SWUCOMPUTER. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet var labelStatus: UILabel!
    @IBOutlet var picerCollege: UIPickerView!
    @IBOutlet var textID: UITextField!
    @IBOutlet var textPassWord: UITextField!
    
    //학교 리스트
    let schoolArray: Array<String> = ["서울여자대학교", "건국대학교", "경기대학교", "경희대학교", "고려대학교", "광운대학교", "국민대학교"]
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return schoolArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return schoolArray[row]
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textID {
            textField.resignFirstResponder()
            self.textPassWord.becomeFirstResponder()
        }
        textField.resignFirstResponder()
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func buttonAddSchedule(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let addScheduleView = storyboard.instantiateViewController(withIdentifier: "insertScheduleView")
        addScheduleView.modalPresentationStyle = .automatic
        self.present(addScheduleView, animated: true, completion: nil)
    }
    
    //로그인 버튼 눌럿을 때 데이터 확인
    @IBAction func loginButton(_ sender: UIButton) {
        if textID.text == "" || textPassWord.text == ""{
            let alert = UIAlertController(title: "로그인 오류!", message: "아이디 또는 비밀번호가 입력되지 않았습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        else if textID.text != "" && textPassWord.text != ""{
            let urlString: String = "http://condi.swu.ac.kr/student/T04/login/loginUser.php"
            
            guard let requestURL = URL(string: urlString) else {
                return
            }
            self.labelStatus.text = " "
            
            var request = URLRequest(url: requestURL)
            request.httpMethod = "POST"
            let restString: String = "id=" + textID.text! + "&password=" + textPassWord.text!
            
            request.httpBody = restString.data(using: .utf8)

            let session = URLSession.shared
            let task = session.dataTask(with: request) { (responseData, response, responseError) in
                guard responseError == nil else {
                    print("Error: calling POST")
                    return
                }
            guard let receivedData = responseData else {
                print("Error: not receiving Data")
                return
                }
                do {
                    let response = response as! HTTPURLResponse
                    if !(200...299 ~= response.statusCode) {
                        print ("HTTP Error!")
                        return
                    }
                    guard let jsonData = try JSONSerialization.jsonObject(with: receivedData, options:.allowFragments) as? [String: Any] else {
                        print("JSON Serialization Error!")
                        return
                    }
                    
            guard let success = jsonData["success"] as? String else {
                print("Error: PHP failure(success)")
                return
                    }
            if success == "YES" {
                if let name = jsonData["name"] as? String {
                    DispatchQueue.main.async {
                    self.labelStatus.text = name + "님 안녕하세요?"
                    
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        //appDelegate.loginPrefix = self.loginPrefix.text
                        appDelegate.ID = self.textID.text
                        appDelegate.userName = name
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainView")
                    mainViewController.modalPresentationStyle = .fullScreen
                    self.present(mainViewController, animated: true, completion: nil)
                    }
                }
            } else {
                if let errMessage = jsonData["error"] as? String {
                    DispatchQueue.main.async {
                        self.labelStatus.text = errMessage
                        
                    }
                }
            }
                    } catch {
                        print("Error: \(error)")
                    }
                }
                task.resume()
        }
        
    }
    //캘린더를 직접 구현하려고 하였으나 다른 부분에 더 집중하기 위하여 아이폰 내부 기본 캘린더로 이동하도록 하였습니다.
    @IBAction func gotoCalendarApp(_ sender: UIButton) {
        let today = NSDate()
        gotoAppCalendar(date: today as Date)
    }
    func gotoAppCalendar(date: Date){
        let interval = date.timeIntervalSinceReferenceDate
        //let url = NSURL(string: "calshow:\(interval)")
        if let url = URL(string: "calshow:\(interval)"){
            if UIApplication.shared.canOpenURL(url){
                UIApplication.shared.open(url, options: [:])
            }
        }
    }
}

