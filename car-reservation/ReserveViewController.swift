//
//  ReserveViewController.swift
//  car-reservation
//
//  Created by 岡澤宏 on 2021/05/01.
//

import UIKit
import Firebase


class ReserveViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var tableView: UITableView!
    
    var placelistArray: [myReserveInfo] = []
    var listener: ListenerRegistration?
    
    let inputDatePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

    }
        // データの数（＝セルの数）を返すメソッド
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return placelistArray.count
        }
    
    
    // 各セルの内容を返すメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let docRef = Firestore.firestore().collection(Const.CalendarPath).document("20210513")
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
        }
        // 再利用可能な cell を得る
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell3", for: indexPath)
        // Cellに値を設定する.  --- ここから ---
        let task = placelistArray[indexPath.row]
        cell.textLabel?.text = task.0001
        cell.detailTextLabel?.text = task.0001


        
        return cell
    }
    // 各セルを選択した時に実行されるメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

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
