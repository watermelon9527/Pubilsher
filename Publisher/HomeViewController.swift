//
//  ViewController.swift
//  Publisher
//
//  Created by nono chan  on 2020/11/20.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

struct Publisher{
    var articleTitle : String?
    var authorName:String?
    var category: String?
    var createdTime : Date?
    var articleContent: String?

}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var publishButton: UIButton!{
        didSet{
            publishButton.layer.cornerRadius = self.publishButton.frame.size.width/2.0
            publishButton.layer.masksToBounds = true

        }
    }
    @IBAction func publishButton(_ sender: UIButton) {
        performSegue(withIdentifier: "segue", sender: sender)
    }

    var dataList = [Publisher]()
    let db = Firestore.firestore()

    func getDocuments(){
        
        db.collection("articles").getDocuments { (querySnapshot, error) in
           if let querySnapshot = querySnapshot {
              for document in querySnapshot.documents {
//                 print(document.data())
//                let name = document.data()["author"]
//                print(name ?? "0")
                if let Title = document.data()["title"] as? String,
                   let Category = document.data()["category"] as? String,
                   let Content = document.data()["content"] as? String
                {
                    var data = Publisher()
                    data.articleTitle = Title
                    data.category = Category
                    data.articleContent = Content
                    self.dataList.append(data)
                }
//                if let Time = document.data()["created_time"] as? Date{
//                    var data = Publisher()
//                    data.createdTime = Time
//                    self.dataList.append(data)
//                }

              }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
           }
        }
    }
    
    func navigationUI(){
        navigationController?.navigationBar.barTintColor = UIColor.systemIndigo
        navigationController?.navigationBar.tintColor = .white
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationUI()
        getDocuments()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
}

extension HomeViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let data = dataList[indexPath.row]
        cell.titleLabel.text = data.articleTitle
 //       cell.timeLabel.text = (data.createdTime) as! String
        cell.categoryLabel.text = data.category
        cell.contentLabel.text = data.articleContent
        
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
            return UITableView.automaticDimension

    }
}
