//
//  PlaceViewController.swift
//  car-reservation
//
//  Created by 岡澤宏 on 2021/05/01.
//

import UIKit
import Firebase

class PlaceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var placeArray: [PlaceInfo] = []
    var listener: ListenerRegistration?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        
        // カスタムセルを登録する
        //let nib = UINib(nibName: "PostTableViewCell", bundle: nil)
        //tableView.register(nib, forCellReuseIdentifier: "Cell")
    }
    
    //　データの数（セルの数）を返すメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return placeArray.count
        
    }
    
    //　各セルの内容を返すメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        // 再利用可能な cell を得る
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        // Cellに値を設定する.  --- ここから ---
        let task = placeArray[indexPath.row]
        cell.textLabel?.text = task.name
        
        return cell
    }
    // 各セルを選択した時に実行されるメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ///performSegue(withIdentifier: "cellSegue",sender: nil)
        print("didSelectRowAtが呼ばれた")
        let placeShowViewController = storyboard!.instantiateViewController(withIdentifier: "Cell") as! PlaceShowViewController
        let task = placeArray[indexPath.row]
        let placename = task.name
        let placeinfo = task.info
        let placeaddress = task.address
        placeShowViewController.name = placename
        placeShowViewController.info = placeinfo
        placeShowViewController.address = placeaddress
        
            present(placeShowViewController, animated: true)
        
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("DEBUG_PRINT: viewWillAppear")
        // ログイン済みか確認
        if Auth.auth().currentUser != nil {
            // listenerを登録して投稿データの更新を監視する
            let postsRef = Firestore.firestore().collection(Const.PlacePath).order(by: "name", descending: true)
            listener = postsRef.addSnapshotListener() { (querySnapshot, error) in
                if let error = error {
                    print("DEBUG_PRINT: snapshotの取得が失敗しました。 \(error)")
                    return
                }
                // 取得したdocumentをもとにPostDataを作成し、postArrayの配列にする。
                self.placeArray = querySnapshot!.documents.map { document in
                    print("DEBUG_PRINT: document取得 \(document.documentID)")
                    let postData = PlaceInfo(document: document)
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
