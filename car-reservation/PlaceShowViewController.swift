//
//  PlaceShowViewController.swift
//  car-reservation
//
//  Created by 岡澤宏 on 2021/05/08.
//

import UIKit
import Firebase
import FirebaseUI


class PlaceShowViewController: UIViewController {
    @IBOutlet weak var placename: UILabel!
    @IBOutlet weak var placeaddress: UILabel!
    @IBOutlet weak var placeinfo: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    
    
    var name : String?
    var info : String?
    var address : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(name!)
        placename.text = name
        placeinfo.text = info
        placeaddress.text = address
        
            
        

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
