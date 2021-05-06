//
//  LoginViewController.swift
//  car-reservation
//
//  Created by 岡澤宏 on 2021/05/01.
//

import UIKit
import Firebase
import SVProgressHUD

class LoginViewController: UIViewController {
    @IBOutlet weak var mailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBAction func handleLoginButton(_ sender: Any) {
        if let address = mailAddressTextField.text, let password = passwordTextField.text {

             // アドレスとパスワード名のいずれかでも入力されていない時は何もしない
             if address.isEmpty || password.isEmpty {
                 return
             }

            // HUDで処理中を表示
            SVProgressHUD.show()
            
             Auth.auth().signIn(withEmail: address, password: password) { authResult, error in
                 if let error = error {
                     print("DEBUG_PRINT: " + error.localizedDescription)
                    SVProgressHUD.showError(withStatus: "サインインに失敗しました。")
                     return
                 }
                 print("DEBUG_PRINT: ログインに成功しました。")
                
                // HUDを消す
                SVProgressHUD.dismiss()

                 // 画面を閉じてタブ画面に戻る
                 self.dismiss(animated: true, completion: nil)
             }
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
