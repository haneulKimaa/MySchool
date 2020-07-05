//
//  HomeViewController.swift
//  MySchool
//
//  Created by SWUCOMPUTER on 2020/07/03.
//  Copyright © 2020 SWUCOMPUTER. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var helloText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "homePage.png")!)
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        helloText.text = appdelegate.userName! + "님!좋은 하루 되세요!"
        // Do any additional setup after loading the view.
    }
    @IBAction func buttonLogout(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title:"로그아웃 하시겠습니까?",message: "",preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            let urlString: String = "http://condi.swu.ac.kr/student/T04/login/logout.php"
            guard let requestURL = URL(string: urlString) else { return }
            var request = URLRequest(url: requestURL)
            request.httpMethod = "POST"
            let session = URLSession.shared
            let task = session.dataTask(with: request) {
                (responseData, response, responseError) in
                guard responseError == nil else { return }
            }
        task.resume()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let schoolView = storyboard.instantiateViewController(withIdentifier: "selectSchoolView")
        schoolView.modalPresentationStyle = .fullScreen
        self.present(schoolView, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
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
