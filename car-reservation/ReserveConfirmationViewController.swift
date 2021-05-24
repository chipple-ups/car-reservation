//
//  ReserveConfirmationViewController.swift
//  car-reservation
//
//  Created by 岡澤宏 on 2021/05/07.
//

import UIKit
import Firebase
import FirebaseUI

class ReserveConfirmationViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var nocLabel: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    
    var reserveusedate : String?
    var selectedplace : String?
    var usenoc : Int?
    var itemText : String?
    var userNameText : String?
    var selectednoc : Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        dateLabel.text = reserveusedate
        placeLabel.text = selectedplace
        //nocLabel.text = String(usenoc!)
        itemLabel.text = itemText
        
        
        
        
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
