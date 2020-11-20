//
//  ViewController.swift
//  Publisher
//
//  Created by nono chan  on 2020/11/20.
//

import UIKit
import Firebase

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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.systemIndigo
        navigationController?.navigationBar.tintColor = .white
        tableView.delegate = self
        tableView.dataSource = self
 
    

    }

}
extension HomeViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        } else {
            return 40
        }
    }
}
