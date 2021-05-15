//
//  HomeViewController.swift
//  car-reservation
//
//  Created by 岡澤宏 on 2021/05/01.
//

import UIKit
import Firebase

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var myReserveArray: [myReserveInfo] = []
    var listener: ListenerRegistration?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
        
    // データの数（＝セルの数）を返すメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myReserveArray.count
    }
    // 各セルの内容を返すメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 再利用可能な cell を得る
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath)
        // Cellに値を設定する.  --- ここから ---
        let task = myReserveArray[indexPath.row]
        cell.textLabel?.text = task.place
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"

        let dateString:String = formatter.string(from: task.date!)
        cell.detailTextLabel?.text = dateString
        
        return cell
    }

    // 各セルを選択した時に実行されるメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ///performSegue(withIdentifier: "cellSegue0",sender: nil)
        print("didSelectRowAtが呼ばれた")
        print("myid")
        let homeResultViewController = storyboard!.instantiateViewController(withIdentifier: "home2") as! HomeResultViewController
        let task = myReserveArray[indexPath.row]
        //let mydate = task.date
        
        let myplace = task.place
        let mynoc = task.noc
        let myitem = task.item
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateString:String = formatter.string(from: task.date!)
        
        homeResultViewController.date = dateString
        homeResultViewController.place = myplace
        homeResultViewController.noc = mynoc
        homeResultViewController.item = myitem
        
            present(homeResultViewController, animated: true)
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("DEBUG_PRINT: viewWillAppear")
        
        // ログイン済みか確認
        if Auth.auth().currentUser != nil {
            
            let myid = Auth.auth().currentUser?.uid
            let calendar = Calendar(identifier: .gregorian)
            let startOfDayDate = calendar.startOfDay(for: Date())
            // listenerを登録して投稿データの更新を監視する
            let postsRef = Firestore.firestore().collection(Const.ReservePath).whereField("uid", isEqualTo: myid!).whereField("date", isGreaterThanOrEqualTo: startOfDayDate).order(by: "date", descending: false)
            ///
            listener = postsRef.addSnapshotListener() { (querySnapshot, error) in
                if let error = error {
                    print("DEBUG_PRINT: snapshotの取得が失敗しました。 \(error)")
                    return
                }
                // 取得したdocumentをもとにPostDataを作成し、postArrayの配列にする。
                self.myReserveArray = querySnapshot!.documents.map { document in
                    print("DEBUG_PRINT: document取得 \(document.documentID)")
                    let postData = myReserveInfo(document: document)
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
