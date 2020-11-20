//
//  PublishArticleViewController.swift
//  Publisher
//
//  Created by nono chan  on 2020/11/20.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class PublishArticleViewController: UIViewController {
    
    let db = Firestore.firestore()
    var ref : DocumentReference? = nil
    
    let date = Date()
    var today: String!

    let picker = UIPickerView()
    let myPickerData = ["SchoolLife","Beauty","Others"]
    
    @IBOutlet weak var categoryTextField: UITextField!{
        didSet{
            categoryTextField.layer.borderColor = UIColor.black.cgColor
            categoryTextField.layer.borderWidth = 1
        }
    }
    
    @IBOutlet weak var inputTextView: UITextView!{
        didSet{
            inputTextView.layer.borderColor = UIColor.black.cgColor
            inputTextView.layer.borderWidth = 1
        }
    }
    
    @IBOutlet weak var titleTextField: UITextField!{
        didSet{
            titleTextField.layer.borderColor = UIColor.black.cgColor
            titleTextField.layer.borderWidth = 1
        }
    }
    func navigationUI(){
        navigationController?.navigationBar.barTintColor = UIColor.systemIndigo
        navigationController?.navigationBar.tintColor = .white
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        categoryTextField.inputView = picker
        
        navigationUI()
        
    }
    @IBOutlet weak var sendButton: UIButton!{
        didSet{
            sendButton.layer.borderWidth = 1
            sendButton.layer.borderColor = UIColor.black.cgColor
        }
    }
    @IBAction func sendButton(_ sender: UIButton) {
        addArticle()
        
        self.navigationController?.popViewController(animated: true)
    }

    func addArticle() {
        
        let document = db.collection("articles").document()
        
        ref = db.collection("articles").addDocument(data: [
                                                        "author": [
                                                            "email": "wayne@school.appworks.tw",
                                                            "id": "waynechen323",
                                                            "name": "AKA小安老師"
                                                        ],
                                                        "content": (inputTextView.text ?? "0") as String,
                                                        "id": document.documentID,
                                                        "category": (categoryTextField.text ?? "0") as String,
                                                        "title": (titleTextField.text ?? "0") as String,
                                                        "created_time": NSDate().timeIntervalSince1970
        ]
        ) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(self.ref?.documentID ?? "9999")")
            }
        }
    }
    func getDate() {
        let timeStamp = date.timeIntervalSince1970
        let timeInterval = TimeInterval(timeStamp)
        
        let date = Date(timeIntervalSince1970: timeInterval)
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        
        today = dateFormatter.string(from: date)
    }
    

}

extension PublishArticleViewController :UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myPickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryTextField.text = myPickerData[row]
    }
}
