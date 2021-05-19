//
//  ReserveViewController.swift
//  car-reservation
//
//  Created by 岡澤宏 on 2021/05/01.
//

import UIKit
import Firebase

class ReserveViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var placelistArray: [ReservePlaceInfo] = []
    var listener: ListenerRegistration?
    var placelistCount: Int = 0
    

    
    @IBAction func datePicker(_ sender: UIDatePicker) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let myinputDatePicker = formatter.string(from: sender.date)
        
        print(myinputDatePicker)
    
        let docRef = Firestore.firestore().collection(Const.CalendarPath).document(myinputDatePicker)
        docRef.getDocument { (document, error) in
            // ドキュメントがあれば
            if let document = document, document.exists {
                
                //データを、[String:[NSArray]]の形で取得
                let data = document.data() as! [String:[NSArray]]
                // placelistの件数
                self.placelistCount = data["placelist"]!.count
                print(document.data()!)
                
                

                //placelistArray = document.data([[String : Any]])
                
                //テーブルビューを再表示
                self.tableView.reloadData()
                
            } else {
                self.placelistCount = 0
                print("Document does not exist")
                self.tableView.reloadData()
            }
        }
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    
    
        // データの数（＝セルの数）を返すメソッド
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 
            if placelistCount == 0{
                print(placelistCount)
                return 0
            } else {
                print(placelistCount)
                return placelistCount
        }
        }
    
    
        // 各セルの内容を返すメソッド
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            // 再利用可能な cell を得る
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell3", for: indexPath)
            // Cellに値を設定する.  --- ここから ---
            let task = placelistArray[indexPath.row]
            //cell.textLabel?.text = task.placelist: [[String:Any]]?
            
            return cell
        }
        // 各セルを選択した時に実行されるメソッド
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        }

    
        override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("DEBUG_PRINT: viewWillAppear")
        // ログイン済みか確認
        if Auth.auth().currentUser != nil {
            // listenerを登録して投稿データの更新を監視する
            let postsRef = Firestore.firestore().collection(Const.CalendarPath)
            listener = postsRef.addSnapshotListener() { (querySnapshot, error) in
                if let error = error {
                    print("DEBUG_PRINT: snapshotの取得が失敗しました。 \(error)")
                    return
                }
                self.placelistArray = querySnapshot!.documents.map { document in
                    print("DEBUG_PRINT: document取得 \(document.documentID)")
                    let postData = ReservePlaceInfo(document: document)
                    return postData
                }
                // TableViewの表示を更新する
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("DEBUG_PRINT: viewWillDisappear")
        // listenerを削除して監視を停止する
        listener?.remove()
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
