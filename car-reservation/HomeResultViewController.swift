//
//  HomeResultViewController.swift
//  car-reservation
//
//  Created by 岡澤宏 on 2021/05/13.
//

import UIKit

class HomeResultViewController: UIViewController {
    @IBOutlet weak var mydate: UILabel!
    @IBOutlet weak var myplace: UILabel!
    @IBOutlet weak var mynoc: UILabel!
    @IBOutlet weak var myitem: UILabel!
    
    
    var date : String?
    var place : String?
    var noc : String?
    var item : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(place!)
        mydate.text = date
        myplace.text = place
        mynoc.text = noc
        myitem.text = item
        
        
        

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
