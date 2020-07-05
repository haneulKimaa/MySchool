//
//  CreateAccountViewController.swift
//  MySchool
//
//  Created by SWUCOMPUTER on 2020/07/03.
//  Copyright © 2020 SWUCOMPUTER. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var labelStatus: UILabel!
    
    @IBOutlet var textName: UITextField!
    @IBOutlet var textID: UITextField!
    @IBOutlet var textPassword: UITextField!
    @IBOutlet var textRePassword: UITextField!
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textName {
            textField.resignFirstResponder()
            self.textID.becomeFirstResponder()
            if textName.placeholder == "이름을 입력하세요."{
                textName.attributedPlaceholder = NSAttributedString(string: "이름은 필수 입력사항입니다.", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            }
        }
        else if textField == textID{
            textField.resignFirstResponder()
            self.textPassword.becomeFirstResponder()
            if textID.placeholder == "ID를 입력하세요."{
                textID.attributedPlaceholder = NSAttributedString(string: "ID는 필수 입력사항입니다.", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            }
        }
        else if textField == textPassword{
            textField.resignFirstResponder()
            self.textRePassword.becomeFirstResponder()
            if textPassword.placeholder == "Password를 입력하세요."{
                textPassword.attributedPlaceholder = NSAttributedString(string: "Password는 필수 입력사항입니다.", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            }
        }
        textField.resignFirstResponder()
        
        return true
        
    }
    func executeRequest (request: URLRequest) ->Void{
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
        if let utf8Data = String(data: receivedData, encoding: .utf8){
            DispatchQueue.main.async { // for Main Thread Checker
                self.labelStatus.text = utf8Data
                print(utf8Data) // php에서 출력한 echo data가 debug 창에 표시됨
            }
        }
    }
        task.resume()
    }
    
    @IBAction func buttonJoin(_ sender: UIButton) {
        
        if textRePassword.placeholder == "Password를 한 번 더 입력하세요."{
            textRePassword.attributedPlaceholder = NSAttributedString(string: "Password 재 입력은 필수 입력사항입니다.", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        }
        if textPassword.placeholder != "Password를 입력하세요." && textRePassword.placeholder != "Password를 한 번 더 입력하세요." && textPassword.text != textRePassword.text {
            textRePassword.text = ""
            textRePassword.attributedPlaceholder = NSAttributedString(string: "Password가 다릅니다.", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            labelStatus.text = "비밀번호를 확인해주세요."
        }
        else if textPassword.placeholder != "Password를 입력하세요." && textRePassword.placeholder != "Password를 한 번 더 입력하세요." && textPassword.text == textRePassword.text{
            let urlString: String = "http://condi.swu.ac.kr/student/T04/login/insertUser.php"
            guard let requestURL = URL(string: urlString) else {
                return
            }
            var request = URLRequest(url: requestURL)
            request.httpMethod = "POST"
            let restString: String = "id=" + textID.text! + "&password=" + textRePassword.text! + "&name=" + textName.text!
            request.httpBody = restString.data(using: .utf8)
            self.executeRequest(request: request)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
