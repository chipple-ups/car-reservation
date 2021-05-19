//
//  ReservePlaceInfo.swift
//  car-reservation
//
//  Created by 岡澤宏 on 2021/05/17.
//

import UIKit
import Firebase

class ReservePlaceInfo: NSObject {
    //var id: String
    //var user: String?
    //var place: String?
    //var item: String?
    //var noc: String?
    //var date: Date?
    var placelist: [[String:Any]]? = []
    var place: String?
    var noc: Int?
    
    init(document: QueryDocumentSnapshot) {
        //self.id = document.documentID
        let postDic = document.data()
        //let timestamp = postDic["date"] as? Timestamp
        //self.date = timestamp?.dateValue()
        //self.user = postDic["user"] as? String
        //self.place = postDic["place"] as? String
        //self.item = postDic["item"] as? String
        //self.noc = postDic["noc"] as? String
        
        self.placelist = postDic["placelist"] as? [[String : Any]]
        self.place = postDic["place"] as? String
        self.noc = postDic["noc"] as? Int
        




}
}
