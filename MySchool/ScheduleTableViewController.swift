//
//  ScheduleTableViewController.swift
//  MySchool
//
//  Created by SWUCOMPUTER on 2020/07/04.
//  Copyright © 2020 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class ScheduleTableViewController: UITableViewController {

    @IBOutlet var textSubject: UILabel!
    @IBOutlet var textClassOrTask: UILabel!
    @IBOutlet var textDate: UILabel!
    @IBOutlet var addButton: UIBarButtonItem!
    
    var fetchedArray: [ScheduleData] = Array()
    var colors: [NSManagedObject] = []
    
    override func viewDidLoad() {
        
        /* color를 save하지 않은 채 누르면 오류가 생겨 비활성화처리를 시도했으나 작동되지 않음
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        super.viewDidLoad()
        
        if appDelegate.schedulePlusButtonEnable == 0{
            addButton.isEnabled = false
        }
        else{
            addButton.isEnabled = true
        }
 */
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchedArray = []
        self.downloadDataFromServer()
        
        let context = self.getContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Color")
        do {
            colors = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
            self.tableView.reloadData()
        
    }
    func downloadDataFromServer() -> Void {
        let urlString: String = "http://condi.swu.ac.kr/student/T04/schedule/favoriteTable.php"
        guard let requestURL = URL(string: urlString) else { return }
        let request = URLRequest(url: requestURL)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (responseData, response, responseError) in guard responseError == nil else { print("Error: calling POST"); return; }
            guard let receivedData = responseData else {
                print("Error: not receiving Data"); return;
            }
            let response = response as! HTTPURLResponse
            if !(200...299 ~= response.statusCode) { print("HTTP response Error!"); return }
            do {
                if let jsonData = try JSONSerialization.jsonObject (with: receivedData,
                options:.allowFragments) as? [[String: Any]] {
                for i in 0...jsonData.count-1 {
                    var newData: ScheduleData = ScheduleData()
                    var jsonElement = jsonData[i]
                    newData.scheduleno = jsonElement["scheduleno"] as! String
                    newData.userid = jsonElement["id"] as! String
                    newData.subject = jsonElement["subject"] as! String
                    newData.classOrTask = jsonElement["classOrTask"] as! String
                    newData.date = jsonElement["date"] as! String
                    newData.writeDate = jsonElement["writeDate"] as! String
                    self.fetchedArray.append(newData)
                }
                DispatchQueue.main.async { self.tableView.reloadData() }
                }
            } catch { print("Error: Catch") }
        }
        task.resume()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fetchedArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Schedule Cell", for: indexPath)

        let item = fetchedArray[indexPath.row]
        
        let color = colors[0]
        var justSubject: String = ""
        
        justSubject = item.subject
        
        
        cell.textLabel?.text = justSubject + "  " + item.classOrTask
        cell.detailTextLabel?.text = item.writeDate
        
        if justSubject == color.value(forKey: "color1") as? String{
            cell.contentView.backgroundColor = UIColor(red: 134/255, green: 227/255, blue: 206/255, alpha: 0.5)
        }
        if justSubject == color.value(forKey: "color2") as? String{
            cell.contentView.backgroundColor = UIColor(red: 208/255, green: 230/255, blue: 165/255, alpha: 0.5)
        }
        if justSubject == color.value(forKey: "color3") as? String{
            cell.contentView.backgroundColor = UIColor(red: 255/255, green: 221/255, blue: 149/255, alpha: 0.5)
        }
        if justSubject == color.value(forKey: "color4") as? String{
            cell.contentView.backgroundColor = UIColor(red: 250/255, green: 137/255, blue: 123/255, alpha: 0.5)
        }
        if justSubject == color.value(forKey: "color5") as? String{
            cell.contentView.backgroundColor = UIColor(red: 204/255, green: 171/255, blue: 218/255, alpha: 0.5)
        }
        if justSubject == color.value(forKey: "color6") as? String{
            cell.contentView.backgroundColor = UIColor(red: 250/255, green: 167/255, blue: 183/255, alpha: 0.5)
        }
        if justSubject == color.value(forKey: "color7") as? String{
            cell.contentView.backgroundColor = UIColor(red: 75/255, green: 44/255, blue: 39/255, alpha: 0.5)
        }
        if justSubject == color.value(forKey: "color8") as? String{
            cell.contentView.backgroundColor = UIColor(red: 97/255, green: 150/255, blue: 254/255, alpha: 0.5)
        }
        if justSubject == color.value(forKey: "color9") as? String{
            cell.contentView.backgroundColor = UIColor(red: 3/255, green: 27/255, blue: 137/255, alpha: 0.5)
        }
        
        
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toScheduleDetailView" {
            if let destination = segue.destination as? ScheduleDetailViewController {
                if let selectedIndex = self.tableView.indexPathsForSelectedRows?.first?.row {
                    let data = fetchedArray[selectedIndex]
                    destination.selectedData = data
                    destination.title = data.subject
            } }
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
